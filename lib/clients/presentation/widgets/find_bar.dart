import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tots_flutter_test/clients/presentation/providers/client_provider.dart';
import 'package:tots_flutter_test/core/routes/routes.dart';

class FindBar extends ConsumerStatefulWidget {
  const FindBar({super.key});

  @override
  ConsumerState<FindBar> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<FindBar> {
  bool isLoading = false;
  late TextEditingController _txtCtrlr;
  late GlobalKey<FormState> _formStateKey;

  @override
  void initState() {
    super.initState();
    _txtCtrlr = TextEditingController();
    _formStateKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formStateKey,
      child: TextFormField(
        controller: _txtCtrlr,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.search,
        decoration: _inputDecoration(
          labelText: 'Find client by ID',
          hintText: '1526',
          sufixIcon: isLoading
              ? Transform.scale(
                  scale: 0.5,
                  child: const CircularProgressIndicator(strokeWidth: 8),
                )
              : _txtCtrlr.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() => _txtCtrlr.clear());
                      },
                      icon: const Icon(Icons.clear_rounded),
                    ),
          context: context,
        ),
        validator: (value) {
          if (value! == "") {
            return 'Please enter your first name';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          setState(() {});
        },
        onEditingComplete: () async {
          // 1- show loading //
          setState(() => isLoading = !isLoading);
          final data = await ref.read(getClientProvider(int.parse(_txtCtrlr.text)).future);

          if (data != null) {
            // if != null > navegate to clientscreen
            ref.read(appRouterProvider).pushNamed(
              AppRoutes.findClientScreen,
              extra: {"client": data},
            );
          } else {
            // if == null > stop loading and clear textfield
            setState(() {
              isLoading = !isLoading;
              _txtCtrlr.clear();
              FocusScope.of(context).unfocus();
            });
          }
        },
      ),
    );
  }

  static InputDecoration _inputDecoration({
    required String labelText,
    required String hintText,
    required Widget? sufixIcon,
    required BuildContext context,
  }) {
    final textStyles = Theme.of(context).textTheme;

    return InputDecoration(
      // hint
      hintStyle: textStyles.bodyMedium!.copyWith(fontStyle: FontStyle.italic, color: Colors.grey),
      // regular borders
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      //error borders
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade800, width: 1.0),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
      ),
      // other properties
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      labelText: labelText,
      hintText: hintText,
      suffixIcon: sufixIcon,
    );
  }
}
