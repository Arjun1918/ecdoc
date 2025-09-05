import 'package:flutter/material.dart';

class ConsultationProvider extends ChangeNotifier {
  String _selectedTemplate = 'Fever 1';
  bool _withHeader = true;
  String _activeHeaderButton = 'Growth Chart';
  bool _isBirthTo12Selected = true;

  final List<Map<String, String>> _patients = [
    {
      'name': 'Sarah Johnson',
      'image': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      'selected': 'true',
    },
    {
      'name': 'Michael Brown',
      'image': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      'selected': 'false',
    },
    {
      'name': 'Emily Davis',
      'image': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      'selected': 'false',
    },
    {
      'name': 'Robert Wilson',
      'image': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      'selected': 'false',
    },
    {
      'name': 'Jennifer Martinez',
      'image': 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg',
      'selected': 'false',
    },
  ];
  String get selectedTemplate => _selectedTemplate;
  bool get withHeader => _withHeader;
  String get activeHeaderButton => _activeHeaderButton;
  bool get isBirthTo12Selected => _isBirthTo12Selected;
  List<Map<String, String>> get patients => _patients;
  void setSelectedTemplate(String template) {
    _selectedTemplate = template;
    notifyListeners();
  }

  void setWithHeader(bool value) {
    _withHeader = value;
    notifyListeners();
  }

  void setActiveHeaderButton(String button) {
    _activeHeaderButton = button;
    notifyListeners();
  }

  void setIsBirthTo12Selected(bool value) {
    _isBirthTo12Selected = value;
    notifyListeners();
  }

  void selectPatient(int index) {
    for (int i = 0; i < _patients.length; i++) {
      _patients[i]['selected'] = (i == index) ? 'true' : 'false';
    }
    notifyListeners();
  }
}