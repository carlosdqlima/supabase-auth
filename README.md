# TodoList com Supabase Auth

Um aplicativo Flutter moderno de lista de tarefas que demonstra a integração entre **Supabase** para autenticação de usuários e **Firebase Firestore** para armazenamento de dados. Este projeto foi desenvolvido como exemplo de como implementar um sistema de autenticação robusto e seguro em Flutter.

## 📱 Sobre o Projeto

Este aplicativo permite que usuários se registrem, façam login e gerenciem suas listas de tarefas pessoais. Cada usuário tem acesso apenas às suas próprias tarefas, garantindo privacidade e segurança dos dados.

### Principais Características:
- Interface moderna e intuitiva
- Sistema de autenticação seguro com Supabase
- Persistência de dados em tempo real com Firestore
- Gestão de estado eficiente
- Suporte a diferentes níveis de prioridade para tarefas

## 🔐 Autenticação com Supabase

### Como foi implementada a autenticação:

A autenticação foi implementada utilizando o **Supabase Auth**, que oferece um sistema completo de gerenciamento de usuários com recursos avançados de segurança.

#### Configuração do Supabase:
1. **Criação do projeto**: Um novo projeto foi criado no dashboard do Supabase
2. **Configuração das URLs**: As URLs de API e chaves foram configuradas no arquivo `.env`

#### Fluxo de Autenticação:
- **Registro**: Novos usuários podem se cadastrar com email e senha
- **Login**: Usuários existentes fazem login com suas credenciais
- **Sessão**: O Supabase mantém a sessão do usuário automaticamente
- **Logout**: Encerramento seguro da sessão com limpeza de dados locais

## ⚙️ Configuração do Ambiente

1. Clone o repositório
2. Copie o arquivo `.env.example` para `.env`:
   ```bash
   cp .env.example .env
   ```
3. Edite o arquivo `.env` e adicione suas credenciais:
   - **Firebase**: Obtenha suas credenciais no [Console do Firebase](https://console.firebase.google.com/)
   - **Supabase**: Obtenha suas credenciais no [Dashboard do Supabase](https://supabase.com/dashboard)

4. Instale as dependências:
   ```bash
   flutter pub get
   ```

5. Execute o aplicativo:
   ```bash
   flutter run
   ```

## 📁 Estrutura do Projeto

```
lib/
├── main.dart          # Ponto de entrada e configuração inicial
├── login.dart         # Tela de login com validações
├── registro.dart      # Tela de registro de novos usuários  
├── lista.dart         # Tela principal com lista de tarefas
└── create.dart        # Tela para criação de novas tarefas

config/
└── .env              # Variáveis de ambiente (credenciais)
└── .env.example      # Template das variáveis necessárias
```

### Descrição dos Arquivos:
- **main.dart**: Configuração do app, inicialização do Supabase e Firebase
- **login.dart**: Interface de login com integração ao Supabase Auth
- **registro.dart**: Formulário de registro com validação de dados
- **lista.dart**: Dashboard principal com CRUD de tarefas
- **create.dart**: Formulário para criação de tarefas com prioridades

## ✨ Funcionalidades

### Autenticação:
- ✅ **Registro de usuário** - Cadastro com email e senha
- ✅ **Login seguro** - Autenticação via Supabase Auth  
- ✅ **Recuperação de senha** - Reset via email (Supabase)
- ✅ **Sessão persistente** - Usuário permanece logado
- ✅ **Logout seguro** - Encerramento completo da sessão

### Gerenciamento de Tarefas:
- ✅ **Criação de tarefas** - Com título, descrição e prioridade
- ✅ **Listagem personalizada** - Apenas tarefas do usuário logado
- ✅ **Marcar como concluída** - Toggle de status da tarefa
- ✅ **Exclusão por swipe** - Deslizar para deletar tarefas
- ✅ **Filtros por prioridade** - Alta, média e baixa prioridade
- ✅ **Sincronização em tempo real** - Atualizações instantâneas

### Interface:
- ✅ **Design responsivo** - Adaptável a diferentes telas
- ✅ **Feedback visual** - Indicadores de carregamento e status
- ✅ **Navegação intuitiva** - Fluxo de telas otimizado

## 🛠️ Tecnologias Utilizadas

### Frontend:
- **Flutter** - Framework de desenvolvimento multiplataforma
- **Dart** - Linguagem de programação

### Backend e Autenticação:
- **Supabase** - Backend-as-a-Service para autenticação
  - Auth API para gerenciamento de usuários
  - JWT tokens para sessões seguras

### Banco de Dados:
- **Firebase Firestore** - Banco NoSQL em tempo real
  - Collections organizadas por usuário
  - Sincronização automática de dados
  - Queries otimizadas

### Dependências Principais:
- `supabase_flutter` - SDK oficial do Supabase para Flutter
- `cloud_firestore` - SDK do Firebase Firestore
- `flutter_dotenv` - Gerenciamento de variáveis de ambiente
- `provider` - Gerenciamento de estado (se aplicável)

## 🚀 Como Executar o Projeto

### Pré-requisitos:
- Flutter SDK instalado (versão 3.0+)
- Conta no Supabase
- Conta no Firebase
- Editor de código (VS Code recomendado)

### Passos para configuração:

1. **Clone o repositório:**
   ```bash
   git clone [url-do-repositorio]
   cd todolist-supabase-auth
   ```

2. **Configure as credenciais:**
   ```bash
   cp .env.example .env
   ```
   
3. **Edite o arquivo `.env`** com suas credenciais:
   ```env
   SUPABASE_URL=sua_url_do_supabase
   SUPABASE_ANON_KEY=sua_chave_anonima_do_supabase
   ```

4. **Instale as dependências:**
   ```bash
   flutter pub get
   ```

5. **Execute o aplicativo:**
   ```bash
   flutter run
   ```

## 📝 Configuração do Supabase

1. Acesse [supabase.com](https://supabase.com) e crie uma conta
2. Crie um novo projeto
3. Vá para Settings > API para obter:
   - Project URL
   - anon/public key

## 🔧 Configuração do Firebase

1. Acesse [console.firebase.google.com](https://console.firebase.google.com)
2. Crie um novo projeto
3. Ative o Firestore Database
4. Configure as regras de segurança
5. Adicione o arquivo de configuração ao projeto Flutter

---

**Nota**: Lembre-se de nunca versionar o arquivo `.env` com suas credenciais reais. Use sempre o `.env.example` como template.