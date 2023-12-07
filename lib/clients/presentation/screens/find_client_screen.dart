import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';
import 'package:tots_flutter_test/clients/presentation/widgets/client_profile.dart';

class FindClientScreen extends ConsumerWidget {
  const FindClientScreen({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScreen(
        // appbar
        appBar: AppBar(
          title: SizedBox(
            height: 60,
            child: Image.asset('assets/minimal_logo.png'),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),

        // body
        body: ClientProfile(data: client));
  }
}
