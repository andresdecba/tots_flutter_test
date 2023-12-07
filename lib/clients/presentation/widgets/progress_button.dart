import 'package:flutter/material.dart';

enum ProgressButtonState {
  stateDefault,
  stateProcessing,
}

enum ProgressButtonType {
  raised,
  flat,
  outline,
}

class ProgressButton extends StatefulWidget {
  final String text;
  final Function? onPressed;
  final ProgressButtonType type;
  final Color color;

  const ProgressButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ProgressButtonType.flat,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  _ProgressButtonState createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton> with TickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();
  Animation? _anim;
  AnimationController? _animController;
  final Duration _duration = const Duration(milliseconds: 250);
  late ProgressButtonState _state;
  late double _width;
  late double _height;
  late double _borderRadius;

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    super.initState();
  }

  void _reset() {
    _state = ProgressButtonState.stateDefault;
    _width = double.infinity;
    _height = 40;
    _borderRadius = 100.0;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    var padding = const EdgeInsets.all(0.0);
    var color = widget.color;
    var shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(_borderRadius));

    switch (widget.type) {
      case ProgressButtonType.raised:
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: padding,
            backgroundColor: color,
            shape: shape,
          ),
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case ProgressButtonType.flat:
        return TextButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            )),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) => states.contains(MaterialState.disabled)
                  ? Colors.grey
                  : states.contains(MaterialState.pressed)
                      ? Colors.grey
                      : color,
            ),
          ),
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case ProgressButtonType.outline:
        return OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: color,
            padding: padding,
            shape: shape,
          ),
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    Widget ret;
    switch (_state) {
      case ProgressButtonState.stateDefault:
        ret = Text(
          widget.text,
          style: textStyles.titleSmall!.copyWith(color: Colors.white),
        );
        break;
      case ProgressButtonState.stateProcessing:
        ret = const SizedBox(
          height: 30.0,
          width: 30.0,
          child: Center(
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          ),
        );

        //ret = CircularProgressIndicator(backgroundColor: Colors.white);
        break;
    }
    return ret;
  }

  VoidCallback? _onButtonPressed() {
    return widget.onPressed == null
        ? null
        : () async {
            if (_state != ProgressButtonState.stateDefault) {
              return;
            }

            // The result of widget.onPressed() will be called as VoidCallback
            // after button status is back to default.
            VoidCallback? onDefault;

            _toProcessing();
            _forward((status) {
              if (status == AnimationStatus.dismissed) {
                _toDefault();
                if (onDefault != null) {
                  onDefault();
                }
              }
            });
            onDefault = await widget.onPressed!();
            _reverse();
          };
  }

  void _toProcessing() {
    setState(() {
      _state = ProgressButtonState.stateProcessing;
    });
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _state = ProgressButtonState.stateDefault;
      });
    } else {
      _state = ProgressButtonState.stateDefault;
    }
  }

  void _forward(AnimationStatusListener stateListener) {
    var initialWidth = _globalKey.currentContext!.size!.width;
    var initialBorderRadius = 10.0;
    var targetWidth = _height;
    var targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim!.value);
          _borderRadius = initialBorderRadius - ((initialBorderRadius - targetBorderRadius) * _anim!.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController!.forward();
  }

  void _reverse() {
    try {
      if (_animController != null) {
        _animController?.reverse();
      }
    } on AssertionError {
      //AnimationController.reverse() called after AnimationController.dispose()
    } catch (_) {
      // Si da error, no pasa nada.
    }
  }
}
