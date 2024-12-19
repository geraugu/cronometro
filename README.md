# Cronômetro Flutter

Um aplicativo de cronômetro moderno desenvolvido com Flutter, oferecendo funcionalidades de cronometragem precisa e registro de voltas.

## Funcionalidades

- ⏱️ Cronômetro preciso com centésimos de segundo
- 🌓 Modo claro/escuro
- 🔄 Registro de voltas
- 📊 Exibição detalhada de tempos:
  - Tempo de cada volta individual
  - Tempo total acumulado
- 🎯 Interface limpa e intuitiva

## Controles

- **Iniciar/Parar**: Inicia ou pausa o cronômetro
- **Volta**: Registra o tempo da volta atual (disponível quando o cronômetro está em execução)
- **Zerar**: Reinicia o cronômetro e limpa todas as voltas
- **Tema**: Alterna entre modo claro e escuro

## Requisitos

- Flutter 3.0 ou superior
- Dart 3.0 ou superior

## Como Executar

1. Clone o repositório:
```bash
git clone [URL do repositório]
```

2. Navegue até o diretório do projeto:
```bash
cd cronometro
```

3. Instale as dependências:
```bash
flutter pub get
```

4. Execute o aplicativo:
```bash
flutter run
```

## Estrutura do Projeto

- `lib/main.dart` - Ponto de entrada do aplicativo e configuração de temas
- `lib/stopwatch_screen.dart` - Tela principal do cronômetro
- `lib/stopwatch_display.dart` - Widget de exibição do cronômetro

## Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.
