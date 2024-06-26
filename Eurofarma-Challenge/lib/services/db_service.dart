import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  static Database? _database;

  DBService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'pharmaconnect.db');
    return await openDatabase(
      path,
      version: 2, // Atualizado para a nova versão do banco de dados
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE profiles(
        userId INTEGER PRIMARY KEY,
        name TEXT,
        certificateName TEXT,
        email TEXT,
        bio TEXT,
        birthDate TEXT,
        occupation TEXT,
        company TEXT,
        position TEXT,
        linkedin TEXT,
        twitter TEXT,
        github TEXT,
        customLink TEXT,
        course TEXT,
        institution TEXT,
        educationType TEXT,
        isCompleted INTEGER,
        interests TEXT,
        personalityType TEXT,
        hasCompletedTest INTEGER DEFAULT 0,
        FOREIGN KEY (userId) REFERENCES users (userId)
      )
    ''');
    await db.execute('''
      CREATE TABLE topics(
        topicId INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');
    await db.execute('''
      CREATE TABLE courses(
        courseId INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        imageUrl TEXT,
        instructors TEXT,
        duration TEXT,
        topicId INTEGER,
        FOREIGN KEY (topicId) REFERENCES topics(topicId)
      )
    ''');
    await db.execute('''
      CREATE TABLE lessons(
        lessonsId INTEGER PRIMARY KEY AUTOINCREMENT,
        courseId INTEGER,
        title TEXT,
        description TEXT,
        videoUrl TEXT,
        FOREIGN KEY (courseId) REFERENCES courses (courseId)
      )
    ''');
    await db.execute('''
        CREATE TABLE user_courses (
          userId INTEGER,
          courseId INTEGER,
          progress REAL,
          status TEXT,
          PRIMARY KEY (userId, courseId),
          FOREIGN KEY(userId) REFERENCES users(userId),
          FOREIGN KEY(courseId) REFERENCES courses(courseId)
        )
        ''');
    await db.execute('''
        CREATE TABLE user_lessons (
          userId INTEGER,
          courseId INTEGER,
          lessonId INTEGER,
          PRIMARY KEY (userId, courseId, lessonId),
          FOREIGN KEY (userId) REFERENCES users(userId),
          FOREIGN KEY (courseId) REFERENCES courses(courseId),
          FOREIGN KEY (lessonId) REFERENCES lessons(lessonId)
        )
        ''');

    // Insert initial topics
    await db.insert('topics', {'name': 'Programação'});
    await db.insert('topics', {'name': 'Front-end'});
    await db.insert('topics', {'name': 'Desenvolvimento Pessoal'});
    await db.insert('topics', {'name': 'Marketing'});

    // Insert initial user
    await db.insert(
        'users', {'email': 'user1@eurofarma.com', 'password': 'senha123'});
    await db.insert(
        'users', {'email': 'user2@eurofarma.com', 'password': 'senha123'});
    await db.insert(
        'users', {'email': 'suporte@eurofarma.com', 'password': 'senha123'});

    // Insert initial profile
    await db.insert('profiles', {
      'userId': 1,
      'name': 'User1',
      'certificateName': 'User1',
      'email': 'user1@eurofarma.com',
      'bio': 'Eu sou o User1.',
      'birthDate': '01-01-2000',
      'occupation': 'Desenvolvedor',
      'company': 'Eurofarma',
      'position': 'QA',
      'linkedin': 'https://www.linkedin.com/in/user1',
      'twitter': 'https://twitter.com/user1',
      'github': 'https://github.com/user1',
      'customLink': '',
      'course': 'Ciências da Computação',
      'institution': 'Universidade ABC',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Programação, IA, QA, Liderança, Organização',
      'personalityType': 'INTJ',
    });

    await db.insert('profiles', {
      'userId': 2,
      'name': 'User2',
      'certificateName': 'User2',
      'email': 'user2@eurofarma.com',
      'bio': 'Eu sou o User2.',
      'birthDate': '05-15-1995',
      'occupation': 'Químico',
      'company': 'Eurofarma',
      'position': 'Gerente Laboratório de Químico',
      'linkedin': 'https://www.linkedin.com/in/user2',
      'twitter': 'https://twitter.com/user2',
      'github': 'https://github.com/user2',
      'customLink': '',
      'course': 'Química',
      'institution': 'Universidade DEF',
      'educationType': 'Bacharelado',
      'isCompleted': 1,
      'interests': 'Informática, Química, Biologia, Trabalho em Equipe',
      'personalityType': 'ENTP',
    });

    // Insert initial courses with new topicId references
    await db.insert('courses', {
      'courseId': 1,
      'title': 'Flutter',
      'description': 'Aprenda Flutter do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_flutter.jpg',
      'instructors': 'Professor Carlos A., Professor José F.',
      'duration': '80h',
      'topicId': 1, // Programação
    });

    await db.insert('courses', {
      'courseId': 2,
      'title': 'Java',
      'description': 'Aprenda Java do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_java.jpg',
      'instructors': 'Professor Carlos A., Professor Pedro M.',
      'duration': '80h',
      'topicId': 1, // Programação
    });

    await db.insert('courses', {
      'courseId': 3,
      'title': 'React',
      'description': 'Aprenda React do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_react.jpg',
      'instructors': 'Professor Felipe P., Professora Helena M.',
      'duration': '35h',
      'topicId': 2, // Front-end
    });

    await db.insert('courses', {
      'courseId': 4,
      'title': 'Angular',
      'description': 'Aprenda Angular do zero ao avançado.',
      'imageUrl': 'assets/images/capa_curso_angular.jpg',
      'instructors': 'Professor Mateus C., Professor Lucas S.',
      'duration': '50h',
      'topicId': 2, // Front-end
    });

    await db.insert('courses', {
      'courseId': 5,
      'title': 'Como ser líder',
      'description':
          'Aprenda do zero como desenvolver suas habilidades de liderança.',
      'imageUrl': 'assets/images/capa_curso_lideranca.jpg',
      'instructors': 'Professor Eduardo F.',
      'duration': '50h',
      'topicId': 3, // Desenvolvimento Pessoal
    });

    await db.insert('courses', {
      'courseId': 6,
      'title': 'Marketing para novatos',
      'description': 'Aprenda do zero conceitos sobre Marketing.',
      'imageUrl': 'assets/images/capa_curso_marketing.jpg',
      'instructors': 'Professora Renata R.',
      'duration': '30h',
      'topicId': 4, // Marketing
    });

    await db.insert('courses', {
      'courseId': 7,
      'title': 'Como trabalhar em equipe',
      'description': 'Aprenda como trabalhar em uma corporação.',
      'imageUrl': 'assets/images/capa_curso_trabalho_em_equipe.jpg',
      'instructors': 'Professor Thomas T.',
      'duration': '30h',
      'topicId': 3, // Desenvolvimento Pessoal
    });

    await db.insert('courses', {
      'courseId': 8,
      'title': 'Como ser produtivo',
      'description': 'Aprenda como ser mais produtivo no dia a dia.',
      'imageUrl': 'assets/images/capa_curso_produtividade.jpg',
      'instructors': 'Professora Jaqueline L.',
      'duration': '20h',
      'topicId': 3, // Desenvolvimento Pessoal
    });

    // Insert initial lessons
    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Introdução ao Flutter',
      'description': 'Aprenda o básico de Flutter.',
      'videoUrl': 'https://youtu.be/XeUiJJN0vsE?si=nho-ovlNx1VyfuhS',
    });

    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Widgets em Flutter',
      'description': 'Aprenda sobre Widgets em Flutter.',
      'videoUrl': 'https://youtu.be/dGOOR0Ujfls?si=0wE3VCA7KlncSNm1',
    });

    await db.insert('lessons', {
      'courseId': 1,
      'title': 'Gerenciamento de Estado',
      'description': 'Entenda como gerenciar o estado em Flutter.',
      'videoUrl': 'https://youtu.be/4CCW_cdVBQg?si=NIavHbl4eUl_wYbq',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Introdução ao Java',
      'description': 'Saiba mais sobre a linguagem Java e suas vantagens.',
      'videoUrl': 'https://youtu.be/sTX0UEplF54?si=DXGij5vGBKnTFq1s',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Estruturas de Controle',
      'description': 'Aprenda sobre estruturas de controle em Java.',
      'videoUrl': 'https://youtu.be/wW3eve4vTMc?si=qMLpS3XJzWOl1ZQ6',
    });

    await db.insert('lessons', {
      'courseId': 2,
      'title': 'Orientação a Objetos',
      'description': 'Entenda os conceitos de orientação a objetos em Java.',
      'videoUrl': 'https://youtu.be/aR7CKNFECx0?si=M7PQBBSAVBCyexH7',
    });

    await db.insert('lessons', {
      'courseId': 3,
      'title': 'Introdução ao React',
      'description': 'Saiba mais sobre a biblioteca React e suas vantagens.',
      'videoUrl': 'https://youtu.be/FXqX7oof0I4?si=WRy-1xeTfrW2vUya',
    });

    await db.insert('lessons', {
      'courseId': 3,
      'title': 'Componentes em React',
      'description': 'Aprenda sobre componentes em React.',
      'videoUrl': 'https://youtu.be/-wrsG0IGc-M?si=8pztqgo-XEFKXOcv',
    });

    await db.insert('lessons', {
      'courseId': 3,
      'title': 'CSS no React',
      'description': 'Entenda como gerenciar o estado em React.',
      'videoUrl': 'https://youtu.be/20hlPRPVMoU?si=QzYJtEiAs2xuWaDI',
    });

    // Curso de Angular (courseId: 4)
    await db.insert('lessons', {
      'courseId': 4,
      'title': 'Introdução ao Angular',
      'description': 'Saiba mais sobre o framework Angular e suas vantagens.',
      'videoUrl': 'https://youtu.be/vJt_K1bFUeA?si=fJBTJfTsvNjj5flP',
    });

    await db.insert('lessons', {
      'courseId': 4,
      'title': 'Componentes em Angular',
      'description': 'Aprenda sobre componentes em Angular.',
      'videoUrl': 'https://youtu.be/qyS4XK_nACo?si=Amc09a0qbOvYARV-',
    });

    await db.insert('lessons', {
      'courseId': 4,
      'title': 'Serviços e Injeção de Dependência',
      'description':
          'Entenda como utilizar serviços e injeção de dependência em Angular.',
      'videoUrl': 'https://youtu.be/eRXTY5m-9c8?si=CARlvCm_bhM1itnC',
    });

    // Curso de Como ser líder (courseId: 5)
    await db.insert('lessons', {
      'courseId': 5,
      'title': 'Introdução à Liderança',
      'description': 'Saiba mais sobre os conceitos de liderança.',
      'videoUrl': 'https://youtu.be/GA9wI2fMnaA?si=dBrU1-ACeW00DHPk',
    });

    await db.insert('lessons', {
      'courseId': 5,
      'title': 'Comunicação Eficaz',
      'description': 'Aprenda como se comunicar de forma eficaz.',
      'videoUrl': 'https://youtu.be/T57Rpe4NRZc?si=UPLhuXr-3viuaH3r',
    });

    await db.insert('lessons', {
      'courseId': 5,
      'title': 'Tomada de Decisão',
      'description': 'Entenda como tomar decisões assertivas.',
      'videoUrl': 'https://youtu.be/i1QX27OcC6M?si=OAGs3VbXTmJ0L0K_',
    });

    // Curso de Marketing para novatos (courseId: 6)
    await db.insert('lessons', {
      'courseId': 6,
      'title': 'Introdução ao Marketing',
      'description': 'Saiba mais sobre os conceitos básicos de marketing.',
      'videoUrl': 'https://youtu.be/xUmHPiJg4pA?si=HwlkRLuGqjZH0Azk',
    });

    await db.insert('lessons', {
      'courseId': 6,
      'title': 'Estratégias de Marketing',
      'description': 'Aprenda sobre as principais estratégias de marketing.',
      'videoUrl': 'https://youtu.be/ywaFjp1nlXc?si=qprQ6y090iqz6esX',
    });

    await db.insert('lessons', {
      'courseId': 6,
      'title': 'Marketing Digital',
      'description': 'Entenda como utilizar o marketing digital.',
      'videoUrl': 'https://youtu.be/D2VkZAJXrLU?si=Xu6ZQWLzb-WZi7EQ',
    });

    // Curso de Como trabalhar em equipe (courseId: 7)
    await db.insert('lessons', {
      'courseId': 7,
      'title': 'Introdução ao Trabalho em Equipe',
      'description': 'Saiba mais sobre a importância do trabalho em equipe.',
      'videoUrl': 'https://youtu.be/RDIEK5ODQa8?si=ZdRZ1SjN_dJWI_Ab',
    });

    await db.insert('lessons', {
      'courseId': 7,
      'title': 'Comunicação no Trabalho',
      'description': 'Aprenda como colaborar de forma eficaz.',
      'videoUrl': 'https://youtu.be/sSQL5BCaCzE?si=PcxdaLbtOjHbcFQY',
    });

    await db.insert('lessons', {
      'courseId': 7,
      'title': 'Resolução de Conflitos',
      'description': 'Entenda como resolver conflitos no ambiente de trabalho.',
      'videoUrl': 'https://youtu.be/CxK5F17Dyd8?si=kikCxvOVIKSRQlgm',
    });

    // Curso de Como ser produtivo (courseId: 8)
    await db.insert('lessons', {
      'courseId': 8,
      'title': 'Produtividade',
      'description': 'Saiba mais sobre como ser mais produtivo.',
      'videoUrl': 'https://youtu.be/OUq41ZBWVu0?si=r9WAGABDGs25ksBk',
    });

    await db.insert('lessons', {
      'courseId': 8,
      'title': 'Gestão do Tempo',
      'description': 'Aprenda a gerir melhor o seu tempo.',
      'videoUrl': 'https://youtu.be/PzUZsoyMXuY?si=B_SIFOVNGydYiFp3',
    });

    await db.insert('lessons', {
      'courseId': 8,
      'title': 'Ferramentas de Produtividade',
      'description':
          'Conheça as principais ferramentas para aumentar sua produtividade.',
      'videoUrl': 'https://youtu.be/s6_qVly-qIE?si=MlOVxCxpxE_Vsq9c',
    });

    // Insert initial user courses
    await db.insert('user_courses', {
      'userId': 1,
      'courseId': 1,
      'progress': 0.7,
      'status': 'ongoing',
    });

    await db.insert('user_courses', {
      'userId': 1,
      'courseId': 2,
      'progress': 0.5,
      'status': 'favorite',
    });

    await db.insert('user_courses', {
      'userId': 1,
      'courseId': 3,
      'progress': 0.3,
      'status': 'favorite',
    });

    await db.insert('user_courses', {
      'userId': 1,
      'courseId': 4,
      'progress': 1.0,
      'status': 'finalized',
    });

    await db.insert('user_courses', {
      'userId': 1,
      'courseId': 5,
      'progress': 1.0,
      'status': 'finalized',
    });

    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 6,
      'progress': 0.3,
      'status': 'ongoing',
    });
    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 7,
      'progress': 1.0,
      'status': 'finalized',
    });

    await db.insert('user_courses', {
      'userId': 2,
      'courseId': 8,
      'progress': 0.8,
      'status': 'ongoing',
    });
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        CREATE TABLE topics(
          topicId INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
      ''');

      await db.execute('''
        ALTER TABLE courses
        ADD COLUMN topicId INTEGER REFERENCES topics(topicId)
      ''');

      // Insert initial topics
      await db.insert('topics', {'name': 'Programação'});
      await db.insert('topics', {'name': 'Front-end'});
      await db.insert('topics', {'name': 'Desenvolvimento Pessoal'});
      await db.insert('topics', {'name': 'Marketing'});

      // Update existing courses to link with new topics
      await db.update('courses', {'topicId': 1},
          where: 'courseId = ?', whereArgs: [1]);
      await db.update('courses', {'topicId': 1},
          where: 'courseId = ?', whereArgs: [2]);
      await db.update('courses', {'topicId': 2},
          where: 'courseId = ?', whereArgs: [3]);
      await db.update('courses', {'topicId': 2},
          where: 'courseId = ?', whereArgs: [4]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [5]);
      await db.update('courses', {'topicId': 4},
          where: 'courseId = ?', whereArgs: [6]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [7]);
      await db.update('courses', {'topicId': 3},
          where: 'courseId = ?', whereArgs: [8]);
    }
  }

  Future<void> deleteDatabase() async {
    String path = join(await getDatabasesPath(), 'pharmaconnect.db');
    await databaseFactory.deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> searchCourses(String query) async {
    final db = await database;
    return await db.query(
      'courses',
      columns: ['courseId', 'title', 'description'],
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
  }

  Future<void> updateTestCompletion(int userId, bool hasCompletedTest) async {
    final db = await database;
    await db.update(
      'profiles',
      {'hasCompletedTest': hasCompletedTest ? 1 : 0},
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<bool> checkTestCompletion(int userId) async {
    final db = await database;
    final result = await db.query(
      'profiles',
      columns: ['hasCompletedTest'],
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first['hasCompletedTest'] == 1;
    }
    return false;
  }

  Future<List<Map<String, dynamic>>> getUserCoursesByStatus(
      int userId, String status) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT c.courseId, c.title, c.description, uc.progress
      FROM courses c
      JOIN user_courses uc ON c.courseId = uc.courseId
      WHERE uc.userId = ? AND uc.status = ?
    ''', [userId, status]);
  }

  Future<int> registerUser(String email, String password) async {
    final db = await database;
    return await db.insert('users', {'email': email, 'password': password});
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await database;
    final result = await db.query('users',
        where: 'email = ? AND password = ?', whereArgs: [email, password]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> saveProfile(Map<String, dynamic> profile) async {
    final db = await database;
    await db.update(
      'profiles',
      profile,
      where: 'userId = ?',
      whereArgs: [profile['userId']],
    );
  }

  Future<List<Map<String, dynamic>>> getUserCourses(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_courses',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return maps;
  }

  Future<void> updateProfile(
      int userId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'profiles',
      updatedFields,
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }

  Future<Map<String, dynamic>?> getProfile(int userId) async {
    final db = await database;
    final result =
        await db.query('profiles', where: 'userId = ?', whereArgs: [userId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> addCourse(Map<String, dynamic> course) async {
    final db = await database;
    return await db.insert('courses', course);
  }

  Future<void> addLesson(Map<String, dynamic> lesson) async {
    final db = await database;
    await db.insert('lessons', lesson);
  }

  Future<Map<String, dynamic>?> getCourseById(int courseId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'courses',
      where: 'courseId = ?',
      whereArgs: [courseId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCourse(int courseId) async {
    final db = await database;
    final result =
        await db.query('courses', where: 'courseId = ?', whereArgs: [courseId]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> getLessons(int courseId) async {
    final db = await database;
    return await db
        .query('lessons', where: 'courseId = ?', whereArgs: [courseId]);
  }

  Future<int> insertUser(String email, String password) async {
    final db = await database;
    final userId =
        await db.insert('users', {'email': email, 'password': password});

    // Criar perfil padrão para o novo usuário
    await db.insert('profiles', {
      'userId': userId,
      'name': 'Nome Padrão',
      'certificateName': 'Nome no Certificado',
      'email': email,
      'bio': 'Bio Padrão',
      'birthDate': '01-01-2000',
      'occupation': 'Ocupação Padrão',
      'company': 'Empresa Padrão',
      'position': 'Posição Padrão',
      'linkedin': 'https://linkedin.com/in/padrao',
      'twitter': 'https://twitter.com/padrao',
      'github': 'https://github.com/padrao',
      'customLink': '',
      'course': 'Curso Padrão',
      'institution': 'Instituição Padrão',
      'educationType': 'Tipo de Educação Padrão',
      'isCompleted': 0,
      'interests': 'Interesses Padrão',
      'personalityType': 'Tipo Padrão',
      'hasCompletedTest': 0,
    });

    return userId;
  }

  // Método para atualizar informações do usuário
  Future<bool> updateUser(String email, Map<String, dynamic> values) async {
    final db = await database;
    final result = await db.update(
      'users',
      values,
      where: 'email = ?',
      whereArgs: [email],
    );

    return result > 0;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<void> insertCourse(Map<String, dynamic> course) async {
    final db = await database;
    await db.insert('courses', course);
  }

  Future<void> updateCourse(
      int courseId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'courses',
      updatedFields,
      where: 'courseId = ?',
      whereArgs: [courseId],
    );
  }

  Future<void> insertLesson(Map<String, dynamic> lesson) async {
    final db = await database;
    await db.insert('lessons', lesson);
  }

  Future<void> updateLesson(
      int lessonId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'lessons',
      updatedFields,
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );
  }

  Future<void> insertTopic(Map<String, dynamic> topic) async {
    final db = await database;
    await db.insert('topics', topic);
  }

  Future<void> updateTopic(
      int topicId, Map<String, dynamic> updatedFields) async {
    final db = await database;
    await db.update(
      'topics',
      updatedFields,
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
  }

  Future<List<Map<String, dynamic>>> getTopics() async {
    final db = await database;
    return await db.query('topics');
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<List<Map<String, dynamic>>> getCourses() async {
    final db = await database;
    return await db.query('courses');
  }

  Future<bool> topicExists(int topicId) async {
    final db = await database;
    final result =
        await db.query('topics', where: 'topicId = ?', whereArgs: [topicId]);
    return result.isNotEmpty;
  }

  Future<Map<String, dynamic>?> getLessonById(int lessonId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'lessons',
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTopicById(int topicId) async {
    final db = await database;
    final result = await db.query(
      'topics',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<bool> topicExist(int topicId) async {
    final db = await database;
    final result = await db.query(
      'topics',
      where: 'topicId = ?',
      whereArgs: [topicId],
    );
    return result.isNotEmpty;
  }

  Future<bool> lessonExists(int lessonId) async {
    final db = await database;
    final result = await db.query(
      'lessons',
      where: 'lessonsId = ?',
      whereArgs: [lessonId],
    );
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getLessonsSuport() async {
    final db = await database;
    return await db.query('lessons');
  }

  //Metodos para calculo de progresso dos cursos
   Future<List<Map<String, dynamic>>> getLessonsByCourse(int courseId) async {
    final db = await database;
    return db.query('lessons', where: 'courseId = ?', whereArgs: [courseId]);
  }

//   Future<void> updateUserCourseProgress(int userId, int courseId, double progress) async {
//   final db = await database;
//   await db.update(
//     'user_courses',
//     {
//       'progress': progress,
//       'status': progress >= 1.0 ? 'finalized' : 'ongoing'
//     },
//     where: 'userId = ? AND courseId = ?',
//     whereArgs: [userId, courseId],
//   );
// }

  Future<double> getUserCourseProgress(int userId, int courseId) async {
    final db = await database;
    var result = await db.query(
      'user_courses',
      columns: ['progress'],
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );

    if (result.isNotEmpty && result.first['progress'] != null) {
      return result.first['progress'] as double;
    } else {
      return 0.0;
    }
  }

  // Future<void> markLessonAsSeen(int userId, int courseId, int lessonId) async {
  //   final db = await database;

  //   // Get total number of lessons for the course
  //   var totalLessonsResult = await db.rawQuery(
  //       'SELECT COUNT(*) AS count FROM lessons WHERE courseId = ?', [courseId]);
  //   int totalLessons = Sqflite.firstIntValue(totalLessonsResult) ?? 1;

  //   // Get number of seen lessons
  //   var seenLessonsResult = await db.rawQuery(
  //       'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
  //       [userId, courseId]);
  //   int seenLessons = Sqflite.firstIntValue(seenLessonsResult) ?? 0;

  //   // Check if lesson is already seen
  //   var lessonSeenResult = await db.query('user_lessons',
  //       where: 'userId = ? AND courseId = ? AND lessonId = ?',
  //       whereArgs: [userId, courseId, lessonId]);
  //   if (lessonSeenResult.isEmpty) {
  //     // Insert new record in user_lessons
  //     await db.insert('user_lessons',
  //         {'userId': userId, 'courseId': courseId, 'lessonId': lessonId});
  //     seenLessons++;
  //   }

  //   // Calculate new progress
  //   double progress = seenLessons / totalLessons;

  //   // Update user_courses with new progress
  //   await db.update(
  //       'user_courses',
  //       {
  //         'progress': progress,
  //         'status': progress == 1.0 ? 'finalized' : 'ongoing'
  //       },
  //       where: 'userId = ? AND courseId = ?',
  //       whereArgs: [userId, courseId]);
  // }

// Future<bool> areAllLessonsSeen(int userId, int courseId) async {
//     final db = await database;

//     // Get total number of lessons for the course
//     var totalLessonsResult = await db.rawQuery(
//         'SELECT COUNT(*) AS count FROM lessons WHERE courseId = ?', [courseId]);
//     int totalLessons = Sqflite.firstIntValue(totalLessonsResult) ?? 0;

//     // Get number of seen lessons
//     var seenLessonsResult = await db.rawQuery(
//         'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
//         [userId, courseId]);
//     int seenLessons = Sqflite.firstIntValue(seenLessonsResult) ?? 0;

//     return totalLessons > 0 && totalLessons == seenLessons;
//   }



Future<void> updateUserCourseProgress(
      int userId, int courseId, double progress) async {
    final db = await database;
    await db.update(
      'user_courses',
      {'progress': progress},
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );
  }




// Future<void> updateUserCourseProgress(
//       int userId, int courseId, double progress) async {
//     final db = await database;
//     await db.update(
//       'user_courses',
//       {
//         'progress': progress,
//         'status': progress >= 1.0 ? 'finalized' : 'ongoing'
//       },
//       where: 'userId = ? AND courseId = ?',
//       whereArgs: [userId, courseId],
//     );
//   }

  Future<void> markLessonAsSeen(int userId, int courseId, int lessonId) async {
    final db = await database;
    await db.insert(
        'user_lessons',
        {
          'userId': userId,
          'courseId': courseId,
          'lessonId': lessonId,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<int> getSeenLessonsCount(int userId, int courseId) async {
    final db = await database;
    var result = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
        [userId, courseId]);
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<bool> areAllLessonsSeen(int userId, int courseId) async {
    final db = await database;
    var totalLessonsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM lessons WHERE courseId = ?', [courseId]);
    int totalLessons = Sqflite.firstIntValue(totalLessonsResult) ?? 0;
    var seenLessonsResult = await db.rawQuery(
        'SELECT COUNT(*) AS count FROM user_lessons WHERE userId = ? AND courseId = ?',
        [userId, courseId]);
    int seenLessons = Sqflite.firstIntValue(seenLessonsResult) ?? 0;
    return totalLessons > 0 && totalLessons == seenLessons;
  }











  Future<void> insertUserCourse(
      int userId, int courseId, double progress, String status) async {
    final db = await database;
    await db.insert(
      'user_courses',
      {
        'userId': userId,
        'courseId': courseId,
        'progress': progress,
        'status': status
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUserCourseStatus(
      int userId, int courseId, String status) async {
    final db = await database;
    await db.update(
      'user_courses',
      {'status': status},
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );
  }

  Future<String?> getCourseStatus(int userId, int courseId) async {
    final db = await database;
    final result = await db.query(
      'user_courses',
      columns: ['status'],
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );

    if (result.isNotEmpty) {
      return result.first['status'] as String?;
    } else {
      return null;
    }
  }

  Future<void> deleteCourse(int userId, int courseId) async {
    final db = await database;
    await db.delete(
      'user_courses',
      where: 'userId = ? AND courseId = ?',
      whereArgs: [userId, courseId],
    );
  }

  Future<List<Map<String, dynamic>>> getOngoingCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description, user_courses.progress
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'ongoing']);
  }

  Future<List<Map<String, dynamic>>> getFinalizedCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'finalized']);
  }

  Future<List<Map<String, dynamic>>> getFavoriteCourses(int userId) async {
    final db = await database;
    return await db.rawQuery('''
      SELECT courses.courseId, courses.title, courses.description
      FROM courses
      INNER JOIN user_courses ON courses.courseId = user_courses.courseId
      WHERE user_courses.userId = ? AND user_courses.status = ?
    ''', [userId, 'favorite']);
  }










}
