import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function()? onTap;
  final bool isSecondary;
  final bool isDisabled;
  final double? height;
  final double? width;
  final bool isLoading;
  final String? leading;
  final String? trailing;
  final double padding;
  final double radius;
  final double fontSize;
  final double iconSize;
  const CustomButton({
    super.key,
    required this.text,
    this.onTap,
    this.leading,
    this.trailing,
    this.padding = 40,
    this.radius = 24,
    this.isSecondary = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.fontSize = 18,
    this.iconSize = 24,
    this.height = 56,
    this.width = double.infinity,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(widget.radius),
      onTap: widget.isDisabled ? null : widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/5 * 3),
        height: widget.height,
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: widget.padding),
        decoration: BoxDecoration(
          color: widget.isSecondary
              ? Colors.transparent
              : widget.isDisabled
              ? Colors.grey
              : Color(0xff44B46E),
          borderRadius: BorderRadius.circular(widget.radius),
          border: widget.isSecondary ? Border.all(color: Colors.white) : null,
        ),
        child: widget.isLoading
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: widget.isSecondary
                        ? Color(0xff44B46E)
                        : Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              )
            : FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    if (widget.leading != null)
                      SvgPicture.asset(
                        widget.leading!,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        colorFilter: ColorFilter.mode(
                          widget.isSecondary
                              ? Color(0xff44B46E)
                              : Colors.blue[25]!,
                          BlendMode.srcIn,
                        ),
                      ),
                    Text(
                      widget.text,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18
                      ),
                    ),
                    if (widget.trailing != null)
                      SvgPicture.asset(
                        widget.trailing!,
                        height: widget.iconSize,
                        width: widget.iconSize,
                        colorFilter: ColorFilter.mode(
                          widget.isSecondary
                              ? Colors.blue
                              : Colors.blue.shade900,
                          BlendMode.srcIn,
                        ),
                      ),
                  ],
                ),
            ),
      ),
    );
  }
}
