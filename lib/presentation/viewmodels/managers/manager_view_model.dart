import 'package:flutter/material.dart';

import '../../../core/utils/command.dart';
import '../../../core/utils/result.dart';
import '../../../domain/entities/Manager.dart';
import '../../../domain/usecases/managers/add_manager_usecase.dart';
import '../../../domain/usecases/managers/clear_managers_usecase.dart';
import '../../../domain/usecases/managers/managers_usecase.dart';
import '../../../domain/usecases/managers/remove_manager_usecase.dart';


class ManagerViewModel extends ChangeNotifier {
  ManagerViewModel({
    required ManagersUseCase managersUseCase,
    required AddManagerUseCase addManagerUseCase,
    required RemoveManagerUseCase removeManagerUseCase,
    required ClearManagersUseCase clearManagersUseCase,
    required this.leagueName,
  }) : _managersUseCase = managersUseCase,
        _addManagerUseCase = addManagerUseCase,
        _removeManagerUseCase = removeManagerUseCase,
        _clearManagersUseCase = clearManagersUseCase{
    getManagers = Command0(_getManagers)..execute();
    clearManagers = Command0(_clearManagers);
    removeManager = Command1(_removeManager);
    addManager = Command1(_addManager);

  }

  final ManagersUseCase _managersUseCase;
  final AddManagerUseCase _addManagerUseCase;
  final RemoveManagerUseCase _removeManagerUseCase;
  final ClearManagersUseCase _clearManagersUseCase;

  late String leagueName;
  late final Command0 getManagers;
  late Command0 clearManagers;
  late Command1<void, String> removeManager;
  late Command1<void, String> addManager;

  List<Manager> _managers = [];

  List<Manager> get managers => _managers;

  Future<Result<List<Manager>>> _getManagers() async {
    try {
      print("Caricamento partecipanti...");
      final result = await _managersUseCase.getManagers(leagueName);
      switch (result) {
        case Ok<List<Manager>>():
          _managers = result.value;
          print("partecipanti caricati: ${_managers.length}");
          break;
        case Error<List<Manager>>():
          print("Errore nel caricamento dei partecipanti: $result");
          return Result.error(result.error);
      }
      return Result.ok(result.value);
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _clearManagers() async {
    try {
      print("Eliminando tutte le leghe...");
      final result = await _clearManagersUseCase.clearManagers(leagueName);
      switch (result) {
        case Ok<void>():
          print("Leghe eliminate");
          break;
        case Error<void>():
          print("Errore nel caricamento delle leghe: $result");
          return Result.error(result.error);
      }
      return _getManagers();
    } finally {
      notifyListeners();
    }
  }

  Future<Result<void>> _removeManager(String managerName) async {
    try {
      final resultRemove = await _removeManagerUseCase.removeManager(leagueName, managerName);
      switch (resultRemove) {
        case Ok<void>():
          print("Lega rimossa con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultRemove");
          return Result.error(resultRemove.error);
      }

      print("Ricaricamento leghe dopo remove...");

      return _getManagers();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<Result<void>> _addManager(String managerName) async {
    try {
      print("Aggiungendo partecipante: $managerName alla lega: $leagueName");
      final resultAdd = await _addManagerUseCase.addManager(leagueName, managerName);
      switch (resultAdd) {
        case Ok<void>():
          print("Lega aggiunta con successo");
          break;
        case Error<void>():
          print("Errore nell'aggiunta della lega: $resultAdd");
          return Result.error(resultAdd.error);
      }

      print("Ricaricamento leghe dopo aggiunta...");
      return _getManagers();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}