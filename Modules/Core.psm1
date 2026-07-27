function Read-MenuOption {

}

function Pause-Console {
    Read-Host "Pressione ENTER para continuar..."
}

function Clear-Console {
    Clear-Host
}

function Write-Info {
    param(
        [string]$Message
    )

    Write-Host $Message -ForegroundColor Cyan
}

function Write-Success {
    param(
        [string]$Message
    )

    Write-Host $Message -ForegroundColor Green
}

function Write-WarningMessage {
    param(
        [string]$Message
    )

    write-Host $Message -ForegroundColor Yellow
}

function Write-ErrorMessage {
    param(
        [string]$Message
    )

    Write-Host $Message -ForegroundColor Red
}

Export-ModuleMember -Function *