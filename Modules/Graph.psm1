function Connect-M365Graph {
    Connect-MgGraph -NoWelcome
}

function Get-M365GraphContext {
    $Context = Get-MgContext

    Write-Host "Microsoft Graph"

    if ($Context) {
        Write-Host "Conta: $($Context.Account)"
        Write-Host "Tenant ID: $($Context.TenantId)"
        Write-Host "Tipo de autenticação: $($Context.AuthType)"
        Write-Success "Status: Conectado"
    } else {
        Write-WarningMessage "Status: Desconectado"
    }
}

Export-ModuleMember -Function *