import 'package:flutter/material.dart';
import 'package:pharmaconnect_project/services/db_service.dart';

class ManageTopicsScreen extends StatefulWidget {
  @override
  _ManageTopicsScreenState createState() => _ManageTopicsScreenState();
}

class _ManageTopicsScreenState extends State<ManageTopicsScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final DBService _dbService = DBService();

  Future<void> _insertTopic() async {
    if (_nameController.text.isNotEmpty) {
      await _dbService.insertTopic({'name': _nameController.text});
      _clearFields();
      _showAlert('Tópico criado com sucesso!');
      setState(() {});
    } else {
      _showAlert('Por favor, preencha o nome do tópico.');
    }
  }

  Future<void> _updateTopic() async {
    if (_idController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      int topicId = int.parse(_idController.text);
      bool exists = await _dbService.topicExists(topicId);

      if (exists) {
        await _dbService.updateTopic(topicId, {'name': _nameController.text});
        _clearFields();
        _showAlert('Tópico atualizado com sucesso!');
        setState(() {});
      } else {
        _showAlert('ID do tópico não existe.');
        _clearFields();
      }
    } else {
      _showAlert('Por favor, preencha todos os campos.');
    }
  }

  Future<List<Map<String, dynamic>>> _fetchTopics() async {
    return await _dbService.getTopics();
  }

  Future<void> _fetchTopicById(int topicId) async {
    final topic = await _dbService.getTopicById(topicId);

    if (topic != null) {
      _nameController.text = topic['name'];
    } else {
      _showAlert('ID do tópico não existe.');
      _clearFields();
    }
  }

  void _clearFields() {
    _idController.clear();
    _nameController.clear();
  }

  void _showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();
    _idController.addListener(() {
      final int? topicId = int.tryParse(_idController.text);
      if (topicId != null) {
        _fetchTopicById(topicId);
      } else {
        _clearFields();
      }
    });
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Tópicos'),
        backgroundColor: Colors.blueGrey[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID do Tópico'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _insertTopic,
                    child: Text('Criar Tópico'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _updateTopic,
                    child: Text('Atualizar Tópico'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey[300],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchTopics(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final topics = snapshot.data!;
                  return Container(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: topics.length,
                      itemBuilder: (context, index) {
                        final topic = topics[index];
                        return ListTile(
                          title: Text(topic['name']),
                          subtitle: Text('ID: ${topic['topicId']}'),
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
