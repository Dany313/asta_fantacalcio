abstract final class Routes {
  static const home = '/';
  static String legaWithName(String name) => '/lega/$name';
  static String astaWithName(String name) => '/asta/$name';
  static const asta = '/asta';
  static String teamWithManager(String leagueName, String managerName) => '/team/$leagueName/$managerName';
  static String teams(String leagueName) => '/teams/$leagueName';
}