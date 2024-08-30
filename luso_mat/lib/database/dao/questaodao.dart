import 'package:flutter/material.dart';
import 'package:oficial_lusomat/model/questao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../db.dart';
import 'package:oficial_lusomat/screens/questoes.dart';
import 'package:oficial_lusomat/screens/simulado.dart';

Future<int> insertQuestao(Questao questao) async {
  Database db = await getDatabase();
  return db.insert('questao', questao.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<List<Map>> findall({String? materia, String? ano}) async {
  Database db = await getDatabase();

  String? whereClause;
  List<String> whereArgs = [];

  if (materia != null && ano != null) {
    whereClause = "materia = ? AND ano = ?";
    whereArgs = [materia, ano];
  } else if (materia != null) {
    whereClause = "materia = ?";
    whereArgs = [materia];
  } else if (ano != null) {
    whereClause = "ano = ?";
    whereArgs = [ano];
  }

  List<Map<String, dynamic>> dados = await db.query(
    'questao',
    where: whereClause,
    whereArgs: whereArgs,
  );

  return dados;
}

void insertTodasQuestao() async {
  Database db = await getDatabase();

// 3 PORTUGUES 2018
  db.insert('questao', {
    'id': 1,
    'questao':
        'O rap, palavra formada pelas iniciais de rhythm and poetry (ritmo e poesia), junto com as linguagens da dança (o break dancing) e das artes plásticas (o grafite), seria difundido, para além dos guetos, com o nome de cultura hip hop. O break dancing surge como uma dança de rua. O grafite nasce de assinaturas inscritas pelos jovens com sprays nos muros, trens e estações de metrô de Nova York. As linguagens do rap, do break dancing e do grafite se tornaram os pilares da cultura hip hop. Entre as manifestações da cultura hip hop apontadas no texto, o break se caracteriza como um tipo de dança que representa aspectos contemporâneos por meio de movimentos',
    'materia': 'Português',
    'ano': 2018,
    'opcaoA': 'retilíneos, como crítica aos indivíduos alienados.',
    'opcaoB': 'improvisados, como expressão da dinâmica da vida urbana.',
    'opcaoC': 'suaves, como sinônimo da rotina dos espaços públicos',
    'opcaoD': 'ritmados pela sola dos sapatos, como símbolo de protesto.',
    'resposta': 'B'
  });
  db.insert('questao', {
    'id': 2,
    'questao':
        'Apesar de seu disfarce de iniciativa e otimismo, o homem moderno está esmagado por um profundo sentimento de impotência que o faz olhar fixamente e, como que paralisado, para as catástrofes que se avizinham. Por isso, desde já, saliente-se a necessidade de uma permanente atitude crítica, o único modo pelo qual o homem realizará sua vocação natural de integrar-se, superando a atitude do simples ajustamento ou acomodação, apreendendo temas e tarefas de sua época. Paulo Freire defende que a superação das dificuldades e a apreensão da realidade atual será obtida pelo:',
    'materia': 'Português',
    'ano': 2018,
    'opcaoA': 'desenvolvimento do pensamento autônomo.',
    'opcaoB': 'obtenção de qualificação profissional.',
    'opcaoC': 'resgate de valores tradicionais.',
    'opcaoD': 'realização de desejos pessoais.',
    'resposta': 'A'
  });
  db.insert('questao', {
    'id': 3,
    'questao':
        'A casa de Deus, que acreditam una, está, portanto, dividida em três: uns oram, outros combatem, outros, enfim, trabalham. Essas três partes que coexistem não suportam ser separadas; os serviços prestados por uma são a condição das obras das outras duas; cada uma por sua vez encarrega-se de aliviar o conjunto. Assim a lei pode triunfar e o mundo gozar da paz. A ideologia apresentada por Aldalberon de Laon foi produzida durante a Idade Média. Um objetivo de tal ideologia e um processo que a ela se opôs estão indicados, respectivamente, em:',
    'materia': 'Português',
    'ano': 2018,
    'opcaoA': 'Justificar a dominação estamental / revoltas camponestas.',
    'opcaoB': 'Subverter a hierarquia social / centralização monárquica. ',
    'opcaoC': 'Impedir a igualdade jurídica / revoluções burguesas.',
    'opcaoD': 'Controlar a exploração econômica / unificação monetária.',
    'resposta': 'A'
  });
// 3 PORTUGUES 2019
  db.insert('questao', {
    'id': 4,
    'questao':
        'A língua de que usam, por toda a costa, carece de três letras; convém a saber, não se acha nela F, nem L, nem R, coisa digna de espanto, porque assim não têm Fé, nem Lei, nem Rei, e dessa maneira vivem desordenadamente, sem terem além disto conta, nem peso, nem medida. A observação do cronista português Pero de Magalhães de Gândavo, em 1576, sobre a ausência das letras F, L e R na língua mencionada, demonstra a',
    'materia': 'Português',
    'ano': 2019,
    'opcaoA': 'Simplicidade da organização social das tribos brasileiras.',
    'opcaoB':
        'Dominação portuguesa imposta aos índios no início da colonização.',
    'opcaoC':
        'Superioridade da sociedade europeia em relação à sociedade indígena.',
    'opcaoD':
        'Incompreensão dos valores socioculturais indígenas pelos portugueses.',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 5,
    'questao':
        'O principal articulador do atual modelo econômico chinês argumenta que o mercado é só um instrumento econômico, que se emprega de forma indistinta tanto no capitalismo como no socialismo. Porém os próprios chineses já estão sentindo, na sua sociedade, o seu real significado: o mercado não é algo neutro, ou um instrumental técnico que possibilita à sociedade utilizá-lo para a construção e edificação do socialismo. Ele é, ao contrário do que diz o articulador, um instrumento do capitalismo e é inerente à sua estrutura como modo de produção. A sua utilização está levando a uma polarização da sociedade chinesa. No texto, as reformas econômicas ocorridas na China são colocadas como antagônicas à construção de um país socialista. Nesse contexto, a característica fundamental do socialismo, à qual o modelo econômico chinês atual se contrapõe é a',
    'materia': 'Português',
    'ano': 2019,
    'opcaoA': 'Desestatização da economia.',
    'opcaoB': 'Instauração de um partido único.',
    'opcaoC': 'Extinção gradual das classes sociais.',
    'opcaoD': 'Formação de sindicatos trabalhistas.',
    'resposta': 'C'
  });
  db.insert('questao', {
    'id': 6,
    'questao':
        'Ler não é decifrar, como num jogo de adivinhações, o sentido de um texto. É, a partir do texto, ser capaz de atribuir-lhe significado, conseguir relacioná-lo a todos os outros textos significativos para cada um, reconhecer nele o tipo de leitura que o seu autor pretendia e, dono da própria vontade, entregar-se a essa leitura, ou rebelar-se contra ela, propondo uma outra não prevista. Nesse texto, a autora apresenta reflexões sobre o processo de produção de sentidos, valendo-se da metalinguagem. Essa função da linguagem torna-se evidente pelo fato de o texto',
    'materia': 'Português',
    'ano': 2019,
    'opcaoA': 'ressaltar a importância da intertextualidade..',
    'opcaoB': 'propor leituras diferentes das previsíveis.',
    'opcaoC': 'apresentar o ponto de vista da autora.',
    'opcaoD': 'discorrer sobre o ato de leitura.',
    'resposta': 'D'
  });
// 3 PORTUGUES 2020
  db.insert('questao', {
    'id': 7,
    'questao':
        'O hoax, como é chamado qualquer boato ou farsa na internet, pode espalhar vírus entre os seus contatos. Falsos sorteios de celulares ou frases que Clarice Lispector nunca disse são exemplos de hoax. Trata-se de boatos recebidos por e-mail ou compartilhados em redes sociais. Em geral, são mensagens dramáticas ou alarmantes que acompanham imagens chocantes, falam de crianças doentes ou avisam sobre falsos vírus. O objetivo de quem cria esse tipo de mensagem pode ser apenas se divertir com a brincadeira (de mau gosto), prejudicar a imagem de uma empresa ou espalhar uma ideologia política. Se o hoax for do tipo phishing (derivado de fishing, pescaria, em inglês) o problema pode ser mais grave: o usuário que clicar pode ter seus dados pessoais ou bancários roubados por golpistas. Por isso é tão importante ficar atento. Ao discorrer sobre os hoaxes, o texto sugere ao leitor, como estratégia para evitar essa ameaça,',
    'materia': 'Português',
    'ano': 2020,
    'opcaoA': 'recusar convites de jogos e brincadeiras feitos pela internet.',
    'opcaoB': 'analisar a linguagem utilizada nas mensagens recebidas.',
    'opcaoC': 'classificar os contatos presentes em suas redes sociais.',
    'opcaoD': 'utilizar programas que identifiquem falsos vírus.',
    'resposta': 'B'
  });
  db.insert('questao', {
    'id': 8,
    'questao':
        'Mandinga – Era a denominação que, no período das grandes navegações, os portugueses davam à costa ocidental da África. A palavra se tornou sinônimo de feitiçaria porque os exploradores lusitanos consideravam bruxos os africanos que ali habitavam – é que eles davam indicações sobre a existência de ouro na região. Em idioma nativo, manding designava terra de feiticeiros. A palavra acabou virando sinônimo de feitiço, sortilégio. No texto, evidencia-se que a construção do significado da palavra mandinga resulta de um(a)',
    'materia': 'Português',
    'ano': 2020,
    'opcaoA': 'contexto sócio-histórico.',
    'opcaoB': 'diversidade étnica.',
    'opcaoC': 'descoberta geográfica.',
    'opcaoD': 'contraste cultural.',
    'resposta': 'A'
  });
  db.insert('questao', {
    'id': 9,
    'questao':
        'Texto I \n Nesta época do ano, em que comprar compulsivamente é a principal preocupação de boa parte da população, é imprescindível refletirmos sobre a importância da mídia na propagação de determinados comportamentos que induzem ao consumismo exacerbado. No clássico livro O capital, Karl Marx aponta que no capitalismo os bens materiais, ao serem fetichizados, passam a assumir qualidades que vão além da mera materialidade. As coisas são personificadas e as pessoas são coisificadas. Em outros termos, um automóvel de luxo, uma mansão em um bairro nobre ou a ostentação de objetos de determinadas marcas famosas são alguns dos fatores que conferem maior valorização e visibilidade social a um indivíduo. \n Texto II \n Todos os dias, em algum nível, o consumo atinge nossa vida, modifica nossas relações, gera e rege sentimentos, engendra fantasias, aciona comportamentos, faz sofrer, faz gozar. Às vezes constrangendo-nos em nossas ações no mundo, humilhando e aprisionando, às vezes ampliando nossa imaginação e nossa capacidade de desejar, consumimos e somos consumidos. Numa época toda codificada como a nossa, o código da alma (o código do ser) virou código do consumidor! Fascínio pelo consumo, fascínio do consumo. Felicidade, luxo, bem-estar, boa forma, lazer, elevação espiritual, saúde, turismo, sexo, família e corpo são hoje reféns da engrenagem do consumo.',
    'materia': 'Português',
    'ano': 2020,
    'opcaoA': 'desperta o desejo de ascensão social.',
    'opcaoB': 'provoca mudanças nos valores sociais.',
    'opcaoC': 'advém de necessidades suscitadas pela publicidade.',
    'opcaoD': 'deriva da inerente busca por felicidade pelo ser humano.',
    'resposta': 'C'
  });
// 1 PORTUGUES 2021
  db.insert('questao', {
    'id': 10,
    'questao':
        'Quem procura a essência de um conto no espaço que fica entre a obra e seu autor comete um erro: é muito melhor procurar não no terreno que fica entre o escritor e sua obra, mas justamente no terreno que fica entre o texto e seu leitor. A progressão temática de um texto pode ser estruturada por meio de diferentes recursos coesivos, entre os quais se destaca a pontuação. Nesse texto, o emprego dos dois pontos caracteriza uma operação textual realizada com a finalidade de',
    'materia': 'Português',
    'ano': 2021,
    'opcaoA': 'comparar elementos opostos.',
    'opcaoB': 'relacionar informações gradativas.',
    'opcaoC': 'intensificar um problema conceitual.',
    'opcaoD': 'introduzir um argumento esclarecedor.',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 123,
    'questao':
        'O rap, palavra formada pelas iniciais de rhythm and poetry (ritmo e poesia), junto com as linguagens da dança (o break dancing) e das artes plásticas (o grafite), seria difundido, para além dos guetos, com o nome de cultura hip hop. O break dancing surge como uma dança de rua. O grafite nasce de assinaturas inscritas pelos jovens com sprays nos muros, trens e estações de metrô de Nova York. As linguagens do rap, do break dancing e do grafite se tornaram os pilares da cultura hip hop. Entre as manifestações da cultura hip hop apontadas no texto, o break se caracteriza como um tipo de dança que representa aspectos contemporâneos por meio de movimentos',
    'materia': 'Português',
    'ano': 2021,
    'opcaoA': 'retilíneos, como crítica aos indivíduos alienados.',
    'opcaoB': 'improvisados, como expressão da dinâmica da vida urbana.',
    'opcaoC': 'suaves, como sinônimo da rotina dos espaços públicos',
    'opcaoD': 'ritmados pela sola dos sapatos, como símbolo de protesto.',
    'resposta': 'B'
  });
  // 1 PORTUGUES 2022
  db.insert('questao', {
    'id': 22,
    'questao':
        'Se tudo é para ontem, se a vida engata uma primeira e sai em disparada, se não há mais tempo para paradas estratégicas, caímos fatalmente no vício de querer que os amores sejam igualmente resolvidos num átimo de segundo. Temos pressa para ouvir “eu te amo”. Não vemos a hora de que fiquem estabelecidas as regras de convívio: somos namorados, ficantes, casados, amantes? Urgência emocional. Uma cilada. Associamos diversas palavras ao AMOR: paixão, romance, sexo, adrenalina, palpitação. Esquecemos, no entanto, da palavra que viabiliza esse sentimento: “paciência”. Amor sem paciência não vinga. Amor não pode ser mastigado e engolido com emergência, com fome desesperada. É uma refeição que pode durar uma vida. Nesse texto de opinião, as marcas linguísticas revelam uma situação distensa e de pouca formalidade, o que se evidencia pelo(a)',
    'materia': 'Português',
    'ano': 2022,
    'opcaoA':
        'impessoalização ao longo do texto, como em: “se não há mais tempo”.',
    'opcaoB':
        'construção de uma atmosfera de urgência, em palavras como: “pressa”.',
    'opcaoC':
        'repetição de uma determinada estrutura sintática, como em: “Se tudo é para ontem”.',
    'opcaoD':
        'emprego de metáforas, como em: “a vida engata uma primeira e sai em disparada”.',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 2387,
    'questao':
        'A sessão do Comitê Olímpico Internacional (COI) aprovou uma mudança histórica e inédita no lema olímpico, criado em 1894 pelo Barão Pierre de Coubertin para expressar os valores e a excelência do esporte. Mais de 120 anos depois, o lema tem sua primeira alteração para ressaltar a solidariedade e incluir a palavra “juntos”: mais rápido, mais alto, mais forte — juntos. A mudança foi aprovada por unanimidade pelos membros do COI e celebrada pelo presidente da entidade. De acordo com o texto, a alteração do lema olímpico teve como objetivo a',
    'materia': 'Português',
    'ano': 2022,
    'opcaoA': 'unificação do lema anterior ao atual.',
    'opcaoB': 'aproximação entre o lema olímpico e o COI.',
    'opcaoC': 'junção do lema olímpico com os princípios esportivos.',
    'opcaoD': 'associação entre o lema olímpico e a cooperatividade.',
    'resposta': 'B'
  });

  // 1 PORTUGUES 2023
  db.insert('questao', {
    'id': 23,
    'questao':
        'A sessão do Comitê Olímpico Internacional (COI) aprovou uma mudança histórica e inédita no lema olímpico, criado em 1894 pelo Barão Pierre de Coubertin para expressar os valores e a excelência do esporte. Mais de 120 anos depois, o lema tem sua primeira alteração para ressaltar a solidariedade e incluir a palavra “juntos”: mais rápido, mais alto, mais forte — juntos. A mudança foi aprovada por unanimidade pelos membros do COI e celebrada pelo presidente da entidade. De acordo com o texto, a alteração do lema olímpico teve como objetivo a',
    'materia': 'Português',
    'ano': 2023,
    'opcaoA': 'unificação do lema anterior ao atual.',
    'opcaoB': 'aproximação entre o lema olímpico e o COI.',
    'opcaoC': 'junção do lema olímpico com os princípios esportivos.',
    'opcaoD': 'associação entre o lema olímpico e a cooperatividade.',
    'resposta': 'B'
  });
  db.insert('questao', {
    'id': 268,
    'questao':
        'Se tudo é para ontem, se a vida engata uma primeira e sai em disparada, se não há mais tempo para paradas estratégicas, caímos fatalmente no vício de querer que os amores sejam igualmente resolvidos num átimo de segundo. Temos pressa para ouvir “eu te amo”. Não vemos a hora de que fiquem estabelecidas as regras de convívio: somos namorados, ficantes, casados, amantes? Urgência emocional. Uma cilada. Associamos diversas palavras ao AMOR: paixão, romance, sexo, adrenalina, palpitação. Esquecemos, no entanto, da palavra que viabiliza esse sentimento: “paciência”. Amor sem paciência não vinga. Amor não pode ser mastigado e engolido com emergência, com fome desesperada. É uma refeição que pode durar uma vida. Nesse texto de opinião, as marcas linguísticas revelam uma situação distensa e de pouca formalidade, o que se evidencia pelo(a)',
    'materia': 'Português',
    'ano': 2023,
    'opcaoA':
        'impessoalização ao longo do texto, como em: “se não há mais tempo”.',
    'opcaoB':
        'construção de uma atmosfera de urgência, em palavras como: “pressa”.',
    'opcaoC':
        'repetição de uma determinada estrutura sintática, como em: “Se tudo é para ontem”.',
    'opcaoD':
        'emprego de metáforas, como em: “a vida engata uma primeira e sai em disparada”.',
    'resposta': 'D'
  });
// MATEMÁTICA 2022
  db.insert('questao', {
    'id': 11,
    'questao':
        'Uma cozinheira produz docinhos especiais por encomenda. Usando uma receita-base de massa, ela prepara uma porção, com a qual produz 50 docinhos maciços de formato esférico, com 2 cm de diâmetro. Um cliente encomenda 150 desses docinhos, mas pede que cada um tenha formato esférico com 4 cm de diâmetro. A cozinheira pretende preparar o número exato de porções da receita-base de massa necessário para produzir os docinhos dessa encomenda. Quantas porções da receita-base de massa ela deve preparar para atender esse cliente?',
    'ano': 2022,
    'opcaoA': '2',
    'opcaoB': '3',
    'opcaoC': '6',
    'opcaoD': '24',
    'materia': 'Matemática',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 11111,
    'questao':
        'A caixa-d’água de um edifício terá a forma de um paralelepípedo retângulo reto com volume igual a 28 080 litros. Em uma maquete que representa o edifício, a caixa-d’água tem dimensões 2 cm × 3,51 cm × 4 cm. Dado: 1 dm³ = 1 L. A escala usada pelo arquiteto foi de',
    'ano': 2022,
    'opcaoA': '1 : 10',
    'opcaoB': '1 : 100',
    'opcaoC': '1 : 1 000',
    'opcaoD': '1 : 10 000',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  // MATEMÁTICA 2020
  db.insert('questao', {
    'id': 13,
    'questao':
        'A caixa-d’água de um edifício terá a forma de um paralelepípedo retângulo reto com volume igual a 28 080 litros. Em uma maquete que representa o edifício, a caixa-d’água tem dimensões 2 cm × 3,51 cm × 4 cm. Dado: 1 dm³ = 1 L. A escala usada pelo arquiteto foi de',
    'ano': 2020,
    'opcaoA': '1 : 10',
    'opcaoB': '1 : 100',
    'opcaoC': '1 : 1 000',
    'opcaoD': '1 : 10 000',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  db.insert('questao', {
    'id': 14,
    'questao':
        'Nos livros Harry Potter, um anagrama do nome do personagem “TOM MARVOLO RIDDLE” gerou a frase “I AM LORD VOLDEMORT”. Suponha que Harry quisesse formar todos os anagramas da frase “I AM POTTER”, de tal forma que as vogais e consoantes aparecessem sempre intercaladas, e sem considerar o espaçamento entre as letras. Nessas condições, o número de anagramas formados é dado por',
    'ano': 2020,
    'opcaoA': '4! 5!',
    'opcaoB': '2 × 4! 5!',
    'opcaoC': '9! / 2',
    'opcaoD': '4! 5! / 2',
    'materia': 'Matemática',
    'resposta': 'D'
  });

  db.insert('questao', {
    'id': 15,
    'questao':
        'Em um determinado ano, os computadores da receita federal de um país identificaram como inconsistentes 20% das declarações de imposto de renda que lhe foram encaminhadas. Uma declaração é classificada como inconsistente quando apresenta algum tipo de erro ou conflito nas informações prestadas. Essas declarações consideradas inconsistentes foram analisadas pelos auditores, que constataram que 25% delas eram fraudulentas. Constatou-se ainda que, dentre as declarações que não apresentaram inconsistências, 6,25% eram fraudulentas. Qual é a probabilidade de, nesse ano, a declaração de um contribuinte ser considerada inconsistente, dado que ela era fraudulenta?',
    'ano': 2020,
    'opcaoA': '0,0500',
    'opcaoB': '0,1000!',
    'opcaoC': '0,5000',
    'opcaoD': '0,3125',
    'materia': 'Matemática',
    'resposta': 'D'
  });

  // MATEMÁTICA 2018
  db.insert('questao', {
    'id': 16,
    'questao':
        'Os tipos de prata normalmente vendidos são 975, 950 e 925. Essa classificação é feita de acordo com a sua pureza. Por exemplo, a prata 975 é a substância constituída de 975 partes de prata pura e 25 partes de cobre em 1 000 partes da substância. Já a prata 950 é constituída de 950 partes de prata pura e 50 de cobre em 1 000; e a prata 925 é constituída de 925 partes de prata pura e 75 partes de cobre em 1 000. Um ourives possui 10 gramas de prata 925 e deseja obter 40 gramas de prata 950 para produção de uma joia. Nessas condições, quantos gramas de prata e de cobre, respectivamente, devem ser fundidos com os 10 gramas de prata 925?',
    'ano': 2018,
    'opcaoA': '29,25 e 0,75',
    'opcaoB': '28,75 e 1,25',
    'opcaoC': '28,50 e 1,50',
    'opcaoD': '27,75 e 2,25',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  db.insert('questao', {
    'id': 17,
    'questao':
        'Uma empresa especializada em conservação de piscinas utiliza um produto para tratamento da água cujas especificações técnicas sugerem que seja adicionado 1,5 mL desse produto para cada 1 000 L de água da piscina. Essa empresa foi contratada para cuidar de uma piscina de base retangular, de profundidade constante igual a 1,7 m, com largura e comprimento iguais a 3 m e 5 m, respectivamente. O nível da lâmina d’água dessa piscina é mantido a 50 cm da borda da piscina. A quantidade desse produto, em mililitro, que deve ser adicionada a essa piscina de modo a atender às suas especificações técnicas é',
    'ano': 2018,
    'opcaoA': '11,25.',
    'opcaoB': '27,00.',
    'opcaoC': '28,80.',
    'opcaoD': '32,25.',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  // MATEMÁTICA 2019
  db.insert('questao', {
    'id': 18,
    'questao':
        'Densidade absoluta (d) é a razão entre a massa de um corpo e o volume por ele ocupado. Um professor propôs à sua turma que os alunos analisassem a densidade de três corpos: dA, dB e dC. Os alunos verificaram que o corpo A possuía 1,5 vez a massa do corpo B e esse, por sua vez, tinha 3/4 da massa do corpo C. Observaram, ainda, que o volume do corpo A era o mesmo do corpo B e 20% maior do que o volume do corpo C. Após a análise, os alunos ordenaram corretamente as densidades desses corpos da seguinte maneira',
    'ano': 2019,
    'opcaoA': 'dB < dA < dC',
    'opcaoB': 'dB = dA < dC',
    'opcaoC': 'dC < dB = dA',
    'opcaoD': ' dB < dC < dA',
    'materia': 'Matemática',
    'resposta': 'A'
  });
  db.insert('questao', {
    'id': 1799,
    'questao':
        'Uma empresa especializada em conservação de piscinas utiliza um produto para tratamento da água cujas especificações técnicas sugerem que seja adicionado 1,5 mL desse produto para cada 1 000 L de água da piscina. Essa empresa foi contratada para cuidar de uma piscina de base retangular, de profundidade constante igual a 1,7 m, com largura e comprimento iguais a 3 m e 5 m, respectivamente. O nível da lâmina d’água dessa piscina é mantido a 50 cm da borda da piscina. A quantidade desse produto, em mililitro, que deve ser adicionada a essa piscina de modo a atender às suas especificações técnicas é',
    'ano': 2019,
    'opcaoA': '11,25.',
    'opcaoB': '27,00.',
    'opcaoC': '28,80.',
    'opcaoD': '32,25.',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  // MATEMÁTICA 2021
  db.insert('questao', {
    'id': 19,
    'questao':
        'Sob a orientação de um mestre de obras, João e Pedro trabalharam na reforma de um edifício. João efetuou reparos na parte hidráulica nos andares 1, 3, 5, 7, e assim sucessivamente, de dois em dois andares. Pedro trabalhou na parte elétrica nos andares 1, 4, 7, 10, e assim sucessivamente, de três em três andares. Coincidentemente, terminaram seus trabalhos no último andar. Na conclusão da reforma, o mestre de obras informou, em seu relatório, o número de andares do edifício. Sabe-se que, ao longo da execução da obra, em exatamente 20 andares, foram realizados reparos nas partes hidráulica e elétrica por João e Pedro. Qual é o número de andares desse edifício?',
    'ano': 2021,
    'opcaoA': '40',
    'opcaoB': '60',
    'opcaoC': '100',
    'opcaoD': '115',
    'materia': 'Matemática',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 17455,
    'questao':
        'Uma empresa especializada em conservação de piscinas utiliza um produto para tratamento da água cujas especificações técnicas sugerem que seja adicionado 1,5 mL desse produto para cada 1 000 L de água da piscina. Essa empresa foi contratada para cuidar de uma piscina de base retangular, de profundidade constante igual a 1,7 m, com largura e comprimento iguais a 3 m e 5 m, respectivamente. O nível da lâmina d’água dessa piscina é mantido a 50 cm da borda da piscina. A quantidade desse produto, em mililitro, que deve ser adicionada a essa piscina de modo a atender às suas especificações técnicas é',
    'ano': 2021,
    'opcaoA': '11,25.',
    'opcaoB': '27,00.',
    'opcaoC': '28,80.',
    'opcaoD': '32,25.',
    'materia': 'Matemática',
    'resposta': 'B'
  });

  // MATEMÁTICA 2023
  db.insert('questao', {
    'id': 20,
    'questao':
        'Ao escutar à notícia de que um filme recém-lançado arrecadou, no primeiro mês de lançamento, R\$ 1,35 bilhão em bilheteria, um estudante escreveu corretamente o número que representa essa quantia, com todos os seus algarismos. O número escrito pelo estudante foi',
    'ano': 2023,
    'opcaoA': '1 350 000,00',
    'opcaoB': '13 500 000,00',
    'opcaoC': '135 000 000,00',
    'opcaoD': '1 350 000 000,00',
    'materia': 'Matemática',
    'resposta': 'D'
  });
  db.insert('questao', {
    'id': 191919,
    'questao':
        'Sob a orientação de um mestre de obras, João e Pedro trabalharam na reforma de um edifício. João efetuou reparos na parte hidráulica nos andares 1, 3, 5, 7, e assim sucessivamente, de dois em dois andares. Pedro trabalhou na parte elétrica nos andares 1, 4, 7, 10, e assim sucessivamente, de três em três andares. Coincidentemente, terminaram seus trabalhos no último andar. Na conclusão da reforma, o mestre de obras informou, em seu relatório, o número de andares do edifício. Sabe-se que, ao longo da execução da obra, em exatamente 20 andares, foram realizados reparos nas partes hidráulica e elétrica por João e Pedro. Qual é o número de andares desse edifício?',
    'ano': 2023,
    'opcaoA': '40',
    'opcaoB': '60',
    'opcaoC': '100',
    'opcaoD': '115',
    'materia': 'Matemática',
    'resposta': 'D'
  });
}
