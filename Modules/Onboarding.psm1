#Esta parte tem como função conectar novos funcionarios
#a suas devidas caixas de email e sharepoints baseado no departamento que ele pertence



function Connect-M365Modules {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory = $true)]
        [string]$SharePointAdminUrl
    )

    $requiredModules = @(
        'ExchangeOnlineManagement',
        'Microsoft.Online.SharePoint.PowerShell'
    )

    foreach ($module in $requiredModules) {
        if (-not (Get-Module -ListAvailable -Name $module)) {
            throw "O módulo '$module' não está instalado. Instale-o antes de executar a automação."
        }
    }

    try {
        Import-Module ExchangeOnlineManagement -Force
        Import-Module Microsoft.Online.SharePoint.PowerShell -Force

        Connect-ExchangeOnline -Credential $Credential -ShowBanner:$false
        Connect-SPOService -Url $SharePointAdminUrl -Credential $Credential

        Write-Host "Conectado ao Exchange Online e ao SharePoint Online com sucesso." -ForegroundColor Green
    }
    catch {
        throw "Falha ao conectar aos serviços do Microsoft 365: $($_.Exception.Message)"
    }
}

function New-DepartmentAccess {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [System.Management.Automation.PSCredential]$Credential,

        [Parameter(Mandatory = $true)]
        [string]$UserPrincipalName,

        [Parameter(Mandatory = $true)]
        [string]$DepartmentName,

        [Parameter(Mandatory = $true)]
        [string]$DepartmentMailbox,

        [Parameter(Mandatory = $true)]
        [string]$SharePointAdminUrl,

        [Parameter(Mandatory = $true)]
        [string]$SharePointSiteUrl,

        [string]$SharePointGroup = "$DepartmentName Members",

        [switch]$CreateDepartmentMailboxIfMissing
    )

    if (-not $UserPrincipalName.Contains('@')) {
        throw "O valor de UserPrincipalName deve ser um e-mail válido."
    }

    try {
        Connect-M365Modules -Credential $Credential -SharePointAdminUrl $SharePointAdminUrl

        $userMailbox = Get-Mailbox -Identity $UserPrincipalName -ErrorAction Stop

        $sharedMailbox = Get-Mailbox -Identity $DepartmentMailbox -ErrorAction SilentlyContinue
        if (-not $sharedMailbox) {
            if ($CreateDepartmentMailboxIfMissing) {
                $mailboxAlias = ($DepartmentMailbox.Split('@'))[0]
                New-Mailbox -Shared -Name $DepartmentName -Alias $mailboxAlias -PrimarySmtpAddress $DepartmentMailbox | Out-Null
                Write-Host "Caixa compartilhada '$DepartmentMailbox' criada com sucesso." -ForegroundColor Yellow
            }
            else {
                throw "A caixa compartilhada '$DepartmentMailbox' não foi encontrada."
            }
        }

        $mailboxPermissions = Get-MailboxPermission -Identity $DepartmentMailbox -User $UserPrincipalName -ErrorAction SilentlyContinue
        if (-not $mailboxPermissions) {
            Add-MailboxPermission -Identity $DepartmentMailbox -User $UserPrincipalName -AccessRights FullAccess -InheritanceType All | Out-Null
            Write-Host "Acesso FullAccess concedido para $UserPrincipalName na caixa '$DepartmentMailbox'." -ForegroundColor Green
        }

        $sendAsPermission = Get-RecipientPermission -Identity $DepartmentMailbox -Trustee $UserPrincipalName -ErrorAction SilentlyContinue
        if (-not $sendAsPermission) {
            Add-RecipientPermission -Identity $DepartmentMailbox -Trustee $UserPrincipalName -AccessRights SendAs -Confirm:$false | Out-Null
            Write-Host "Permissão SendAs concedida para $UserPrincipalName na caixa '$DepartmentMailbox'." -ForegroundColor Green
        }

        $calendarPermission = Get-MailboxFolderPermission -Identity "$DepartmentMailbox:\Calendar" -User $UserPrincipalName -ErrorAction SilentlyContinue
        if (-not $calendarPermission) {
            Add-MailboxFolderPermission -Identity "$DepartmentMailbox:\Calendar" -User $UserPrincipalName -AccessRights Reviewer | Out-Null
            Write-Host "Permissão de leitura do calendário concedida para $UserPrincipalName." -ForegroundColor Green
        }

        $site = Get-SPOSite -Identity $SharePointSiteUrl -ErrorAction Stop

        $spUser = Get-SPOUser -Site $SharePointSiteUrl -LoginName $UserPrincipalName -ErrorAction SilentlyContinue
        if (-not $spUser) {
            Add-SPOUser -Site $SharePointSiteUrl -LoginName $UserPrincipalName -Group $SharePointGroup | Out-Null
            Write-Host "Usuário adicionado ao grupo '$SharePointGroup' no SharePoint: $SharePointSiteUrl" -ForegroundColor Green
        }
        else {
            Write-Host "Usuário já possui acesso ao SharePoint: $SharePointSiteUrl" -ForegroundColor Yellow
        }

        try {
            $userAlias = $UserPrincipalName.Split('@')[0]
            Set-ADUser -Identity $userAlias -Department $DepartmentName -ErrorAction SilentlyContinue
        }
        catch {
            Write-Host "Não foi possível atualizar o campo 'Department' do usuário local. Isso pode ser opcional em ambientes cloud-only." -ForegroundColor Yellow
        }

        [pscustomobject]@{
            UserPrincipalName = $UserPrincipalName
            Department = $DepartmentName
            DepartmentMailbox = $DepartmentMailbox
            SharePointSite = $SharePointSiteUrl
            SharePointGroup = $SharePointGroup
            Status = 'Concluido'
        }
    }
    catch {
        throw "Erro ao incluir o usuário no departamento: $($_.Exception.Message)"
    }
    finally {
        try {
            Disconnect-ExchangeOnline -Confirm:$false
        }
        catch {}

        try {
            Disconnect-SPOService
        }
        catch {}
    }
}

Export-ModuleMember -Function 'Connect-M365Modules', 'New-DepartmentAccess'
