function Start-Console {

    $Running = $true

    while ($Running) {
        Show-Banner
        Show-Menu

        $Option = Read-MenuOption

        switch ($Option) {
            1 {
                Connect-M365Graph
                Clear-Console
                Get-M365GraphContext
            }

            2 {
                Connect-M365Exchange
                Clear-Console
                Get-M365ExchangeContext
            }

            3 {
                Connect-M365Teams
                Clear-Console
                Get-M365TeamsContext
            }

            4 {
                Write-Info "SharePoint Online em desenvolvimento."
            }

            5 {
                Write-Info "Microsoft Entra ID em desenvolvimento."
            }

            9 {
                Write-Info "Configurações em desenvolvimento."
            }

            0 {
                Write-Info "Saindo do console..."
                $Running = $false
            }

            Default {
                Write-WarningMessage "Opção inválida. Por favor, escolha uma opção válida."
            }
        }

        if ($Running) {
            Wait-Console
        }
    }
}