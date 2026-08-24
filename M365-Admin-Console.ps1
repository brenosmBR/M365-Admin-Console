# Importa o módulo Core
Import-Module "$PSScriptRoot\Modules\Core.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Graph.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Exchange.psm1" -Force
Import-Module "$PSScriptRoot\Modules\Teams.psm1" -Force

# Carrega os arquivos da interface
. "$PSScriptRoot\UI\Banner.ps1"
. "$PSScriptRoot\UI\Menu.ps1"
. "$PSScriptRoot\Console\Console.ps1"

# Exibe a interface
Start-Console