import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class PinInputField extends StatefulWidget {
  final int length;
  final void Function(bool)? onFocusChange;
  final void Function(String) onSubmit;

  const PinInputField({
    Key? key,
    this.length = 6,
    this.onFocusChange,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<PinInputField> createState() => _PinInputFieldState();
}

class _PinInputFieldState extends State<PinInputField> with WidgetsBindingObserver {
  late final TextEditingController _pinPutController;
  late final FocusNode _pinPutFocusNode;
  late final int _length;

  Size _findContainerSize(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.85;

    width /= _length;

    return Size.square(width);
  }

  @override
  void initState() {
    super.initState();
    _pinPutController = TextEditingController();
    _pinPutFocusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);

    if (widget.onFocusChange != null) {
      _pinPutFocusNode.addListener(() {
        widget.onFocusChange!(_pinPutFocusNode.hasFocus);
      });
    }

    _length = widget.length;
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    keyboardHidden.then((value) => value ? _pinPutFocusNode.requestFocus() : null);
  }

  Future<bool> get keyboardHidden async {
    check() => (WidgetsBinding.instance.window.viewInsets.bottom) > 0;

    if (!check()) return false;
    return await Future.delayed(const Duration(milliseconds: 100), () => check());
  }

  PinTheme _getPinTheme(
    BuildContext context, {
    required Size size,
  }) {
    return PinTheme(
      height: size.height,
      width: size.width,
      textStyle: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
          color: Theme.of(context).splashColor),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(7.5.r),
        border: Border.all(
          width: 1,
          color: Theme.of(context).splashColor,
        ),
      ),
    );
  }

  static const _focusScaleFactor = 1.15;

  @override
  Widget build(BuildContext context) {
    final size = _findContainerSize(context);
    final defaultPinTheme = _getPinTheme(context, size: size);

    _pinPutFocusNode.requestFocus();

    return SizedBox(
      height: size.height * _focusScaleFactor,
      child: Pinput(
        focusNode: _pinPutFocusNode,
        controller: _pinPutController,
        length: _length,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme.copyWith(
          height: size.height * _focusScaleFactor,
          width: size.width * _focusScaleFactor,
          decoration: defaultPinTheme.decoration!.copyWith(
            border: Border.all(color: Theme.of(context).splashColor),
          ),
        ),
        errorPinTheme: defaultPinTheme.copyWith(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onCompleted: widget.onSubmit,
        pinAnimationType: PinAnimationType.scale,
      ),
    );
  }
}
