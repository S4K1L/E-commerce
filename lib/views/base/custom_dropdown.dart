import 'package:bdm/views/base/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomDropdown extends StatefulWidget {
  final String? title;
  final double height;
  final String? leading;
  final String? hintText;
  final List<String> values;
  final void Function(int) onChanged;
  final void Function() fetchArea;
  const CustomDropdown({
    super.key,
    required this.values,
    required this.onChanged,
    required this.fetchArea,
    this.hintText,
    this.title,
    this.height = 56,
    this.leading,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isExpanded = false;
  String? selected;

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
            setState(() {
              isExpanded = !isExpanded;
            });

            if (isExpanded && widget.values.isEmpty) {
              widget.fetchArea();
            }
          },
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha((20 * 2.55).toInt()),
                  borderRadius: BorderRadius.circular(24),
                  border:
                      isExpanded
                          ? Border.all(color: Color(0xff44B46E), width: 0.5)
                          : Border.all(color: Color(0xffC3CAE3), width: 0.5),
                ),
                child: Column(
                  children: [
                    Container(
                      height: widget.height,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
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
                                isExpanded ? Color(0xff44B46E) : Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          Expanded(
                            child: Text(
                              selected ?? widget.hintText ?? "",
                              style:
                                  selected == null
                                      ? TextStyle(color: Color(0xffB9B8B9))
                                      : null,
                            ),
                          ),
                          AnimatedRotation(
                            duration: const Duration(milliseconds: 300),
                            turns: isExpanded ? 0.75 : 0.25,
                            child: SvgPicture.asset(
                              "assets/icons/arrow_right.svg",
                              height: 20,
                              width: 20,
                              colorFilter: ColorFilter.mode(
                                isExpanded ? Color(0xff44B46E) : Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      child:
                          isExpanded
                              ? Column(
                                children: [
                                  if (widget.values.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CustomLoading(),
                                    ),
                                  for (int i = 0; i < widget.values.length; i++)
                                    GestureDetector(
                                      behavior: HitTestBehavior.translucent,
                                      onTap: () {
                                        widget.onChanged(i);
                                        setState(() {
                                          selected = widget.values[i];
                                          isExpanded = false;
                                        });
                                      },
                                      child: SizedBox(
                                        height: widget.height,
                                        child: Row(
                                          spacing: 12,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(width: 40),
                                            Text(widget.values[i]),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              )
                              : SizedBox(height: 0, width: double.infinity),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
