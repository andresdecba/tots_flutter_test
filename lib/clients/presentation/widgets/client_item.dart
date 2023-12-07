import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/presentation/providers/delete_client_provider.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

class ClientItem extends StatelessWidget {
  const ClientItem({required this.client, required this.ref, super.key});

  final Client client;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    const String edit = 'Editar';
    const String delete = 'Borrar';

    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
      leading: const CircleAvatar(
        backgroundColor: Colors.amber,
        backgroundImage: AssetImage('assets/no-profile-img.png'), // Image.asset('assets/no-profile-img.png'),
      ),
      title: Text(
        '${client.firstname} ${client.lastname}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      subtitle: Text(
        '${client.id} - ${client.email}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      titleTextStyle: textStyles.titleMedium,
      subtitleTextStyle: textStyles.bodySmall,

      onTap: () {
        context.pushNamed(
          AppRoutes.getClientScreen,
          extra: {"clientId": client.id},
        );
      },

      // menu
      trailing: PopupMenuButton(
        color: Colors.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        position: PopupMenuPosition.under,

        // items
        itemBuilder: (context) => [
          PopupMenuItem(
            value: edit,
            onTap: () {},
            child: const Text(
              edit,
              style: TextStyle(color: Colors.white),
            ),
          ),
          PopupMenuItem(
            value: delete,
            onTap: () {},
            child: const Text(
              delete,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],

        // navigate
        onSelected: (value) {
          // edit
          if (value == 'Editar') {
            context.pushNamed(
              AppRoutes.createUpdateScreen,
              extra: {"client": client},
            );
          }
          // delete
          if (value == 'Borrar') {
            ref.read(deleteClientProvider(client.id!));
          }
        },
      ),
    );
  }
}
