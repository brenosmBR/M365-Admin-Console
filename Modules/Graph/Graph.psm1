function Connect-M365Graph {
    Connect-MgGraph -NoWelcome
}

function Get-M365GraphContext {
    $Context = Get-MgContext

    Write-Host "Microsoft Graph"

    if ($Context) {
        Write-Host "Conta: $($Context.Account)"
        Write-Host "Tenant ID: $($Context.TenantId)"
        Write-Host "Tipo de autenticação: $($Context.AuthType)"
        Write-Success "Status: Conectado"
    } else {
        Write-WarningMessage "Status: Desconectado"
    }
}

function Get-M365Users {
    Write-Info "Consultando todos os usuários no Microsoft Entra ID (Graph)..."

    try {
        # Formatando a saída em uma tabela limpa para o console
        $Users = Get-MgUser -All -Property "DisplayName,UserPrincipalName,Department,AccountEnabled" -ErrorAction Stop

        if ($Users) {
            Write-Host ""
            # Formatando a saída em uma tabela limpa para o console
            $Users | Select-Object `
                @{Name="Nome"; Expression={$_.DisplayName}},
                @{Name="E-mail (UPN)"; Expression={$_.UserPrincipalName}},
                @{Name="Departamento"; Expression={$_.Department}},
                @{Name="Status"; Expression={if($_.AccountEnabled) { "Ativo" } else { "Bloqueado" }}} | 
                Format-Table -AutoSize
            Write-Host ""
            
            Write-Success "Consulta finalizada. Total de usuários listados: $($Users.Count)."
        } else {
            Write-WarningMessage "Nenhum usuário foi encontrado no Tenant."
        }
    } catch {
        Write-ErrorMessage "Falha ao consultar usuários: $_"
    }
}

Export-ModuleMember -Function *