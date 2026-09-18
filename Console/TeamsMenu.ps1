function Show-TeamsMenu {
    $ExitSubmenu = $false

    while (-not $ExitSubmenu) {
        Clear-Console
        Show-Banner
        
        # Exibe as informações do contexto ativo do Teams
        Get-M365TeamsContext

        Write-Host "--- Gerenciamento Microsoft Teams ---" -ForegroundColor Cyan
        Write-Host ""
        Write-Host " [1] Listar equipes (Em desenvolvimento)"
        Write-Host ""
        Write-Host " [0] Voltar ao menu principal"
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Cyan

        $Choice = Read-MenuOption

        switch ($Choice) {
            "1" {
                Write-Info "A funcionalidade de listar equipes será implementada na próxima etapa."
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