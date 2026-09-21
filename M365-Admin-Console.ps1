# Importa o módulo Core e os submódulos do M365
. "$PSScriptRoot\Modules\Core\Core.psm1"

. "$PSScriptRoot\Modules\Entra\Entra.psm1"
. "$PSScriptRoot\Modules\Entra\EntraMenu.ps1"

. "$PSScriptRoot\Modules\Exchange\Exchange.psm1"
. "$PSScriptRoot\Modules\Exchange\ExchangeMenu.ps1"

. "$PSScriptRoot\Modules\Graph\Graph.psm1"
. "$PSScriptRoot\Modules\Graph\GraphMenu.ps1"

. "$PSScriptRoot\Modules\Sharepoint\SharePoint.psm1"
. "$PSScriptRoot\Modules\Sharepoint\SharePointMenu.ps1"

. "$PSScriptRoot\Modules\Teams\Teams.psm1"
. "$PSScriptRoot\Modules\Teams\TeamsMenu.ps1"

. "$PSScriptRoot\Modules\Settings\SettingsMenu.ps1"

# Carrega os arquivos da interface
. "$PSScriptRoot\UI\Banner.ps1"
. "$PSScriptRoot\UI\Menu.ps1"
. "$PSScriptRoot\Console\Console.ps1"

# 1. Exibe o banner inicial com a branch dinâmica
Show-Banner

# 2. Executa a checagem/conexão automática de autenticação
Initialize-M365Session
Wait-Console

# 3. Inicia o loop do menu do console
Start-Console