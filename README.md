# ProtegeSaude Mobile

Aplicativo Flutter mobile do ProtegeSaude, implementado a partir de
`mobile-app-plan.md`.

## Rodando

```sh
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run --dart-define=API_BASE_URL=https://backend-protege-saude-production.up.railway.app/api
```

## Verificacao

```sh
flutter analyze
flutter test
```

## Escopo do MVP

- Home publica unificada.
- Fluxo anonimo de denuncia com profissao, CEP, formulario dinamico, fotos,
  rascunho local criptografado, resumo, PDF e envio multipart.
- Confirmacao de envio com protocolo e PDF local.
- Documentos norteadores por profissao com fallback local.
- Pontos de apoio e pagina institucional.
