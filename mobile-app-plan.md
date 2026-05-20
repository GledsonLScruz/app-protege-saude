# Plano Flutter Mobile ProtegeSaude

## Resumo

Criar um app Flutter mobile, para Android e iOS, consumindo a mesma API usada pelo frontend React. O MVP deve reproduzir as telas publicas da web.

Este documento deve ser suficiente para implementar o app Flutter em um repositorio novo, sem depender de leitura do projeto React atual. Sempre que houver divergencia entre este plano e o frontend web, este plano prevalece para o MVP mobile.

Rotas finais:

- `/`
- `/denuncia`
- `/confirmacao-denuncia`
- `/documentos-norteadores`
- `/documentos-norteadores/:profissaoId`
- `/pontos-apoio`
- `/sobre`

Fora do MVP:

- Login, cadastro, area autenticada e painel administrativo.
- Modo offline completo. O app deve funcionar apenas online para consultas, validacao de CEP, carregamento de formularios, envio de denuncia e documentos remotos.
- Mapa interativo em pontos de apoio.
- Regras especificas hardcoded por profissao no formulario dinamico.

## Arquitetura E Tecnologias

- Estruturar por features: `home`, `denuncia`, `documentos_norteadores`, `pontos_apoio`, `sobre`, `shared`.
- Usar `go_router` para navegacao, rotas nomeadas, deep links e paths como `/documentos-norteadores/:profissaoId`.
- Usar `Provider` para estado:
  - `ChangeNotifier` ou `ValueNotifier` por tela/feature.
  - Controllers separados para denuncia, documentos e rascunho.
  - Evitar estado global grande; cada fluxo deve manter seu proprio estado.
- Usar `Dio` para HTTP:
  - `ApiClient` unico com `baseUrl`, timeout, interceptors e tratamento de erro.
  - Normalizar `API_BASE_URL` para sempre terminar em `/api`.
  - Ler ambiente por `--dart-define=API_BASE_URL=...`.
- Usar `freezed` + `json_serializable`:
  - DTOs da API.
  - Entidades internas imutaveis.
  - Union/sealed classes para respostas como CEP validado/bloqueado.
- Usar `Hive` para rascunhos locais:
  - Um rascunho por profissao.
  - Chave de criptografia armazenada em `flutter_secure_storage`.
  - Respostas dinamicas e metadados de fotos persistidos localmente.
- Usar `pdf` + `printing`:
  - Gerar PDF da denuncia no dispositivo.
  - Permitir preview, salvar, compartilhar e imprimir quando o sistema suportar.
- Usar `image_picker`:
  - Capturar foto pela camera.
  - Selecionar imagens da galeria.
  - Respeitar limite `max_fotos` vindo da API.
- Usar `url_launcher`, `share_plus` e `open_filex`:
  - Abrir links externos.
  - Abrir telefone com `tel:`.
  - Compartilhar app, documentos e PDF.
  - Abrir arquivos baixados/salvos.
- Salvar PDFs e documentos no diretorio privado do app, evitando permissoes problematicas de armazenamento publico.
- Politica de dependencias: pragmatica estavel, usando pacotes maduros quando reduzem risco sem exagerar em abstracoes.

## Setup Flutter E Plataforma

Criar o app em Flutter 3.x estavel, com suporte Android e iOS.

Dependencias esperadas no `pubspec.yaml`:

- `go_router`
- `provider`
- `dio`
- `freezed_annotation`
- `json_annotation`
- `hive`
- `hive_flutter`
- `flutter_secure_storage`
- `pdf`
- `printing`
- `image_picker`
- `url_launcher`
- `share_plus`
- `open_filex`
- `path_provider`
- `flutter_svg`, se usar `logo.svg`
- `flutter_launcher_icons`, como dependencia de dev
- `build_runner`, `freezed`, `json_serializable`, `hive_generator`, como dependencias de dev

Comandos esperados:

- Criar projeto: `flutter create protege_saude_mobile`
- Rodar codegen: `dart run build_runner build --delete-conflicting-outputs`
- Rodar analise: `flutter analyze`
- Rodar testes: `flutter test`
- Rodar com ambiente: `flutter run --dart-define=API_BASE_URL=https://backend-protege-saude-production.up.railway.app/api`

Configuracoes Android:

- Declarar permissao de camera quando captura por camera estiver habilitada.
- Declarar permissao de leitura de imagens conforme a versao Android alvo, apenas se necessaria para galeria.
- Usar diretorio privado do app para PDFs, documentos baixados e copias de fotos.
- Configurar app links/deep links para as rotas publicas somente se houver dominio final definido; caso contrario, manter navegacao interna.

Configuracoes iOS:

- Declarar `NSCameraUsageDescription`.
- Declarar `NSPhotoLibraryUsageDescription` e/ou `NSPhotoLibraryAddUsageDescription`, conforme uso de galeria.
- Usar diretorio privado do app para PDFs, documentos baixados e copias de fotos.
- Configurar universal links somente se houver dominio final definido; caso contrario, manter navegacao interna.

Politica de rede:

- Todas as funcionalidades que dependem da API exigem internet.
- Sem internet, o app deve mostrar erro claro e permitir que o usuario volte ou tente novamente.
- Rascunhos, PDFs ja gerados e documentos ja salvos podem continuar existindo localmente, mas isso nao caracteriza suporte offline do fluxo.

## Assets Para O App Mobile

Os arquivos que devem ser levados para o repositorio Flutter foram copiados para a pasta `mobileAssets/` na raiz deste projeto. Essa pasta funciona como pacote de transferencia para o novo app mobile; no projeto Flutter, eles devem ser copiados para algo como `assets/images/`, `assets/icons/` e `assets/documents/`, e registrados no `pubspec.yaml`.

Para o plano ser auto suficiente, o novo repositorio Flutter deve receber a pasta `mobileAssets/` junto com este documento. Se algum arquivo da lista abaixo estiver ausente, a implementacao deve falhar explicitamente durante revisao/setup, em vez de criar placeholder visual novo.

Arquivos disponiveis:

- Identidade visual:
  - `mobileAssets/logo.svg`: logo vetorial do ProtegeSaude.
  - `mobileAssets/protege-saude-logo.jpeg`: versao raster da marca.
  - `mobileAssets/icon-192x192.png`: icone do app em baixa/media resolucao.
  - `mobileAssets/icon-512x512.png`: icone principal em alta resolucao.
  - `mobileAssets/maskable-icon-512x512.png`: icone mascaravel, util como fonte para gerar icones Android adaptativos.
- Tela principal:
  - `mobileAssets/father.jpeg`: imagem institucional usada no hero da tela principal.
- Parcerias:
  - `mobileAssets/ufcg.png`: logo UFCG.
  - `mobileAssets/uepb2.png`: logo UEPB.
- Documentos norteadores locais/fallback:
  - `mobileAssets/eca.png`: capa local do ECA.
  - `mobileAssets/codigo-etica.png`: capa local do Codigo de Etica.
  - `mobileAssets/constituicao.png`: capa local da Constituicao Federal.
  - `mobileAssets/ECA2021_Digital.pdf`: PDF local do ECA.
  - `mobileAssets/codigo_etica.pdf`: PDF local do Codigo de Etica.
  - `mobileAssets/constituicao_federal.pdf`: PDF local da Constituicao Federal.

Diretrizes para uso no Flutter:

- Registrar os assets no `pubspec.yaml` por diretorio, por exemplo:
  - `assets/images/`
  - `assets/icons/`
  - `assets/documents/`
- Usar `flutter_svg` se o app renderizar `logo.svg`; caso a equipe prefira evitar essa dependencia, usar `protege-saude-logo.jpeg` ou gerar PNG a partir do SVG.
- Usar `icon-512x512.png` ou `maskable-icon-512x512.png` como fonte para `flutter_launcher_icons`.
- Os PDFs e capas em `mobileAssets/` devem ser tratados como fallback local inicial para documentos conhecidos. A tela de documentos norteadores continua exigindo internet e priorizando dados e URLs retornados pela API.
- Nao criar novas imagens placeholder no Flutter enquanto houver asset real disponivel nessa pasta.

Mapeamento sugerido no Flutter:

- `mobileAssets/logo.svg` -> `assets/icons/logo.svg`
- `mobileAssets/protege-saude-logo.jpeg` -> `assets/images/protege-saude-logo.jpeg`
- `mobileAssets/icon-192x192.png` -> `assets/icons/icon-192x192.png`
- `mobileAssets/icon-512x512.png` -> `assets/icons/icon-512x512.png`
- `mobileAssets/maskable-icon-512x512.png` -> `assets/icons/maskable-icon-512x512.png`
- `mobileAssets/father.jpeg` -> `assets/images/father.jpeg`
- `mobileAssets/ufcg.png` -> `assets/images/ufcg.png`
- `mobileAssets/uepb2.png` -> `assets/images/uepb2.png`
- `mobileAssets/eca.png` -> `assets/images/eca.png`
- `mobileAssets/codigo-etica.png` -> `assets/images/codigo-etica.png`
- `mobileAssets/constituicao.png` -> `assets/images/constituicao.png`
- `mobileAssets/ECA2021_Digital.pdf` -> `assets/documents/ECA2021_Digital.pdf`
- `mobileAssets/codigo_etica.pdf` -> `assets/documents/codigo_etica.pdf`
- `mobileAssets/constituicao_federal.pdf` -> `assets/documents/constituicao_federal.pdf`

## Tela Principal Unificada `/`

Objetivo: juntar a landing institucional e o painel de acoes da web em uma unica primeira tela util.

Estrutura:

- App bar/topo:
  - Logo ProtegeSaude usando `mobileAssets/logo.svg` ou `mobileAssets/protege-saude-logo.jpeg`.
  - Botao de menu, opcional.
  - Icone de compartilhar ou acao no menu.
- Secao hero compacta:
  - Titulo institucional: `ProtegeSaude`.
  - Texto curto explicando o proposito da plataforma.
  - Imagem institucional `mobileAssets/father.jpeg`, adaptada para mobile.
- Acoes principais em cards:
  - `Realizar uma denuncia`
    - Descricao: reportar casos suspeitos de violencia e maus-tratos.
    - Ao tocar, exibir modal de anonimato.
    - Modal:
      - Titulo: `Sua identidade esta protegida`.
      - Texto informando que a denuncia sera anonima.
      - Botoes: `Prosseguir com a denuncia` e `Voltar`.
      - Prosseguir navega para `/denuncia`.
  - `Documentos Norteadores`
    - Acao: navegar para `/documentos-norteadores`.
  - `Pontos de denuncia`
    - Acao: navegar para `/pontos-apoio`.
  - `Sobre o ProtegeSaude`
    - Acao: navegar para `/sobre`.
  - `Identifique uma vitima`
    - No MVP: card desabilitado ou com snackbar `Funcionalidade em breve`.
  - `Duvidas frequentes`
    - Se FAQ for incluido na propria tela, rolar ate a secao FAQ.
    - Caso contrario, mostrar `Funcionalidade em breve`.
- Secao FAQ, se mantida:
  - Lista expansivel de perguntas e respostas, reaproveitando o conteudo institucional da web.
- Secao de contatos de emergencia:
  - `Disque 100 - Direitos Humanos`.
  - `Disque 180 - Violencia contra Mulher`.
  - `Disque 190 - Policia Militar`.
  - Usar `url_launcher` para chamadas telefonicas quando apropriado.
- Secao de parcerias:
  - Logos UFCG e UEPB usando `mobileAssets/ufcg.png` e `mobileAssets/uepb2.png`.
- Bottom navigation:
  - Pode ser removida no MVP, ja que a tela principal concentra os atalhos.
  - Se mantida, conter somente: `Inicio`, `Sobre`, `Compartilhar`.

### Textos Finais Da Tela Principal

Texto institucional curto:

- `O ProtegeSaude auxilia profissionais na identificacao e denuncia anonima de suspeitas de violencia e maus-tratos contra criancas e adolescentes.`

Modal de anonimato:

- Titulo: `Sua identidade esta protegida`
- Texto: `A denuncia sera enviada de forma anonima. Informe apenas os dados necessarios para que o Conselho Tutelar responsavel possa avaliar o caso.`
- Botao primario: `Prosseguir com a denuncia`
- Botao secundario: `Voltar`

Contatos de emergencia:

- `Disque 100 - Direitos Humanos`
- `Disque 180 - Violencia contra Mulher`
- `Disque 190 - Policia Militar`

FAQ, se incluida no MVP:

- Pergunta: `Como faco para registrar uma denuncia?`
  - Resposta: `Para registrar uma denuncia, toque em Realizar uma denuncia e siga o fluxo. Todas as denuncias sao tratadas com sigilo.`
- Pergunta: `Minha identidade sera mantida em sigilo?`
  - Resposta: `Sim. A denuncia no ProtegeSaude e anonima, e as informacoes fornecidas sao usadas apenas para encaminhamento do caso.`
- Pergunta: `Que tipos de casos posso denunciar?`
  - Resposta: `Qualquer suspeita de violencia ou maus-tratos contra criancas e adolescentes, incluindo violencia fisica, psicologica, negligencia, abuso, violencia domestica e outras formas de agressao.`
- Pergunta: `Como identificar sinais de violencia?`
  - Resposta: `Fique atento a lesoes inexplicadas, marcas recorrentes, comportamento muito ansioso ou temeroso, explicacoes inconsistentes sobre machucados e relutancia em responder perguntas.`
- Pergunta: `O que acontece apos fazer uma denuncia?`
  - Resposta: `A denuncia e encaminhada ao Conselho Tutelar responsavel, que avaliara as informacoes e adotara as providencias cabiveis.`
- Pergunta: `Preciso ter certeza absoluta para fazer uma denuncia?`
  - Resposta: `Nao. Se houver suspeita fundamentada, a denuncia pode ser feita. Os orgaos competentes sao responsaveis por investigar e confirmar os fatos.`
- Pergunta: `Por que nao ha detalhamento pericial das partes do corpo?`
  - Resposta: `Porque o ProtegeSaude e uma ferramenta de apoio a denuncia, nao um recurso para realizacao de pericia das lesoes observadas.`

## Denuncia `/denuncia`

Objetivo: reproduzir o fluxo principal da web, com selecao de profissao, endereco, formulario dinamico, resumo, PDF e envio.

Estrutura geral:

- App bar fixa com:
  - Botao voltar.
  - Titulo dinamico:
    - `Selecione a profissao` antes de iniciar.
    - Nome do passo atual depois da profissao confirmada.
  - Botao `Trocar profissao` quando o wizard estiver ativo.
- Ao tocar em voltar:
  - Se houver dados preenchidos, exibir confirmacao de saida.
  - Botoes:
    - `Sair mesmo assim`.
    - `Continuar preenchendo`.

### Etapa 0: Selecao De Profissao

Conteudo:

- Card/secao com titulo: `Nova denuncia`.
- Texto: o conteudo da denuncia e configurado por profissao.
- Campo de selecao pesquisavel:
  - Lista carregada de `GET /api/public/profissoes`.
  - Exibir `nome`.
  - Ao selecionar, carregar formulario com `GET /api/public/profissoes/{id}/formulario`.
- Preview da profissao selecionada:
  - Nome.
  - Descricao ou fallback `Formulario configurado para esta profissao.`
- Botao `Continuar`:
  - Desabilitado sem profissao.
  - Exibe loading enquanto carrega formulario.
- Se houver rascunho salvo:
  - Modal: `Ha um rascunho salvo para {profissao}. Deseja retomar?`
  - Botoes:
    - `Sim, continuar rascunho`.
    - `Nao, comecar do zero`.

### Wizard De Denuncia

Apos profissao confirmada:

- Aplicar cor da profissao como cor primaria se `cor` for hexadecimal valido.
- Exibir indicador de progresso horizontal ou stepper compacto:
  - Passo 1: `Endereco da Vitima`.
  - Passos seguintes: `titulo` dos passos vindos da API.
  - Ultimo passo: `Resumo`.
- Regra de navegacao:
  - Pode voltar para qualquer passo anterior.
  - So pode avancar se o passo atual estiver valido.
  - So pode tocar em passo futuro se todos os anteriores estiverem validos.
- Composicao da tela:
  - Header fixo no topo com botao voltar, titulo do passo e, quando aplicavel, acao `Trocar profissao`.
  - Area do stepper/progresso logo abaixo do header.
  - Area central rolavel com o conteudo do passo atual.
  - Barra inferior persistente com botoes `Voltar`, `Proximo` ou `Enviar Denuncia`.
  - Overlay modal durante envio com spinner e texto informando que o PDF esta sendo gerado e a denuncia transmitida.
- Estado do wizard:
  - `selectedProfession`: profissao confirmada pelo usuario.
  - `loadedForm`: formulario publico retornado pela API.
  - `currentStep`: indice numerico do passo atual.
  - `stepsValidation`: mapa `stepNumber -> bool` para controlar avancos.
  - `address`: endereco validado e campos manuais.
  - `dynamicAnswers`: respostas por `stepId` e `fieldId`.
  - `submitState`: `idle`, `loading`, `success` ou `error`.
- Montagem dos passos:
  - Enquanto nao houver profissao confirmada, renderizar somente a selecao de profissao.
  - Depois da confirmacao, criar a lista de passos em tempo de execucao:
    - Primeiro passo fixo de endereco.
    - Um passo para cada item de `loadedForm.passos`, preservando `ordem_index` da API.
    - Um passo final de resumo.
  - Cada passo dinamico deve usar seu `id` como chave logica para armazenar respostas, nao a posicao visual.
- Comportamento do stepper:
  - Passos anteriores e o passo atual sao clicaveis.
  - Passos futuros so sao clicaveis se todos os passos anteriores estiverem validos.
  - Tocar em passo bloqueado deve manter o usuario no passo atual e sinalizar erro no indicador atual.
  - O progresso visual deve preencher proporcionalmente de acordo com `currentStep`.
- Botoes inferiores:
  - No primeiro passo, `Voltar para tela inicial` abre confirmacao de saida.
  - A partir do segundo passo, `Voltar` retorna um passo.
  - Antes do resumo, `Proximo` avanca apenas quando o passo atual esta valido.
  - No resumo, `Enviar Denuncia` dispara geracao de PDF e envio.
  - Durante envio, todos os botoes ficam desabilitados e o botao final mostra estado de carregamento.

### Passo Endereco Da Vitima

Campos:

- `CEP`
  - Mascara `00000-000`.
  - Teclado numerico.
  - Ao completar 8 digitos, chamar `GET /api/denuncia/validar-cep/{cep}`.
  - Mostrar estados:
    - `Validando CEP...`
    - `CEP validado com sucesso.`
    - Mensagem de erro da API.
- `Rua`
  - Preenchida pela API quando disponivel.
  - Editavel.
- `Numero`
  - Editavel.
- Campos desabilitados preenchidos pela validacao:
  - `Estado`.
  - `Cidade`.
  - `Bairro`.
  - `Conselho Tutelar`.
- Tooltip/texto de ajuda do CEP:
  - Informar que, se a crianca/adolescente residir fora de Campina Grande, deve ser informado o CEP do local onde a violencia ocorreu em Campina Grande.

Validacoes:

- CEP obrigatorio.
- CEP deve ter 8 digitos.
- CEP precisa estar validado pela API.
- Rua obrigatoria e com minimo de 3 caracteres.
- Numero obrigatorio.
- Estado, cidade, bairro e conselho obrigatorios apos validacao.
- Alterar CEP limpa estado, cidade, bairro e conselho ja preenchidos.

### Passos Dinamicos Do Formulario

Cada passo vem de `PublicFormStep`:

- `titulo`.
- `descricao`, se existir.
- Lista ordenada de `campos`.
- O app deve renderizar os passos dinamicos com um componente equivalente ao `DynamicFormStep` da web.
- A tela dinamica e orientada por dados: nenhum campo especifico deve ser hardcoded por profissao.
- Para cada `PublicFormStep`:
  - Exibir `descricao` no topo quando existir.
  - Renderizar os campos em coluna, preservando a ordem da API.
  - Calcular a validacao do passo observando todos os campos renderizados.
  - Notificar o controller do wizard sempre que a validade do passo mudar.
- Para cada `PublicFormField`:
  - Usar `field.id` como chave de armazenamento da resposta.
  - Exibir `field.nome` como label principal.
  - Exibir marcador visual de obrigatoriedade quando `obrigatorio=true`.
  - Exibir `field.dica` como texto auxiliar ou tooltip, dependendo do espaco disponivel.
  - Exibir erro somente apos o campo ser tocado/editado ou quando o usuario tentar avancar.
  - Validar opcoes contra `validacoes.opcoes_permitidas` quando existir; caso contrario, usar os valores de `opcoes`.
- Estrutura de respostas:
  - `dynamicAnswers[stepId][fieldId] = value`.
  - `texto`, `textarea`, `numero`, `data`, `cep`, `select`, `radio` e `bairro` usam `String`.
  - `checkbox` usa `List<String>`.
  - `switch` usa objeto `{ valor: bool?, selecionados: List<String> }`.
  - `foto` usa lista de metadados e referencias locais das imagens.

Tipos de campo suportados:

- `texto`
  - Renderizar como `TextFormField` de uma linha.
  - Valor padrao vazio.
  - Placeholder usa `dica` ou `Digite sua resposta`.
  - Em alteracao, salvar o texto como string.
  - Se obrigatorio, string vazia ou apenas espacos invalida o campo.
- `textarea`
  - Renderizar como `TextFormField` multiline.
  - Usar altura minima maior que um input simples, equivalente a aproximadamente 5 linhas.
  - Permitir quebra de linha.
  - Placeholder usa `dica` ou `Digite sua resposta`.
  - Se obrigatorio, string vazia ou apenas espacos invalida o campo.
- `numero`
  - Renderizar como campo de texto com teclado numerico.
  - Manter a resposta como string para evitar perda de formatacao enquanto o usuario digita.
  - Validar com conversao numerica somente quando houver valor.
  - Se obrigatorio, vazio invalida.
  - Se preenchido e nao numerico, mostrar `Informe um numero valido.`
- `data`
  - Date picker nativo.
  - Salvar em formato ISO simples `yyyy-MM-dd`, compativel com o frontend atual.
  - Validar data real, evitando datas impossiveis.
  - Se nome/dica sugerir nascimento, bloquear data futura.
  - Na exibicao do resumo/PDF, formatar como `dd/MM/yyyy`.
- `cep`
  - Renderizar como campo de texto com teclado numerico.
  - Aplicar mascara `00000-000`.
  - Salvar preferencialmente o valor formatado na tela e normalizar para 8 digitos na validacao.
  - Se obrigatorio, vazio invalida.
  - Se preenchido e tiver tamanho diferente de 8 digitos, mostrar `Informe um CEP valido.`
- `select`
  - Dropdown pesquisavel.
  - Opcoes vem de `opcoes`.
  - Cada item usa `label` para exibicao e `valor` para persistencia.
  - Placeholder: `Selecione uma opcao`.
  - Deve suportar busca quando houver muitas opcoes.
  - Se obrigatorio, nenhum valor selecionado invalida.
  - Valor selecionado fora das opcoes permitidas invalida.
- `bairro`
  - Mesmo comportamento de select.
  - Exibir badge `Bairro validado` quando houver opcoes permitidas.
  - Usar o mesmo componente visual do `select`.
  - Tratar como tipo separado apenas para exibicao e semantica.
- `radio`
  - Lista de opcoes exclusivas.
  - Cada opcao usa `label` para exibicao e `valor` para persistencia.
  - Renderizar verticalmente em mobile.
  - Toda a linha da opcao deve ser tocavel.
  - Nao permitir mais de uma opcao selecionada.
  - Se obrigatorio, nenhuma opcao selecionada invalida.
- `checkbox`
  - Lista de multipla selecao.
  - Cada opcao usa `label` para exibicao e `valor` para persistencia.
  - Renderizar verticalmente em mobile.
  - Cada linha deve ter checkbox customizado e area de toque ampla.
  - Salvar como lista de valores selecionados.
  - Se obrigatorio, lista vazia invalida.
  - Qualquer valor fora das opcoes permitidas invalida.
- `switch`
  - Controle Sim/Nao.
  - Quando `true` e houver opcoes, exibir checkboxes condicionais.
  - Estado inicial deve ser `null`, nao `false`, para permitir validar obrigatoriedade corretamente.
  - Quando o usuario liga o switch, salvar `{ valor: true, selecionados: [...] }`.
  - Quando o usuario desliga o switch, salvar `{ valor: false, selecionados: [] }`.
  - O label visivel deve alternar entre `Sim` e `Nao`.
  - Se `valor=true` e houver opcoes condicionais, renderizar grupo secundario com checkboxes.
  - As opcoes condicionais usam `validacoes.opcoes_condicionais_permitidas` quando existir; caso contrario, usam `opcoes`.
  - Se o switch for obrigatorio, `valor=null` invalida.
	- `foto`
	  - Botao para escolher camera ou galeria.
	  - Exibir contador `selecionadas/max`.
	  - Mostrar preview das imagens.
	  - Permitir remover imagem.
  - Usar `validacoes.max_fotos`, depois `max_fotos`, depois fallback `1`.
  - Se `max_fotos > 1`, permitir multiplas imagens; caso contrario, uma imagem.
  - Ao adicionar fotos, respeitar slots restantes e avisar quando o usuario exceder o limite.
  - Cada foto deve ter id local, nome, tipo MIME, tamanho e caminho local.
	  - No resumo/PDF, carregar as imagens pelos caminhos locais.
	  - Se obrigatorio, nenhuma foto invalida.
	  - Se exceder limite, mostrar erro com pluralizacao correta.

Regras operacionais para fotos:

- Ao selecionar ou capturar foto, copiar o arquivo para o diretorio privado do app antes de salvar no rascunho.
- Persistir no rascunho apenas metadados e caminho local privado, nunca base64 como armazenamento principal.
- Metadados obrigatorios por foto:
  - `id` local unico.
  - `name`.
  - `mimeType`.
  - `sizeBytes`.
  - `localPath`.
  - `createdAt`.
- Corrigir orientacao visual quando houver informacao EXIF disponivel.
- Para PDF, carregar bytes a partir de `localPath` e redimensionar proporcionalmente para caber na pagina.
- Se a imagem local nao existir ao restaurar o rascunho, remover a referencia e avisar o usuario com snackbar discreto.
- Se camera ou galeria forem negadas pelo sistema, mostrar mensagem clara e permitir tentar novamente apos alterar permissoes.
- Limpar arquivos de fotos removidas pelo usuario.
- Ao concluir envio com sucesso, remover fotos associadas ao rascunho enviado.

Diretrizes de estilo para os campos dinamicos:

- Layout geral:
  - Renderizar campos em coluna, com espacamento consistente entre grupos.
  - Evitar cards aninhados; cada grupo de campo deve ser uma secao simples.
  - O conteudo deve ser totalmente rolavel e nunca ficar escondido pela barra inferior.
  - Usar largura total para inputs no mobile.
- Cabecalho do campo:
  - Label com peso semibold.
  - Asterisco ou marcador vermelho para obrigatorio.
  - Badges pequenos em formato pill para informacoes como `Bairro validado` ou contador de CEP/fotos.
  - Dicas devem aparecer como icone de ajuda ou texto auxiliar discreto; em mobile, preferir bottom sheet/tooltip tocavel em vez de hover.
- Inputs:
  - Altura minima aproximada de 42px.
  - Borda fina cinza clara.
  - Raio de borda medio, em torno de 8px.
  - Padding horizontal confortavel.
  - Foco com borda na cor da profissao e sombra suave usando a cor da profissao com baixa opacidade.
  - Erro com borda vermelha e mensagem abaixo do campo.
- Opcoes:
  - Radio e checkbox devem ter area de toque grande e texto legivel.
  - Radio deve usar indicador circular com cor da profissao quando selecionado.
  - Checkbox deve seguir o mesmo padrao visual do app e destacar selecao com a cor da profissao.
  - Listas de opcoes devem ser verticais, com espacamento suficiente para toque.
- Switch:
  - Renderizar em linha com texto `Sim`/`Nao` e controle a direita.
  - Estado ligado usa a cor da profissao.
  - Grupo condicional deve aparecer abaixo, com borda leve na cor da profissao e fundo limpo.
  - Opcoes condicionais devem ter area de toque maior que checkboxes comuns.
- Fotos:
  - Campo de foto deve ter borda tracejada e fundo sutil.
  - Botao de upload usa a cor da profissao.
  - Mostrar contador `x/y fotos selecionadas`.
  - Quando nao houver foto, mostrar estado vazio `Nenhuma foto selecionada.`
  - Previews devem aparecer em grid de uma coluna no mobile e adaptar para mais colunas em telas maiores.
  - Nome do arquivo deve truncar com reticencias quando longo.
  - Botao `Remover` deve ser textual e vermelho.
- Responsividade:
  - Em telas pequenas, listas e grids devem virar coluna unica.
  - Metadados de foto devem empilhar verticalmente.
  - Tooltips largos devem virar sheet/modal para nao cortar texto.
  - Nenhum label, badge, erro ou botao deve sobrepor outro elemento.

Validacoes dinamicas:

- Respeitar `obrigatorio`.
- Respeitar `opcoes_permitidas`.
- Respeitar `opcoes_condicionais_permitidas`.
- Respeitar `max_fotos`.
- Para `checkbox`, exigir ao menos uma opcao quando obrigatorio.
- Para `foto`, exigir ao menos uma imagem quando obrigatorio.
- Para `switch`, exigir resposta booleana quando obrigatorio.

### Passo Resumo

Conteudo:

- Secao `Endereco e Conselho Tutelar`:
  - CEP.
  - Rua.
  - Numero.
  - Bairro.
  - Cidade/UF.
  - Conselho Tutelar.
  - Contato, se existir.
- Uma secao por passo dinamico:
  - Titulo do passo.
  - Descricao, se existir.
  - Cada campo com pergunta e resposta formatada.
- Fotos:
  - Mostrar quantidade.
  - Mostrar preview em grid.
- Botao final:
  - `Enviar denuncia`.
  - Ao tocar:
    - Gerar PDF.
    - Criar protocolo `DEN-{ano}-{6 digitos}`.
    - Enviar multipart.
    - Mostrar overlay de envio.
    - Navegar para confirmacao em sucesso.
    - Mostrar modal de erro em falha.

## Confirmacao De Denuncia `/confirmacao-denuncia`

Objetivo: confirmar que a denuncia foi enviada e permitir acesso ao PDF/protocolo.

Estrutura:

- App bar com opcao de voltar para inicio.
- Conteudo central:
  - Icone de sucesso.
  - Titulo: denuncia enviada com sucesso.
  - Protocolo retornado pela API.
  - Texto orientando o usuario a guardar o protocolo.
- Acoes:
  - `Abrir PDF`: abre arquivo local com `open_filex`.
  - `Compartilhar PDF`: usa `share_plus`.
  - `Salvar/Exportar PDF`: usa fluxo de compartilhamento/salvamento suportado por `printing`/sistema.
  - `Nova denuncia`: volta para `/denuncia`.
  - `Voltar ao inicio`: navega para `/`.
- Se a tela for aberta sem estado valido:
  - Tentar restaurar a ultima denuncia enviada persistida localmente.
  - Se nao houver protocolo e PDF persistidos, redirecionar para `/`.

Persistencia da confirmacao:

- Ao enviar denuncia com sucesso, persistir localmente:
  - `protocol`.
  - Caminho local do PDF gerado.
  - Data/hora de envio.
  - Nome e id da profissao.
  - Nome do conselho, quando existir.
- A persistencia da confirmacao serve apenas para recuperar a tela se o app for fechado ou voltar do background.
- A confirmacao persistida deve ser substituida a cada nova denuncia enviada com sucesso.
- `Nova denuncia` nao deve apagar automaticamente o PDF anterior; apenas inicia novo fluxo.
- `Voltar ao inicio` mantem o PDF anterior disponivel somente pela confirmacao se o usuario retornar via estado/restauracao interna.

## Documentos Norteadores

Rotas:

- `/documentos-norteadores`
- `/documentos-norteadores/:profissaoId`

Objetivo: reproduzir a biblioteca legal por profissao.

Estrutura:

- App bar:
  - Botao voltar.
  - Titulo `Documentos Norteadores`.
- Secao introdutoria:
  - Titulo: `Biblioteca de Documentos Legais`.
  - Descricao: acesso a documentos importantes com foco em artigos especificos relevantes para profissionais.
- Filtro:
  - Select pesquisavel `Profissao`.
  - Opcoes carregadas de `GET /api/profissoes`.
  - Se existir `:profissaoId` na rota e ele for valido, selecionar automaticamente.
- Ao selecionar profissao:
  - Carregar documentos com `GET /api/profissoes/{id}/documentos`.
  - Aplicar cor da profissao como tema, quando valida.
- Estados:
  - Carregando profissoes.
  - Erro ao carregar profissoes.
  - Nenhuma profissao selecionada.
  - Carregando documentos.
  - Erro ao carregar documentos.
  - Nenhum documento encontrado.
  - Lista de documentos.
- Card de documento:
  - Capa se `foto_capa` existir.
  - Placeholder `Sem capa` se nao existir.
  - Quando o documento corresponder a um material local conhecido e a API nao fornecer capa, usar os fallbacks `mobileAssets/eca.png`, `mobileAssets/codigo-etica.png` ou `mobileAssets/constituicao.png`.
  - Titulo.
  - Descricao ou fallback `Sem descricao disponivel.`
  - Pontos de foco:
    - Titulo do ponto.
    - Pagina, quando existir.
  - Botoes:
    - `Visualizar Online`, quando `url_online` existir.
    - `Download`, quando `arquivo` existir.
- Download:
  - Priorizar `fileUrl`.
  - Se a API nao retornar `fileUrl` para um documento local conhecido, usar como fallback `mobileAssets/ECA2021_Digital.pdf`, `mobileAssets/codigo_etica.pdf` ou `mobileAssets/constituicao_federal.pdf`.
  - Salvar no diretorio privado do app.
  - Exibir status:
    - `Baixando...`
    - `Download concluido`
    - `Erro ao baixar`
  - Apos baixar, permitir abrir arquivo.
  - Em erro, se houver `onlineUrl`, oferecer abrir online.

Regra de matching para documento local conhecido:

- Normalizar `titulo` removendo acentos, convertendo para minusculas e colapsando espacos.
- Se o titulo normalizado contiver `eca` ou `estatuto da crianca`, usar:
  - Capa: `assets/images/eca.png`
  - PDF: `assets/documents/ECA2021_Digital.pdf`
- Se o titulo normalizado contiver `codigo de etica` ou `cirurgiao dentista`, usar:
  - Capa: `assets/images/codigo-etica.png`
  - PDF: `assets/documents/codigo_etica.pdf`
- Se o titulo normalizado contiver `constituicao`, usar:
  - Capa: `assets/images/constituicao.png`
  - PDF: `assets/documents/constituicao_federal.pdf`
- Nunca escolher fallback por `id`, porque ids podem variar entre ambientes.

## Pontos De Apoio `/pontos-apoio`

Objetivo: reproduzir a tela estatica de pontos de apoio da web.

Estrutura:

- App bar com voltar.
- Titulo: `Pontos de Apoio a Denuncia`.
- Card de endereco principal:
  - Icone de localizacao.
  - Texto: `Santo Antonio, Campina Grande - PB, 58406-000`.
- Secao `Distritos do Conselho Tutelar`.
- Lista expansivel de distritos:
  - `NORTE`: Alto Branco, Lauritzen, Palmeira, Prata.
  - `SUL`: Catole, Sandra Cavalcante, Itarare, Jardim Paulistano.
  - `LESTE`: Liberdade, Jardim Quarenta, Centenario, Jose Pinheiro.
  - `OESTE`: Bodocongo, Malvinas, Serrotao, Dinamica.
- Cada distrito:
  - Header com nome.
  - Icone de expandir/recolher.
  - Lista de bairros ao expandir.
- Mapa:
  - No MVP, usar placeholder ou asset real se disponivel.
  - Nao ha mapa valido copiado para `mobileAssets/`; portanto, nao usar `/path/to/your/map-image.png`.
  - Ocultar a secao de mapa no MVP ate existir um asset real ou integracao de mapa.

## Sobre `/sobre`

Objetivo: reproduzir a pagina institucional.

Estrutura:

- App bar com voltar ou bottom navigation.
- Header visual com titulo `Sobre o ProtegeSaude`.
- Secoes em cards/lista:
  - `Nossa Origem`
    - Explica origem como projeto de extensao de Odontologia da UEPB.
  - `Parcerias`
    - UFCG e UEPB.
    - Exibir logos `mobileAssets/ufcg.png` e `mobileAssets/uepb2.png`.
  - `Desenvolvimento`
    - Texto sobre desenvolvimento academico/TCC.
  - `Codigo Aberto`
    - Link para GitHub usando `url_launcher`.
  - `Processo Criativo`
    - Link para YouTube usando `url_launcher`.
- Botao `Compartilhar o ProtegeSaude`:
  - Usa `share_plus`.
  - Texto e URL devem ser configuraveis.
- Rodape:
  - Direitos reservados.
  - Contatos de emergencia, se mantidos no mobile.

Textos finais:

- `Nossa Origem`: `O ProtegeSaude nasceu de um projeto de extensao do curso de Odontologia da UEPB, visando criar uma ferramenta para auxiliar profissionais de saude na identificacao e denuncia de casos de maus-tratos e violencia contra criancas e adolescentes.`
- `Parcerias`: `Este projeto e uma colaboracao entre a UFCG e a UEPB, unindo experiencia academica e tecnologica para um proposito social.`
- `Desenvolvimento`: `Desenvolvido por Huandrey Pontes, estudante da UFCG, como parte de seu TCC, aplicando teorias de UI para atender as necessidades dos profissionais de saude.`
- `Codigo Aberto`: `O ProtegeSaude e um projeto de codigo aberto, permitindo que a comunidade contribua para seu desenvolvimento e melhoria continua.`
- Link GitHub: `https://github.com/GledsonLScruz/frontend-protege-saude`
- `Processo Criativo`: `O processo criativo por tras do desenvolvimento do ProtegeSaude esta documentado e disponivel para visualizacao.`
- Link YouTube: `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
- Compartilhamento:
  - Texto: `Junte-se a nos na luta contra maus-tratos e violencia. Conheca o ProtegeSaude, um aplicativo que ajuda a identificar e denunciar casos de abuso. Juntos, podemos fazer a diferenca! #ProtegeSaude #ProtecaoInfantil`
  - URL padrao configuravel: `https://protegesaude.com`
- Rodape: `Todos os direitos reservados (c) ProtegeSaude 2024`

## Endpoints E Contratos

### Base URL

- Receber `API_BASE_URL` por ambiente.
- Se vier sem `/api`, adicionar `/api`.
- Se vier com barra final, remover barra duplicada.
- Exemplo producao atual:
  - `https://backend-protege-saude-production.up.railway.app/api`.

### Profissoes Publicas Para Denuncia

`GET /api/public/profissoes`

Mapeamento:

- `id`
- `nome`
- `descricao`
- `cor`
- `status`
- `data_criacao`
- `data_update`
- `data_delete`

A resposta pode ser:

- Array direto.
- Objeto com `profissoes`.
- Objeto com `professions`.
- Objeto com `items`.
- Objeto com `data`.

Exemplo de resposta valida:

```json
[
  {
    "id": 1,
    "nome": "Odontologia",
    "descricao": "Formulario para profissionais de odontologia.",
    "cor": "#24786B",
    "status": 1,
    "data_criacao": "2026-01-01T00:00:00.000Z",
    "data_update": "2026-01-01T00:00:00.000Z",
    "data_delete": null
  }
]
```

Exemplo com wrapper tambem aceito:

```json
{
  "profissoes": [
    {
      "id": 1,
      "nome": "Odontologia",
      "descricao": null,
      "cor": "24786B",
      "status": 1
    }
  ]
}
```

### Formulario Publico

`GET /api/public/profissoes/{professionId}/formulario`

Modelo esperado:

- `profissao`
  - `id`
  - `nome`
  - `descricao`
  - `cor`
- `passos[]`
  - `id`
  - `profissao_id`
  - `ordem_index`
  - `titulo`
  - `descricao`
  - `campos[]`
- `campos[]`
  - `id`
  - `formulario_passo_id`
  - `ordem_index`
  - `nome`
  - `tipo_campo`
  - `opcoes`
  - `max_fotos`
  - `obrigatorio`
  - `dica`
  - `validacoes`

Exemplo minimo de resposta:

```json
{
  "profissao": {
    "id": 1,
    "nome": "Odontologia",
    "descricao": "Formulario para profissionais de odontologia.",
    "cor": "#24786B"
  },
  "passos": [
    {
      "id": 10,
      "profissao_id": 1,
      "ordem_index": 1,
      "titulo": "Dados observados",
      "descricao": "Informe os sinais identificados.",
      "campos": [
        {
          "id": 100,
          "formulario_passo_id": 10,
          "ordem_index": 1,
          "nome": "Houve relato da vitima?",
          "tipo_campo": "switch",
          "opcoes": [
            { "valor": "medo", "label": "Medo" },
            { "valor": "dor", "label": "Dor" }
          ],
          "max_fotos": null,
          "obrigatorio": true,
          "dica": "Marque sim se houve relato direto.",
          "validacoes": {
            "obrigatorio": true,
            "aceita_multiplos": false,
            "opcoes_condicionais_quando": "sim",
            "opcoes_condicionais_permitidas": ["medo", "dor"],
            "opcoes_condicionais_aceita_multiplos": true,
            "max_fotos": null
          }
        },
        {
          "id": 101,
          "formulario_passo_id": 10,
          "ordem_index": 2,
          "nome": "Fotos de evidencia",
          "tipo_campo": "foto",
          "opcoes": null,
          "max_fotos": 3,
          "obrigatorio": false,
          "dica": null,
          "validacoes": {
            "obrigatorio": false,
            "aceita_multiplos": true,
            "max_fotos": 3
          }
        }
      ]
    }
  ]
}
```

Regras de tolerancia do parser:

- `opcoes` pode ser `null` ou array vazio.
- `validacoes` pode vir ausente; nesse caso usar `obrigatorio`, `max_fotos` e `opcoes` do campo.
- `cor` pode vir com ou sem `#`; se invalida, usar a cor padrao `#24786B`.
- Passos e campos devem ser ordenados por `ordem_index`.

### Validacao De CEP

`GET /api/denuncia/validar-cep/{cep}`

Resposta de sucesso:

- `podeProsseguir: true`
- `endereco`
  - `cep`
  - `estado`
  - `cidade`
  - `bairro`
  - `logradouro` ou `rua`
- `conselho`
  - `id`
  - `nome`

Resposta bloqueada:

- `podeProsseguir: false`
- `codigo`
- `mensagem`

Codigos previstos:

- `CEP_INVALIDO`
- `CEP_NAO_ENCONTRADO`
- `BAIRRO_NAO_IDENTIFICADO`
- `BAIRRO_FORA_DO_CATALOGO`
- `CONSELHO_NAO_CADASTRADO`
- `ERRO_CONSULTA_CEP`

Exemplo de sucesso:

```json
{
  "podeProsseguir": true,
  "endereco": {
    "cep": "58406000",
    "estado": "PB",
    "cidade": "Campina Grande",
    "bairro": "Santo Antonio",
    "logradouro": "Rua Exemplo"
  },
  "conselho": {
    "id": 2,
    "nome": "Conselho Tutelar Sul"
  }
}
```

Exemplo bloqueado:

```json
{
  "podeProsseguir": false,
  "codigo": "BAIRRO_FORA_DO_CATALOGO",
  "mensagem": "O bairro informado nao pertence ao catalogo atendido."
}
```

O backend pode retornar bloqueio com status HTTP 4xx ou 200. Em ambos os casos, se o payload tiver `podeProsseguir: false`, o app deve tratar como validacao bloqueada e exibir `mensagem`.

### Envio De Denuncia

`POST /api/denuncia`

Multipart:

- `protocolo`
- `profissao_id`
- `regiao`
- `cep`
- `estado`
- `cidade`
- `bairro`
- `conselho_id`, quando houver.
- `pdf`, com nome `denuncia_{protocolo}.pdf`.

Geracao de protocolo:

- Gerar no cliente no formato `DEN-{ano}-{6 digitos}`, por exemplo `DEN-2026-123456`.
- O app deve usar o `protocolo` retornado pela API como valor final exibido na confirmacao.
- Se a API retornar erro indicando protocolo duplicado/conflito, gerar novo protocolo e tentar reenviar uma vez.
- Se a segunda tentativa falhar, mostrar erro e manter o rascunho.

Decisao de contrato do MVP:

- As respostas detalhadas dos campos dinamicos nao sao enviadas como JSON separado.
- O backend recebe metadados minimos no multipart e o PDF como documento principal da denuncia.
- O PDF deve conter endereco, conselho, respostas dinamicas e fotos, pois ele e a fonte completa de detalhes da denuncia para este contrato.
- Se futuramente o backend passar a aceitar JSON estruturado das respostas, isso deve ser tratado como evolucao de contrato fora deste MVP.

Exemplo conceitual do multipart:

```text
protocolo=DEN-2026-123456
profissao_id=1
regiao=sul
cep=58406000
estado=PB
cidade=Campina Grande
bairro=Santo Antonio
conselho_id=2
pdf=@denuncia_DEN-2026-123456.pdf;type=application/pdf
```

Resposta:

- `message`
- `protocolo`

Exemplo de resposta:

```json
{
  "message": "Denuncia registrada com sucesso.",
  "protocolo": "DEN-2026-123456"
}
```

Falha:

- Se a API retornar `error` ou `message`, mostrar esse texto ao usuario.
- Se nao houver mensagem da API, usar `Erro ao enviar denuncia. Tente novamente.`
- Durante falha de rede, manter o rascunho local intacto.

### Profissoes Para Documentos

`GET /api/profissoes`

Usado na tela de documentos norteadores.

Exemplo:

```json
[
  {
    "id": 1,
    "nome": "Odontologia",
    "descricao": "Documentos para odontologia.",
    "cor": "#24786B",
    "status": 1,
    "data_criacao": "2026-01-01T00:00:00.000Z",
    "data_update": "2026-01-01T00:00:00.000Z",
    "data_delete": null
  }
]
```

### Documentos Por Profissao

`GET /api/profissoes/{profissaoId}/documentos`

Mapeamento:

- `id`
- `profissao_id`
- `titulo`
- `descricao`
- `pontos_foco`
- `url_online`
- `arquivo`
- `foto_capa`
- `data_criacao`
- `data_update`

Regras:

- `pontos_foco` pode ser array, string JSON, texto com linhas ou objeto.
- `arquivo` e `foto_capa` podem ser URL absoluta ou caminho relativo.
- Caminho relativo deve virar URL usando host da API sem `/api`.

Exemplo:

```json
[
  {
    "id": 1,
    "profissao_id": 1,
    "titulo": "ECA - Estatuto da Crianca e do Adolescente",
    "descricao": "Lei no 8.069, de 13 de julho de 1990.",
    "pontos_foco": [
      { "titulo": "Art. 245", "pagina": 121 }
    ],
    "url_online": "https://example.com/eca.pdf",
    "arquivo": "/uploads/documentos/eca.pdf",
    "foto_capa": "/uploads/capas/eca.png",
    "data_criacao": "2026-01-01T00:00:00.000Z",
    "data_update": "2026-01-01T00:00:00.000Z"
  }
]
```

Exemplo de `pontos_foco` como string JSON tambem aceito:

```json
"[{\"titulo\":\"Art. 245\",\"pagina\":121}]"
```

Exemplo de `pontos_foco` como texto tambem aceito:

```text
Art. 245
Art. 227
```

## Validacoes

- CEP obrigatorio, 8 digitos e validado pela API.
- Rua obrigatoria, minimo 3 caracteres.
- Numero, estado, cidade, bairro e conselho obrigatorios.
- Campos dinamicos seguem `obrigatorio`, `opcoes_permitidas`, opcoes condicionais, formato de data/numero/CEP e limite de fotos.
- Data de nascimento nao pode ser futura quando campo/dica indicar nascimento.
- Fotos respeitam `max_fotos` e podem ser removidas antes do envio.

## Persistencia Local

- Salvar rascunho automaticamente por profissao enquanto o usuario preenche a denuncia.
- Se o usuario parar a denuncia no meio, fechar o app, voltar para inicio ou trocar de tela, o rascunho deve permanecer salvo.
- Na proxima vez que o usuario tentar fazer uma denuncia para a mesma profissao, antes de iniciar o wizard deve abrir modal perguntando se deseja continuar a denuncia anterior ou criar uma nova.
- O modal de rascunho deve aparecer somente depois que o formulario da profissao for carregado, para permitir sanitizar o rascunho contra o contrato atual.
- Se o usuario escolher continuar, restaurar endereco, respostas dinamicas e referencias de fotos validas.
- Se o usuario escolher criar uma nova, apagar o rascunho anterior daquela profissao e iniciar o fluxo limpo.
- Rascunhos de outras profissoes nao devem ser apagados.
- Estrutura do rascunho:
  - `professionId`
  - `address`
  - `dynamicAnswers`
  - `photoRefs`
  - `updatedAt`
- Ao restaurar:
  - Sanitizar respostas contra o formulario atual.
  - Remover respostas de campos que nao existem mais.
  - Normalizar switch condicional.
  - Validar fotos locais ainda existentes.
  - Limpar validacao derivada de CEP:
    - `validatedCep`
    - `state`
    - `city`
    - `neighborhood`
    - `councilRegion`
- Ao enviar com sucesso:
  - Remover rascunho da profissao.
  - Remover arquivos de fotos associados ao rascunho enviado.
  - Persistir a confirmacao com protocolo e caminho do PDF, conforme secao `Confirmacao De Denuncia`.
- Fotos:
  - Guardar arquivo no diretorio privado do app.
  - Persistir apenas referencia e metadados.
  - Nao manter base64 como armazenamento principal.

O rascunho local nao torna o fluxo offline. Para continuar e enviar uma denuncia, o app ainda precisa estar online para validar CEP, carregar formulario atualizado e enviar o PDF.

## PDF Da Denuncia

- O PDF deve reproduzir o resumo final.
- Cabecalho:
  - `Relatorio de Denuncia`.
  - Nome do Conselho Tutelar, ou fallback `Conselho Tutelar nao identificado`.
- Secoes:
  - Endereco e Conselho Tutelar.
  - Uma secao por passo dinamico.
- Campos textuais:
  - Tabela com pergunta e resposta.
- Fotos:
  - Galeria com imagens ajustadas proporcionalmente.
  - Nome do arquivo como legenda.
- Rodape:
  - `Powered by ProtegeSaude, {data pt-BR}`.
- O PDF gerado deve ser usado no multipart e tambem na tela de confirmacao.

## Testes

- Unitarios:
  - Normalizacao de `API_BASE_URL`.
  - Parsing de profissoes publicas.
  - Parsing de formulario publico.
  - Parsing de CEP valido e bloqueado.
  - Validacao de endereco.
  - Validacao de cada tipo de campo dinamico.
  - Sanitizacao de rascunho.
  - Normalizacao de URL de documentos.
  - Parsing de `pontos_foco`.
  - Geracao de protocolo.
- Widget tests:
  - Tela principal unificada e modal de anonimato.
  - Acoes dos cards.
  - Selecao de profissao.
  - Retomada ou descarte de rascunho.
  - Wizard bloqueando avanco invalido.
  - Endereco com CEP validado.
  - Campos dinamicos por tipo.
  - Upload/remocao de fotos.
  - Resumo com respostas e fotos.
  - Confirmacao com protocolo.
  - Documentos com estados de loading, erro, vazio e lista.
- Integracao:
  - Fluxo completo de denuncia com API mockada.
  - CEP com sucesso e bloqueio.
  - Geracao de PDF.
  - Envio multipart.
  - Download e abertura de documento.
- QA manual:
  - Android e iOS.
  - Permissoes de camera e galeria.
  - Teclado em campos numericos, texto e data.
  - Telas pequenas.
  - Sem internet: app deve bloquear consultas/envio com mensagem clara; nao ha modo offline completo.
  - Timeout da API.
  - PDF com varias paginas.
  - Fotos grandes.
  - Compartilhamento de PDF.
  - Links externos e telefone.

## Assumptions

- O backend atual continua sendo a fonte de verdade.
- Login/Cadastro ficam fora do MVP.
- O app sera criado em repositorio separado.
- A denuncia continua anonima.
- A tela `/home` deixa de existir; `/` passa a ser a tela principal unificada.
- O contrato atual sera mantido: os detalhes completos da denuncia seguem no PDF enviado para a API.
- Arquivos baixados e PDFs gerados ficam no diretorio privado do app e sao acessados por abrir/compartilhar.
