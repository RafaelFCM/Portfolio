import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/screens/login_screen/login_screen.dart';
import 'package:pharmaconnect_project/services/db_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageUsersScreen extends StatefulWidget {
  @override
  _ManageUsersScreenState createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final DBService _dbService = DBService();

  Future<void> _insertUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.endsWith('@eurofarma.com')) {
      final existingUser =
          await _dbService.getUserByEmail(_emailController.text);
      if (existingUser == null) {
        await _dbService.insertUser(
            _emailController.text, _passwordController.text);
        _clearFields();
        _showAlert('Usuário criado com sucesso!');
      } else {
        _showAlert('Email já existe!');
      }
      setState(() {});
    } else {
      _showAlert(
          'Por favor, insira um email válido que termine com "@eurofarma.com" e uma senha.');
    }
  }

  Future<void> _updateUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _emailController.text.endsWith('@eurofarma.com')) {
      final existingUser =
          await _dbService.getUserByEmail(_emailController.text);
      if (existingUser != null) {
        if (_emailController.text == 'suporte@eurofarma.com') {
          if (_currentPasswordController.text == existingUser['password']) {
            if (_passwordController.text != existingUser['password']) {
              await _dbService.updateUser(_emailController.text,
                  {'password': _passwordController.text});
              _clearFields();
              _showAlert('Senha do suporte atualizada com sucesso!');
              await _logout();
            } else {
              _showAlert('A nova senha não pode ser igual à senha atual.');
            }
          } else {
            _showAlert('Senha atual incorreta.');
          }
        } else {
          await _dbService.updateUser(
              _emailController.text, {'password': _passwordController.text});
          _clearFields();
          _showAlert('Usuário atualizado com sucesso!');
        }
      } else {
        _showAlert('Email não encontrado!');
      }
      setState(() {});
    } else {
      _showAlert(
          'Por favor, insira um email válido que termine com "@eurofarma.com" e uma senha.');
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', false);
    await prefs.remove('userId');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchUsers() async {
    return await _dbService.getUsers();
  }

  void _clearFields() {
    _emailController.clear();
    _passwordController.clear();
    _currentPasswordController.clear();
  }

  void _showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Usuários'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
              ),
              if (_emailController.text == 'suporte@eurofarma.com')
                TextField(
                  controller: _currentPasswordController,
                  decoration: InputDecoration(
                      labelText:
                          'Senha Atual (Necessário apenas se for atualizar senha do suporte)'),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _insertUser,
                child: Text('Criar Usuário'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                ),
              ),
              ElevatedButton(
                onPressed: _updateUser,
                child: Text('Atualizar Usuário'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey[300],
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchUsers(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final users = snapshot.data!;
                  return Container(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          title: Text(user['email']),
                          subtitle: Text('ID: ${user['userId']}'),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
