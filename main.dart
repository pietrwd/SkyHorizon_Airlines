// Exercício 1: Classes de Apoio

class Passageiro {
  String? nome;
  String? cpf;
  String? rg;
  String? email;
  String? celular;
}

class PlataformaVenda {
  int? codigoCanal;
  String? nomeCanal;
}

class Atendente {
  String? nome;
  String? matricula;
  String? cargo;
  String? email;
  String? celular;
  double? salario;
}


// Exercício 2 a 7: Classe Passagem
class Passagem {
  String? _codigoLocalizador = '';
  Passageiro? passageiro;
  PlataformaVenda? plataforma;
  Atendente? atendente;
  String? observacoes;

  // Exercício 2: Construtor Não Nomeado
  Passagem();

  // Exercício 3: Construtores Nomeados
  Passagem.somenteCodigo(String codigoLocalizador)
      : _codigoLocalizador = codigoLocalizador;

  Passagem.completa(
    String codigoLocalizador,
    Passageiro? passageiro,
    PlataformaVenda? plataforma,
    Atendente? atendente,
    String? observacoes,
  )   : _codigoLocalizador = codigoLocalizador,
        passageiro = passageiro,
        plataforma = plataforma,
        atendente = atendente,
        observacoes = observacoes;

  // Exercício 4: Construtores com Parâmetros Nomeados
  Passagem.codigoEPassageiro({String? codigoLocalizador, this.passageiro})
      : _codigoLocalizador = codigoLocalizador;

  Passagem.all(
    String codigoLocalizador, {
    this.passageiro,
    required this.plataforma,
    required this.atendente,
    this.observacoes,
  }) : _codigoLocalizador = codigoLocalizador;

  // Exercício 5: Getter e Setter tradicionais
  String? getCodigoLocalizador() {
    return _codigoLocalizador;
  }

  void setCodigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print('Código localizador de passagem inválido!');
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  // Exercício 6: Getter e Setter nativos do Dart
  String? get codigoLocalizador => _codigoLocalizador;

  set codigoLocalizador(String? codigoLocalizador) {
    if (codigoLocalizador == null || codigoLocalizador.isEmpty) {
      print('Código localizador de passagem inválido!');
      return;
    }
    _codigoLocalizador = codigoLocalizador;
  }

  // Exercício 7: Métodos de negócio
  void EmitirPassagem() {
    print('Passagem emitida com sucesso!');
  }

  bool CancelarPassagem() {
    print('Passagem cancelada com sucesso!');
    return true;
  }

  void AtualizarPassagem() {
    print('Passagem atualizada com sucesso!');
  }

  Passagem ConsultarPassagem(String codigo) {
    print('Passagem consultada com sucesso!');
    return Passagem();
  }
}


// Exercício 9: Mixins

mixin Logger {
  void log(String mensagem) {
    print(mensagem);
  }
}

mixin Auditoria {
  void auditar(String mensagem) {
    print('[Auditoria]: $mensagem');
  }
}


// Exercício 8, 9 e 10: PassagemPrimeiraClasse

class PassagemPrimeiraClasse extends Passagem with Logger, Auditoria {
  String? loungeAcesso;

  // Exercício 8: construtor especializado usando super.all
  PassagemPrimeiraClasse(
    String codigoLocalizador, {
    Passageiro? passageiro,
    required PlataformaVenda? plataforma,
    required Atendente? atendente,
    String? observacoes,
    required this.loungeAcesso,
  }) : super.all(
          codigoLocalizador,
          passageiro: passageiro,
          plataforma: plataforma,
          atendente: atendente,
          observacoes: observacoes,
        );

  // Exercício 10: Sobrescrita Polimórfica
  @override
  void AtualizarPassagem() {
    print('Passagem de Primeira Classe atualizada com sucesso!');
    log('Atualização realizada pelo atendente: ${atendente?.nome}');
    auditar('Verificação de segurança realizada para a Primeira Classe');
  }
}


// Exercício 10: main()

void main() {
  
  Passageiro passageiro1 = Passageiro()
    ..nome = 'João da Silva'
    ..cpf = '123.456.789-00'
    ..rg = '11.222.333-4'
    ..email = 'joao.silva@email.com'
    ..celular = '(11) 91234-5678';

  PlataformaVenda plataforma1 = PlataformaVenda()
    ..codigoCanal = 1
    ..nomeCanal = 'Site Oficial SkyHorizon';

  Atendente atendente1 = Atendente()
    ..nome = 'Maria Souza'
    ..matricula = 'AT-2026-001'
    ..cargo = 'Atendente de Balcão'
    ..email = 'maria.souza@skyhorizon.com'
    ..celular = '(11) 98888-0000'
    ..salario = 3200.00;

  print('--- Passagem padrão (construtor somenteCodigo) ---');
  Passagem passagem1 = Passagem.somenteCodigo('SH12345');
  print('Código: ${passagem1.getCodigoLocalizador()}');
  passagem1.setCodigoLocalizador('');
  passagem1.setCodigoLocalizador('SH54321');
  print('Novo código: ${passagem1.getCodigoLocalizador()}');
  passagem1.EmitirPassagem();

  print('\n--- Passagem padrão (construtor all com parâmetros nomeados) ---');
  Passagem passagem2 = Passagem.all(
    'SH99887',
    passageiro: passageiro1,
    plataforma: plataforma1,
    atendente: atendente1,
    observacoes: 'Cliente solicitou refeição vegetariana.',
  );
  print('Código: ${passagem2.codigoLocalizador}');
  print('Passageiro: ${passagem2.passageiro?.nome}');
  passagem2.AtualizarPassagem();
  passagem2.CancelarPassagem();

  print('\n--- PassagemPrimeiraClasse (construtor especializado) ---');
  PassagemPrimeiraClasse passagemVip = PassagemPrimeiraClasse(
    'SH-VIP-001',
    passageiro: passageiro1,
    plataforma: plataforma1,
    atendente: atendente1,
    observacoes: 'Passageiro Primeira Classe - prioridade máxima.',
    loungeAcesso: 'Sala VIP Internacional - Terminal 3',
  );

  print('Código: ${passagemVip.codigoLocalizador}');
  print('Lounge de acesso: ${passagemVip.loungeAcesso}');
  passagemVip.EmitirPassagem();
  passagemVip.AtualizarPassagem(); 

  Passagem consultada = passagemVip.ConsultarPassagem('SH-VIP-001');
  print('Consulta retornou nova instância: ${consultada.codigoLocalizador == '' }');
}
