# TodoList com Supabase Auth

Um aplicativo Flutter de lista de tarefas com autenticação Supabase e armazenamento Firebase Firestore.

## Configuração do Ambiente

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

## Estrutura do Projeto

- `lib/main.dart` - Ponto de entrada do aplicativo
- `lib/login.dart` - Tela de login
- `lib/registro.dart` - Tela de registro
- `lib/lista.dart` - Tela principal com lista de tarefas
- `lib/create.dart` - Tela para criar novas tarefas
- `.env` - Arquivo com credenciais (não versionado)
- `.env.example` - Template do arquivo de credenciais

## Funcionalidades

- ✅ Autenticação com Supabase (login/registro)
- ✅ Criação de tarefas com prioridade
- ✅ Listagem de tarefas por usuário
- ✅ Marcar tarefas como concluídas
- ✅ Deletar tarefas (swipe)
- ✅ Logout

## Tecnologias Utilizadas

- Flutter
- Supabase (Autenticação)
- Firebase Firestore (Banco de dados)
- flutter_dotenv (Gerenciamento de variáveis de ambiente)