import 'package:flutter/material.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  final String text =
      'Desarrollador:\nAndrés Pugliese\n\nTiempo de desarrollo:\n20hs aproximadamente (3 días)\n\nE-mail:\nandresdecba@gmail.com\n\nMi Linked in:\nlinkedin.com/in/andres-pugliese\n\nMi github:\ngithub.com/andresdecba\n\nMi playstore:\nplay.google.com/store/apps/details?id=site.thisweek\n';

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return BaseScreen(
        appBar: AppBar(
          title: SizedBox(
            height: 60,
            child: Image.asset('assets/minimal_logo.png'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Acerca de esta app',
                style: textStyles.titleLarge,
              ),
              const SizedBox(height: 30),
              Text(
                text,
                style: textStyles.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }
}
