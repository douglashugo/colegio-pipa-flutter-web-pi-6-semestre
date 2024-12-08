import 'package:f290_ldmp_web_desktop_playground/src/core/theme/theme.dart';
import 'package:flutter/material.dart';

import 'core/theme/util.dart';
import 'features/home/presentation/aviso_register.dart';
import 'features/home/presentation/home_page.dart';
import 'features/home/presentation/list_avisos.dart';
import 'features/home/presentation/list_contents.dart';
import 'features/home/presentation/view_avisos.dart';
import 'features/home/presentation/view_content.dart';
import 'features/home/presentation/content_register.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    // Use with Google Fonts package to use downloadable fonts
    TextTheme textTheme = createTextTheme(context, "Noto Sans", "Righteous");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme(textTheme).light(),
      //  darkTheme:  MaterialTheme(textTheme).dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/novo-conteudo': (context) => RegisterContentPage(),
        '/conteudos': (context) => ContentPageList(),
        '/avisos': (context) => NoticesPage(),
        '/novo-aviso': (context) => RegisterNoticePage(),

        // Navigator.of(context).pushNamed('/novo-conteudo',);
        // Navigator.pop(context); - VOLTAR PARA PAGINA ANTERIOR
        // Navigator.of(context).pop();
        // Navigator.of(context).pushNamed('/schedule', arguments: widget.employee); - VOLTAR PARA PAGINA ANTERIOR COM ARGUMENTOS
        // Navigator.of(context).pushNamedAndRemoveUntil(routeName, (route) => false); -- DIRECIONAMENTO DO LOGIN PARA A HOME
      },
    );
  }
}
