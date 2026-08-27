# Microsoft 365 Admin Console

Console administrativo em PowerShell para facilitar a conexão e administração dos principais serviços do Microsoft 365.

## Objetivo

Centralizar em um único console as conexões e ferramentas utilizadas diariamente por administradores de ambientes Microsoft 365.

## Funcionalidades

- Conectar ao Microsoft Graph
- Conectar ao Exchange Online
- Conectar ao Microsoft Teams
- Conectar ao SharePoint Online
- Gerenciar sessões ativas
- Atualizar módulos PowerShell
- Executar tarefas administrativas

## Estrutura do Projeto

```
M365-Admin-Console
│
├── Assets
├── Config
├── Modules
├── Scripts
├── M365-Admin-Console.ps1
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## Requisitos

- Windows PowerShell 5.1 ou PowerShell 7+
- Microsoft Graph PowerShell SDK
- ExchangeOnlineManagement
- MicrosoftTeams
- PnP.PowerShell

## Download e Uso

O console é portátil e não exige instalação complexa. Para começar a utilizar:

1. **Baixe a versão mais recente:**
🔗 [Baixar Última Versão (ZIP)](https://github.com/brenosmBR/M365-Admin-Console/releases/latest)

2. Extraia o conteúdo do arquivo `.zip` em um diretório da sua preferência (ex: `C:\Scripts\M365-Admin-Console`).
3. Abra o seu terminal do PowerShell e execute o script principal:

powershell
.\M365-Admin-Console.ps1

## Autor

Breno Silva Menezes e Otavio Gomes Correia

## Licença

Este projeto está licenciado sob a MIT License.
