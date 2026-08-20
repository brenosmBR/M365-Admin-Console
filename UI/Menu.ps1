function Show-Menu {

    $MenuItems = @(
        [PSCustomObject]@{
            Id   = 1
            Name = "Microsoft Graph"
        },

        [PSCustomObject]@{
            Id   = 2
            Name = "Exchange Online"
        },

        [PSCustomObject]@{
            Id   = 3
            Name = "Microsoft Teams"
        },

        [PSCustomObject]@{
            Id   = 4
            Name = "SharePoint Online"
        },

        [PSCustomObject]@{
            Id   = 5
            Name = "Microsoft Entra ID"
        },

        [PSCustomObject]@{
            Id   = 6
            Name = "Onboarding"
        },

        [PSCustomObject]@{
            Id   = 7
            Name = "Offboarding"
        }
    )

    foreach ($Item in $MenuItems) {

        Write-Host (" [{0}] {1}" -f $Item.Id, $Item.Name)
        Write-Host ""

    }

    Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
    Write-Host ""

    Write-Host " [9] Configuracoes"
    Write-Host ""

    Write-Host " [0] Sair"
    Write-Host ""

    Write-Host "============================================================" -ForegroundColor Cyan
}