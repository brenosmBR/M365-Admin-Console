# Importa o módulo Core e os submódulos do M365
Import-Module "$PSScriptRoot\Modules\Core.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Graph.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Exchange.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Teams.psm1" -Force
Import-Module "$PSScriptRoot\Modules\SharePoint.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Entra.psm1" -Force

# Carrega os arquivos da interface
. "$PSScriptRoot\UI\Banner.ps1"
. "$PSScriptRoot\UI\Menu.ps1"
. "$PSScriptRoot\Console\Console.ps1"
. "$PSScriptRoot\Console\GraphMenu.ps1"

# 1. Exibe o banner inicial com a branch dinâmica
Show-Banner

# 2. Executa a checagem/conexão automática de autenticação
Initialize-M365Session
Wait-Console

# 3. Inicia o loop do menu do console
Start-Console