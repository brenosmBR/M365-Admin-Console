function Connect-M365SharePoint {
    Connect-SPOService -WarningAction SilentlyContinue
}

function Get-M365SharePointContext {
    Write-Host "SharePoint Online"

    # Captura o contexto de autenticação ativo na sessão do PowerShell
    $Context = Get-MgContext -ErrorAction SilentlyContinue

    if ($Context -and $Context.Account) {
        Write-Host "Conta: $($Context.Account)"
        Write-Host "Tenant ID: $($Context.TenantId)"
        Write-Success "Status: Conectado"
    } else {
        Write-WarningMessage "Status: Desconectado"
    }
}

Export-ModuleMember -Function *