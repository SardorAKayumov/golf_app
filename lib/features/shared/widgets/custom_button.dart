import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomButton extends StatefulWidget {
  final double height;
  final Color backgroundColor;
  final String text;
  final TextStyle textStyle;
  final double borderRadius;
  final double width;
  final bool isLoading;
  final Color loadingColor;
  final double? loadingIndicatorRadius;
  final VoidCallback onTap;
  final double elevation;
  final String? svgIcon;
  const CustomButton({
    super.key,
    required this.height,
    required this.backgroundColor,
    required this.text,
    required this.textStyle,
    required this.borderRadius,
    required this.width,
    required this.onTap,
    this.isLoading = false,
    this.loadingColor = CupertinoColors.white,
    this.loadingIndicatorRadius,
    this.elevation = 0,
    this.svgIcon,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: TextButton(
        onPressed: widget.isLoading ? null : widget.onTap,
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(widget.elevation),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)))),
          backgroundColor: WidgetStatePropertyAll(widget.backgroundColor),
        ),
        child: widget.isLoading
            ? CupertinoActivityIndicator(
                radius: widget.loadingIndicatorRadius ?? 10.w,
                color: widget.loadingColor,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.text, style: widget.textStyle),
                  if (widget.svgIcon != null) SizedBox(width: 4.w),
                  if (widget.svgIcon != null)
                    SvgPicture.asset(
                      widget.svgIcon!,
                      width: 24.h,
                      height: 24.h,
                      fit: BoxFit.none,
                      colorFilter: ColorFilter.mode(
                        widget.textStyle.color ?? Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
