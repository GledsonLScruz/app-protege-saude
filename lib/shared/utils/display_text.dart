String accentPortugueseText(String value) {
  var text = value;
  const replacements = <String, String>{
    'area': 'área',
    'atuacao': 'atuação',
    'codigo': 'código',
    'confirmacao': 'confirmação',
    'crianca': 'criança',
    'criancas': 'crianças',
    'denuncia': 'denúncia',
    'denuncias': 'denúncias',
    'descricao': 'descrição',
    'disponivel': 'disponível',
    'duvida': 'dúvida',
    'duvidas': 'dúvidas',
    'endereco': 'endereço',
    'enderecos': 'endereços',
    'fisica': 'física',
    'formulario': 'formulário',
    'informacao': 'informação',
    'informacoes': 'informações',
    'lesao': 'lesão',
    'lesoes': 'lesões',
    'mae': 'mãe',
    'maximo': 'máximo',
    'numero': 'número',
    'opcao': 'opção',
    'opcoes': 'opções',
    'orgao': 'órgão',
    'orgaos': 'órgãos',
    'pericia': 'perícia',
    'psicologica': 'psicológica',
    'relatorio': 'relatório',
    'saude': 'saúde',
    'vitima': 'vítima',
    'vitimas': 'vítimas',
    'violencia': 'violência',
  };

  for (final entry in replacements.entries) {
    text = text.replaceAllMapped(
      RegExp('\\b${entry.key}\\b', caseSensitive: false),
      (match) => _matchCase(match.group(0)!, entry.value),
    );
  }
  return text;
}

String _matchCase(String source, String replacement) {
  if (source.toUpperCase() == source) {
    return replacement.toUpperCase();
  }
  if (source.isNotEmpty && source[0].toUpperCase() == source[0]) {
    return replacement[0].toUpperCase() + replacement.substring(1);
  }
  return replacement;
}
