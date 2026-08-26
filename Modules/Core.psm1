# ==========================================
# Funções de Leitura e Controle do Console
# ==========================================

function Read-MenuOption {
    return Read-Host "Escolha uma opção"
}

function Wait-Console {
    Read-Host "Pressione ENTER para continuar..."
}

function Clear-Console {
    Clear-Host
}

# ==========================================
# Funções Utilitárias de Mensagens com Cores
# ==========================================

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

    Write-Host $Message -ForegroundColor Yellow
}

function Write-ErrorMessage {
    param(
        [string]$Message
    )

    Write-Host $Message -ForegroundColor Red
}

# ==========================================
# Inicialização & Autenticação Centralizada
# ==========================================

function Initialize-M365Session {
    Write-Info "Verificando sessão ativa do Microsoft 365..."

    # Consulta o contexto atual do Graph
    $Context = Get-MgContext -ErrorAction SilentlyContinue

    if ($Context -and $Context.Account) {
        Write-Success "Sessão detectada: $($Context.Account) (Tenant: $($Context.TenantId))"
    } else {
        Write-WarningMessage "Nenhuma sessão ativa encontrada. Conectando ao Microsoft Graph..."
        Connect-MgGraph -Scopes "Directory.Read.All", "User.Read.All" -WarningAction SilentlyContinue | Out-Null

        # Valida se o login foi concluído com sucesso
        $Context = Get-MgContext -ErrorAction SilentlyContinue
        if ($Context -and $Context.Account) {
            Write-Success "Autenticação realizada com sucesso: $($Context.Account)"
        } else {
            Write-ErrorMessage "Falha na autenticação. Algumas funcionalidades podem não funcionar."
        }
    }
}

Export-ModuleMember -Function *