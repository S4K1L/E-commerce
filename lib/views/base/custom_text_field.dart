import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final String? errorText;
  final String? leading;
  final String? trailing;
  final TextInputType? textInputType;
  final bool isDisabled;
  final double radius;
  final double? height;
  final double? width;
  final TextEditingController? controller;
  final bool isPassword;
  final int lines;
  final void Function()? onTap;
  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    this.leading,
    this.trailing,
    this.isPassword = false,
    this.isDisabled = false,
    this.radius = 24,
    this.lines = 1,
    this.textInputType,
    this.controller,
    this.onTap,
    this.errorText,
    this.height = 56,
    this.width,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscured = false;
  bool isFocused = false;
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    isObscured = widget.isPassword;
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isFocused = true;
        });
      } else {
        setState(() {
          isFocused = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.title!,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
        GestureDetector(
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!();
            } else {
              if (!widget.isDisabled) {
                focusNode.requestFocus();
              }
            }
          },
          child: Container(
            height: widget.lines == 1 ? widget.height : null,
            width: widget.width,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: widget.lines == 1 ? 0 : 20,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(widget.radius),
              border:
                  isFocused
                      ? Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 1.0,
                      )
                      : Border.all(
                        color: Theme.of(context).dividerColor,
                        width: 0.5,
                      ),
              boxShadow: [
                if (isFocused)
                  BoxShadow(
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
              ],
            ),
            child: Row(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (widget.leading != null)
                  SvgPicture.asset(
                    widget.leading!,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      isFocused
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).iconTheme.color ?? Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                Expanded(
                  child: TextField(
                    focusNode: focusNode,
                    controller: widget.controller,
                    maxLines: widget.lines,
                    cursorColor: Theme.of(context).primaryColor,
                    keyboardType: widget.textInputType,
                    obscureText: isObscured,
                    enabled: !widget.isDisabled && widget.onTap == null,
                    onTapOutside: (event) {
                      setState(() {
                        isFocused = false;
                        focusNode.unfocus();
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ),
                ),
                if (widget.trailing != null)
                  SvgPicture.asset(
                    widget.trailing!,
                    height: 20,
                    width: 20,
                    colorFilter: ColorFilter.mode(
                      isFocused
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).iconTheme.color ?? Colors.grey,
                      BlendMode.srcIn,
                    ),
                  ),
                if (widget.isPassword)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    behavior: HitTestBehavior.translucent,
                    child: SvgPicture.asset(
                      isObscured
                          ? "assets/icons/eye_off.svg"
                          : "assets/icons/eye.svg",
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        isFocused
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).iconTheme.color ?? Colors.grey,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                fontVariations: [FontVariation("wght", 400)],
                fontSize: 12,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
