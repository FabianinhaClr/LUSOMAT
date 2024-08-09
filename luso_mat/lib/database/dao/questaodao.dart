import 'package:flutter/material.dart';
import 'package:oficial_lusomat/model/questao.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../db.dart';
import 'package:oficial_lusomat/screens/questoes.dart';

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
  db.insert('questao', {
    'id': 1,
    'questao':
        'O rap, palavra formada pelas iniciais de rhythm and poetry (ritmo e poesia), junto com as linguagens da dança (o break dancing) e das artes plásticas (o grafite), seria difundido, para além dos guetos, com o nome de cultura hip hop. O break dancing surge como uma dança de rua. O grafite nasce de assinaturas inscritas pelos jovens com sprays nos muros, trens e estações de metrô de Nova York. As linguagens do rap, do break dancing e do grafite se tornaram os pilares da cultura hip hop. Entre as manifestações da cultura hip hop apontadas no texto, o break se caracteriza como um tipo de dança que representa aspectos contemporâneos por meio de movimentos',
    'materia': 'Português',
    'ano': 2015,
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
    'ano': 2015,
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
    'ano': 2015,
    'opcaoA': 'Justificar a dominação estamental / revoltas camponestas.',
    'opcaoB': 'Subverter a hierarquia social / centralização monárquica. ',
    'opcaoC': 'Impedir a igualdade jurídica / revoluções burguesas.',
    'opcaoD': 'Controlar a exploração econômica / unificação monetária.',
    'resposta': 'A'
  });
  db.insert('questao', {
    'id': 4,
    'questao':
        'A língua de que usam, por toda a costa, carece de três letras; convém a saber, não se acha nela F, nem L, nem R, coisa digna de espanto, porque assim não têm Fé, nem Lei, nem Rei, e dessa maneira vivem desordenadamente, sem terem além disto conta, nem peso, nem medida. A observação do cronista português Pero de Magalhães de Gândavo, em 1576, sobre a ausência das letras F, L e R na língua mencionada, demonstra a',
    'materia': 'Português',
    'ano': 2015,
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
    'ano': 2015,
    'opcaoA': 'Desestatização da economia.',
    'opcaoB': 'Instauração de um partido único.',
    'opcaoC': 'Extinção gradual das classes sociais.',
    'opcaoD': 'Formação de sindicatos trabalhistas.',
    'resposta': 'C'
  });

  db.insert('questao', {
    'id': 7,
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
}
