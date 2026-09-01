function Show-ExchangeMenu {
    # Garante que a conexão com o Exchange seja feita ao entrar no submenu
    Connect-M365Exchange

    $ExitSubmenu = $false

    while (-not $ExitSubmenu) {
        Clear-Console
        Show-Banner
        
        # Exibe as informações da conexão ativa com o Exchange Online
        Get-M365ExchangeContext

        Write-Host "--- Gerenciamento Exchange Online ---" -ForegroundColor Cyan
        Write-Host ""
        Write-Host " [1] Listar todas as caixas de correio (Mailboxes)"
        Write-Host ""
        Write-Host " [0] Voltar ao menu principal"
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan

        $Choice = Read-MenuOption

        switch ($Choice) {
            "1" {
                Get-M365Mailboxes
                Wait-Console
            }
            "0" {
                $ExitSubmenu = $true
            }
            default {
                Write-WarningMessage "Opção inválida. Tente novamente."
                Wait-Console
            }
        }
    }
}