function Show-EntraMenu {
    $ExitSubmenu = $false

    while (-not $ExitSubmenu) {
        Clear-Console
        Show-Banner
        
        # Exibe as informações do contexto ativo do Entra ID / Graph
        Get-M365GraphContext

        Write-Host "--- Gerenciamento Microsoft Entra ID ---" -ForegroundColor Cyan
        Write-Host ""
        Write-Host " [1] Listar todos os usuários"
        Write-Host ""
        Write-Host " [0] Voltar ao menu principal"
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan

        $Choice = Read-MenuOption

        switch ($Choice) {
            "1" {
                Get-M365Users
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