
import 'package:chatting/core/presentation/theming/styles.dart';
import 'package:flutter/material.dart';

import '../theming/color_manager.dart';

class PrimaryTextField extends StatefulWidget {
  final String hintText;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? errorText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final OutlineInputBorder? focusedBorder;
  final bool? clearText;
  final GlobalKey<PrimaryTextFieldState>? globalKey;
  final Function(bool)? onFocusChange; // Callback for validation
  final Function(String)? onTextChange;

   const PrimaryTextField({
    this.globalKey,
    required this.hintText,
    this.clearText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorText,
    this.hintStyle,
    this.labelStyle,
    this.focusedBorder,
    this.onFocusChange, // Pass the validation callback
    this.onTextChange
  }) : super(key: globalKey);

  @override
  PrimaryTextFieldState createState() => PrimaryTextFieldState();
}

class PrimaryTextFieldState extends State<PrimaryTextField> {
  final FocusNode _focusNode = FocusNode(); // Create a FocusNode
  final TextEditingController _controller = TextEditingController(); // Controller for the text field

  @override
  void initState() {
    super.initState();
    //widget.globalKey?.currentState?.dispose(); // Ensure old states are cleared
   // widget.globalKey?.currentState?.context; // Link the key to the state
    // Add a listener to the FocusNode

    _addFocusChangeListener();
    _addOnTextChangeListener();
  }

  void _addFocusChangeListener(){
    if (widget.onFocusChange != null){
      // We are adding a listener once the user really implements the onFocusChange call back
      _focusNode.addListener(_onFocusChange);
    }
  }

  void _addOnTextChangeListener(){
    if (widget.onTextChange != null){
      // We are adding a listener once the user really implements the onTextChange call back
      _controller.addListener(_onTextChange);
    }
  }

  void clearText(){
    print("Controller text =${_controller.text}");
    _controller.clear();
    print("Controller text after clearing is =${_controller.text}");
  }

  @override
  void dispose() {
    // Clean up the FocusNode and Controller
    if (widget.onFocusChange != null){
      _focusNode.removeListener(_onFocusChange);
    }
    if (widget.onTextChange != null){
      _controller.removeListener(_onTextChange);
    }
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    widget.onFocusChange!(_focusNode.hasFocus);
    // if (!_focusNode.hasFocus) {
    //   // Focus is lost, validate the value
    //   if (_controller.text.isNotEmpty && widget.onValidate != null) {
    //     widget.onValidate!(_controller.text); // Call the validation callback
    //   }
    // }
  }

  void _onTextChange(){
    widget.onTextChange!(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller, // Attach the controller
      focusNode: _focusNode, // Attach the FocusNode
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.grey3, width: 1.0),
          borderRadius: BorderRadius.circular(16.0),
        ),
        focusedBorder: widget.focusedBorder ?? OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.primary, width: 1.0),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorManager.red),
          borderRadius: BorderRadius.circular(15.0),
        ),
        errorText: widget.errorText,
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? TextStyles.p14Regular.copyWith(color: ColorManager.grey),
        labelStyle: widget.labelStyle ?? TextStyles.p14Regular.copyWith(color: ColorManager.black),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
    );
  }
}