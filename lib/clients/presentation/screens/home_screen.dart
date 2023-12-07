import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_flutter_test/clients/presentation/providers/clients_provider.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';
import 'package:tots_flutter_test/clients/presentation/widgets/client_item.dart';
import 'package:tots_flutter_test/clients/presentation/widgets/find_bar.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    final textStyles = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height * 0.35;
    final clientsProv = ref.watch(getClientsProvider);
    final page = ref.read(pageNumberProvider.notifier);

    return BaseScreen(
      appBar: AppBar(
        title: SizedBox(
          height: 60,
          child: Image.asset('assets/minimal_logo.png'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            // find bar & add new btn
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: FindBar(),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => context.pushNamed(AppRoutes.createUpdateScreen),
                  child: const Text('ADD NEW'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // title
            Text(
              'CLIENTS',
              style: textStyles.titleLarge,
            ),
            const Divider(height: 20),

            // clients list
            clientsProv.when(
              error: (error, stackTrace) => Text('error $error'),
              loading: () => SizedBox(
                height: height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              data: (data) {
                return data == null
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('Ooops !'),
                        ),
                      )
                    : data.data.isEmpty
                        ? SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                'No clients',
                                style: textStyles.titleMedium,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              // title
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${data.total} clients',
                                    style: textStyles.bodyMedium,
                                  ),
                                  Text(
                                    'Page ${data.currentPage} of ${data.lastPage}',
                                    style: textStyles.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // TODO build pagination
                              // pagination
                              // ListView(
                              //   shrinkWrap: true,
                              //   physics: const BouncingScrollPhysics(),
                              //   scrollDirection: Axis.horizontal,
                              //   children: data.links.map((e) => Text(e.label)).toList(),
                              // ),

                              // clients list
                              ListView.separated(
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                physics: const BouncingScrollPhysics(),
                                itemCount: data.data.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return ClientItem(
                                    client: data.data[index],
                                    ref: ref,
                                    key: UniqueKey(),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),

                              // load more btn
                              Row(
                                children: [
                                  // previous
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: page.state == 1 ? null : () => page.update((state) => state - 1),
                                        child: Text(
                                          '<<  PREVIOUS PAGE',
                                          style: textStyles.bodySmall!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  // next
                                  Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ref.read(pageNumberProvider.notifier).update((state) => state + 1);
                                        },
                                        child: Text(
                                          'NEXT PAGE  >>',
                                          style: textStyles.bodySmall!.copyWith(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
              },
            ),
          ],
        ),
      ),
    );
  }
}
