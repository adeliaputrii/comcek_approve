// enum Environment { dev, prod }

// abstract class AppEnvironment {
//   static late String baseApiUrl;
//   static late String title;
//   static late Environment _environment;
//   static Environment get environment => _environment;
//   static setupEnv(Environment env) {
//     _environment = env;
//     switch (env) {
      
//       case Environment.dev:
//         // TODO: Handle this case.
//         baseApiUrl = 'https://dev-android-api.ramayana.co.id:8305/';
//         title = 'rals-dev';
//         break;
//       case Environment.prod:
//         // TODO: Handle this case.
//         baseApiUrl = 'https://android-api.ramayana.co.id:8304/';
//         title = 'rals-tools';
//         break;
//     }
//   }
// }