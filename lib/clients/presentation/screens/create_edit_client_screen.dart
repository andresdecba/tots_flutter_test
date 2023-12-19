import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tots_flutter_test/clients/domain/entities/client.dart';
import 'package:tots_flutter_test/clients/presentation/providers/create_edit_client_provider.dart';
import 'package:tots_flutter_test/core/styles/base_screen.dart';
import 'package:tots_flutter_test/clients/presentation/widgets/progress_button.dart';
import 'package:tots_flutter_test/core/styles/styles.dart';

class CreateEditClientScreen extends ConsumerStatefulWidget {
  const CreateEditClientScreen({
    this.client,
    super.key,
  });

  final Client? client;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateUpdateClientScreenState();
}

class _CreateUpdateClientScreenState extends ConsumerState<CreateEditClientScreen> {
  late TextEditingController emailCtrlr;
  late TextEditingController firstNameCtrlr;
  late TextEditingController lastNameCtrlr;
  late TextEditingController addressCtrlr;
  late TextEditingController captionCtrlr;
  late GlobalKey<FormState> formStateKey;

  // flag: is "edit mode" or "create mode"
  bool isNew = true;

  @override
  void initState() {
    super.initState();
    emailCtrlr = TextEditingController();
    firstNameCtrlr = TextEditingController();
    lastNameCtrlr = TextEditingController();
    addressCtrlr = TextEditingController();
    captionCtrlr = TextEditingController();
    formStateKey = GlobalKey<FormState>();

    // if edit mode, fill fields with client info
    if (widget.client != null) {
      emailCtrlr.text = widget.client!.email!;
      firstNameCtrlr.text = widget.client!.firstname!;
      lastNameCtrlr.text = widget.client!.lastname!;
      addressCtrlr.text = widget.client!.address!;
      captionCtrlr.text = widget.client!.caption!;
      isNew = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return BaseScreen(
      // APPBAR
      appBar: AppBar(
        title: SizedBox(
          height: 60,
          child: Image.asset('assets/minimal_logo.png'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        // form
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formStateKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // title
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    isNew ? 'ADD A NEW CLIENT' : 'EDIT CLIENT',
                    style: textStyles.titleLarge,
                  ),
                ),
                const Divider(height: 20),
                const SizedBox(height: 20),

                // image
                Container(
                  height: 150,
                  width: 150,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: InkWell(
                    radius: 200,
                    onTap: () {},
                  ),
                ),
                const SizedBox(height: 20),

                // text fields
                Wrap(
                  children: [
                    // first name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: firstNameCtrlr,
                        keyboardType: TextInputType.name,
                        decoration: AppStyles.inputDecoration(
                          labelText: 'First name*',
                          hintText: 'John',
                          sufixIcon: Icons.clear_rounded,
                          onTap: () => firstNameCtrlr.clear(),
                          context: context,
                        ),
                        validator: (value) {
                          if (value! == "") {
                            return 'Please enter your first name';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    // last name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: lastNameCtrlr,
                        keyboardType: TextInputType.name,
                        decoration: AppStyles.inputDecoration(
                          labelText: 'Last name*',
                          hintText: 'Connor',
                          sufixIcon: Icons.clear_rounded,
                          onTap: () => lastNameCtrlr.clear(),
                          context: context,
                        ),
                        validator: (value) {
                          if (value! == "") {
                            return 'Please enter your lastname';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    // email
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: emailCtrlr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppStyles.inputDecoration(
                          labelText: 'Email*',
                          hintText: 'johnconnor@skynet.net',
                          sufixIcon: Icons.clear_rounded,
                          onTap: () => emailCtrlr.clear(),
                          context: context,
                        ),
                        validator: (value) {
                          if (value! == "") {
                            return 'Please enter an email address';
                          } else if (!_validateEmail(value)) {
                            return 'Please enter a valid email address';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),

                    // address
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: addressCtrlr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppStyles.inputDecoration(
                          labelText: 'Address',
                          hintText: 'Fake st. 123',
                          sufixIcon: Icons.clear_rounded,
                          onTap: () => addressCtrlr.clear(),
                          context: context,
                        ),
                      ),
                    ),

                    // caption
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextFormField(
                        controller: captionCtrlr,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppStyles.inputDecoration(
                          labelText: 'Caption',
                          hintText: '"hi there !"',
                          sufixIcon: Icons.clear_rounded,
                          onTap: () => captionCtrlr.clear(),
                          context: context,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // buttons
                Row(
                  children: [
                    // cancel button
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => context.pop(),
                          child: const Text(
                            'CANCEL',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    //save button
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                          width: double.infinity,
                          child: ProgressButton(
                            text: isNew ? 'SAVE NEW CLIENT' : 'SAVE CHANGES',
                            onPressed: () async {
                              await _createClient(context);
                            },
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _createClient(BuildContext context) async {
    if (formStateKey.currentState!.validate()) {
      await Future.delayed(const Duration(seconds: 1));

      ref.read(
        createEdit(
          Client(
            id: widget.client?.id,
            firstname: firstNameCtrlr.text,
            lastname: lastNameCtrlr.text,
            email: emailCtrlr.text,
            photo: "",
            address: addressCtrlr.text,
            caption: captionCtrlr.text,
          ),
        ),
      );
    }
  }

  bool _validateEmail(String value) {
    RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return (!regex.hasMatch(value)) ? false : true;
  }
}
