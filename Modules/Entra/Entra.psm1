function Connect-M365EntraID {
    Connect-MgGraph -Scopes "Directory.Read.All", "User.Read.All" -WarningAction SilentlyContinue
}

function Get-M365EntraIDContext {
    Write-Host "Microsoft Entra ID"

    # Captura o contexto de autenticação ativo do Graph
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