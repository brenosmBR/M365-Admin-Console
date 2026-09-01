function Start-Console {
    $ExitConsole = $false

    while (-not $ExitConsole) {
        Clear-Console
        Show-Banner
        Show-Menu

        $Option = Read-MenuOption

        switch ($Option) {
            "1" {
                Show-GraphMenu
            }
            "2" {
                Show-ExchangeMenu
            }
            "3" {
                Clear-Console
                Show-Banner
                Get-M365TeamsContext
                Wait-Console
            }
            "4" {
                Clear-Console
                Show-Banner
                Get-M365SharePointContext
                Wait-Console
            }
            "5" {
                Clear-Console
                Show-Banner
                Get-M365EntraContext
                Wait-Console
            }
            "9" {
                Write-Info "Módulo de Configurações em desenvolvimento."
                Wait-Console
            }
            "0" {
                Write-Info "Saindo do M365 Admin Console..."
                $ExitConsole = $true
            }
            default {
                Write-WarningMessage "Opção inválida. Tente novamente."
                Wait-Console
            }
        }
    }
}