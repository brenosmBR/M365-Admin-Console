function Connect-M365Teams {
    Connect-MicrosoftTeams -WarningAction SilentlyContinue
}

function Get-M365TeamsContext {
    # Captura o contexto de autenticação ativo na sessão do PowerShell
    $Context = Get-MgContext -ErrorAction SilentlyContinue

    Write-Host "Microsoft Teams"

    if ($Context -or $Context.Account) {
        Write-Host "Conta: $($Context.Account)"
        Write-Host "Tenant ID: $($Context.TenantId)"
        Write-Success "Status: Conectado"
    } else {
        Write-WarningMessage "Status: Desconectado"
    }
}

Export-ModuleMember -Function *