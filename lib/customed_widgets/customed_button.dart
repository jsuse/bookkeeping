import 'package:bookkeeping/app_theme.dart';
import 'package:flutter/material.dart';

class CustomedOutlinedButton extends StatelessWidget {
  const CustomedOutlinedButton({
    super.key,
    required this.name,
    this.color = AppTheme.lightGrey,
    this.onPress,
  });

  final String name;
  final Color color;
  final Function? onPress;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        if (onPress != null) onPress!();
      },
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(90, 45),
        side: BorderSide(color: color),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
      ),
      child: Text(
        name,
        style: TextStyle(color: color),
      ),
    );
  }
}

class CustomedOptionButton extends StatefulWidget {
  const CustomedOptionButton({
    super.key,
    required this.text,
    this.onTap,
    required this.isSelect,
  });

  final String text;
  final Function? onTap;
  final bool isSelect;

  @override
  State<CustomedOptionButton> createState() => _CustomedOptionButtonState();
}

class _CustomedOptionButtonState extends State<CustomedOptionButton> {
  Color textColor = Colors.black;
  Color backgroundColor = Colors.white;
  bool isSelected = false;

  @override
  void initState() {
    super.initState();
    isSelected = widget.isSelect;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 230, 230, 230)
              : Colors.white,
          fixedSize: const Size(120, 60),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            color: isSelected ? AppTheme.lightGrey : Colors.black,
          ),
        ),
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
          });

          if (widget.onTap != null) widget.onTap!();
        },
      ),
    );
  }
}

class SubtypeOptionButton extends StatefulWidget {
  const SubtypeOptionButton({
    super.key,
    required this.imagePath,
    required this.label,
    this.onPress,
    this.onChange,
    this.std,
  });

  final String imagePath;
  final String label;
  final Function? onPress;
  final ValueChanged<bool>? onChange;
  final String? std;

  @override
  State<SubtypeOptionButton> createState() => _SubtypeOptionButtonState();
}

class _SubtypeOptionButtonState extends State<SubtypeOptionButton> {
  bool isSelected = false;
  final Color unselectedBackColor = ThemeData().scaffoldBackgroundColor;
  final Color selectedBackColor = AppTheme.lightGreen;

  @override
  void initState() {
    super.initState();
    isSelected = widget.std == widget.label;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected
              ? selectedBackColor
              : unselectedBackColor,
        ),
        onPressed: () {
          setState(() {
            isSelected = !isSelected;
          });
          if (widget.onPress != null) widget.onPress!();
          if (widget.onChange != null) widget.onChange!(isSelected);
        },
        child: Column(
          children: [
            Image.asset(widget.imagePath, width: 45, height: 45),
            Text(
              widget.label,
              style: const TextStyle(fontSize: 18, color: AppTheme.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}

/// 登录按钮
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    this.onTap,
    this.size,
    this.text = '登     录',
    this.fontSize = 20,
    this.textColor = Colors.white,
  });

  final Function? onTap;
  final Size? size;
  final String text;
  final double fontSize;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onTap != null) onTap!();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.themeColor,
        fixedSize: size ?? const Size(250, 60),
        elevation: 0,
        side: const BorderSide(color: AppTheme.darkGold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      child: Text(text, style: TextStyle(fontSize: fontSize, color: textColor)),
    );
  }
}
