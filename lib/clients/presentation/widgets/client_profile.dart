import 'package:flutter/material.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';

class ClientProfile extends StatelessWidget {
  const ClientProfile({
    required this.data,
    super.key,
  });

  final Client data;

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          // no image
          if (data.photo == "")
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/no-profile-img.png',
                height: 150,
                width: 150,
              ),
            ),

          if (data.photo != "")
            Image.network(
              data.photo!,
              height: 150,
              width: 150,
            ),

          const SizedBox(height: 20),

          Column(
            children: [
              // first name
              if (data.firstname != "")
                Text(
                  data.firstname!,
                  style: textStyles.displaySmall,
                ),
              // last name
              if (data.lastname != "")
                Text(
                  data.lastname!,
                  style: textStyles.displaySmall,
                ),

              // has no any name
              if (data.lastname == "" && data.firstname == "")
                Text(
                  'User',
                  style: textStyles.displaySmall,
                ),

              const Divider(height: 20),

              // caption
              if (data.caption != "")
                Text(
                  data.caption!,
                  style: textStyles.bodyLarge,
                ),
              // address
              if (data.address != "")
                Text(
                  data.address!,
                  style: textStyles.bodyLarge,
                ),
              // email
              if (data.email != "")
                Text(
                  data.email!,
                  style: textStyles.bodyLarge,
                ),
              // id
              Text(
                'Client id: ${data.id}',
                style: textStyles.bodyLarge,
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
