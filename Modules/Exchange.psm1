function Connect-M365Exchange {
    Connect-ExchangeOnline -ShowBanner:$false
}

function Get-M365ExchangeContext {
    # SilentlyContinue evita erros em vermelho na tela caso não haja conexão ativa
    $Context = Get-ConnectionInformation -ErrorAction SilentlyContinue

    Write-Host "Exchange Online"

    if ($Context) {
        # Pega o último registro caso haja múltiplos contextos abertos na sessão
        $ActiveContext = $Context | Select-Object -Last 1

        Write-Host "Conta: $($ActiveContext.UserPrincipalName)"
        Write-Success "Status: Conectado"
    } else {
        Write-WarningMessage "Status: Desconectado"
    }
}

Export-ModuleMember -Function *