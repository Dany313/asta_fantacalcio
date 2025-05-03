import 'package:flutter/material.dart';

import '../../../core/utils/command.dart';
import '../../../domain/entities/manager.dart';
import '../../../domain/usecases/managers/add_manager_usecase.dart';
import '../../../domain/usecases/managers/clear_managers_usecase.dart';
import '../../../domain/usecases/managers/managers_usecase.dart';
import '../../../domain/usecases/managers/remove_manager_usecase.dart';
import '../../../service_locator.dart';


class ManagerViewModel extends ChangeNotifier {
  ManagerViewModel({required this.leagueName}){
    getManagers = Command0(_getManagers)..execute();
    clearManagers = Command0(_clearManagers);
    removeManager = Command1(_removeManager);
    addManager = Command1(_addManager);

  }

  late String leagueName;
  late final Command0 getManagers;
  late Command0 clearManagers;
  late Command1<void, String> removeManager;
  late Command1<void, String> addManager;

  List<Manager> _managers = [];

  List<Manager> get managers => _managers;

  Future<void> _getManagers() async {
    try {
      print("Caricamento partecipanti...");
      final result = await serviceLocator<ManagersUseCase>().call(leagueName);
      result.fold(
              (error) => print(error),
              (managers) => _managers = managers
      );
    } finally {
      notifyListeners();
    }
  }

  Future<void> _clearManagers() async {
    try {
      print("Eliminando tutte le leghe...");
      final result = await serviceLocator<ClearManagersUseCase>().call(leagueName);
      result.fold(
              (error) => print(error),
              (success) => print(success),
      );
      return _getManagers();
    } finally {
      notifyListeners();
    }
  }

  Future<void> _removeManager(String managerName) async {
    try {
      final result = await serviceLocator<RemoveManagerUseCase>().call(leagueName, managerName);
      result.fold(
            (error) => print(error),
            (success) => print(success),
      );
      return _getManagers();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }

  Future<void> _addManager(String managerName) async {
    try {
      print("Aggiungendo partecipante: $managerName alla lega: $leagueName");
      final result = await serviceLocator<AddManagerUseCase>().call(leagueName, managerName);
      result.fold(
            (error) => print(error),
            (success) => print(success),
      );
      return _getManagers();
    } finally {
      print("Notifica ascoltatori");
      notifyListeners();
    }
  }
}