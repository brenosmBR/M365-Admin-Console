function Connect-M365Exchange {
    try {
        Write-Info "Preparando o módulo do Exchange Online..."
        
        # Garante que o módulo seja carregado na memória ANTES de tentar conectar
        Import-Module ExchangeOnlineManagement -ErrorAction Stop
        
        # Tenta disparar a janela de login
        Connect-ExchangeOnline -ShowBanner:$false -ErrorAction Stop
        
    }
    catch {
        # Se algo falhar, exibe o erro e PAUSA, impedindo que o Clear-Console apague a mensagem!
        Write-ErrorMessage "Falha ao iniciar a conexão com o Exchange: $_"
        Wait-Console
    }
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

function Get-M365Mailboxes {
    Write-Info "Consultando caixas de correio de usuários no Exchange Online..."
    
    try {
        # Busca todas as caixas de correio do tipo "UserMailbox" (caixas de usuários normais)
        $Mailboxes = Get-EXOMailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited -ErrorAction Stop
        
        if ($Mailboxes) {
            Write-Host ""
            # Formata a saída em uma tabela limpa
            $Mailboxes | Select-Object `
                @{Name = "Nome"; Expression = { $_.DisplayName } },
                @{Name = "E-mail Principal"; Expression = { $_.PrimarySmtpAddress } },
                @{Name = "Alias"; Expression = { $_.Alias } } | 
                Format-Table -AutoSize
            Write-Host ""

            Write-Success "Consulta finalizada. Total de caixas listadas: $($Mailboxes.Count)."
        } else {
            Write-WarningMessage "Nenhuma caixa de correio de usuário foi encontrada."
        }
    } catch {
        Write-ErrorMessage "Falha ao consultar caixas de correio: $_"
    }
}

Export-ModuleMember -Function *