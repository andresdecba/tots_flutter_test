import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/presentation/providers/client_provider.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';
import 'package:tots_flutter_test/clients/presentation/widgets/client_profile.dart';

class GetClientScreen extends ConsumerWidget {
  const GetClientScreen({
    super.key,
    required this.clientId,
  });

  final int clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = MediaQuery.of(context).size.height * 0.35;
    final clientData = ref.watch(getClientProvider(clientId));

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

        body: clientData.when(
          error: (error, stackTrace) => Text('error ${error}'),
          loading: () => SizedBox(
            height: height,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
          data: (data) {
            return data != null ? ClientProfile(data: data) : const Center(child: Text('esto es null'));
          },
        ));
  }
}
