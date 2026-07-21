# Importa o módulo Core
Import-Module "$PSScriptRoot\Modules\Core.psm1" -Force

# Carrega os arquivos da interface
. "$PSScriptRoot\UI\Banner.ps1"
. "$PSScriptRoot\UI\Menu.ps1"

# Exibe a interface
Show-Banner
Show-Menu