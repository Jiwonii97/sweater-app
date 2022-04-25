import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// Signature for [CustomSlidableAction.onPressed].
typedef SlidableActionCallback = void Function(BuildContext context);

const int _kFlex = 1;
const Color _kBackgroundColor = Colors.white;
const bool _kAutoClose = true;

/// Represents an action of an [ActionPane].
class MyCustomSlidableAction extends StatelessWidget {
  /// Creates a [CustomSlidableAction].
  ///
  /// The [flex], [backgroundColor], [autoClose] and [child] arguments must not
  /// be null.
  ///
  /// The [flex] argument must also be greater than 0.
  const MyCustomSlidableAction({
    Key? key,
    this.flex = _kFlex,
    this.backgroundColor = _kBackgroundColor,
    this.foregroundColor,
    this.autoClose = _kAutoClose,
    required this.onPressed,
    required this.child,
  })  : assert(flex > 0),
        super(key: key);

  /// {@template slidable.actions.flex}
  /// The flex factor to use for this child.
  ///
  /// The amount of space the child's can occupy in the main axis is
  /// determined by dividing the free space according to the flex factors of the
  /// other [CustomSlidableAction]s.
  /// {@endtemplate}
  final int flex;

  /// {@template slidable.actions.backgroundColor}
  /// The background color of this action.
  ///
  /// Defaults to [Colors.white].
  /// {@endtemplate}
  final Color backgroundColor;

  /// {@template slidable.actions.foregroundColor}
  /// The foreground color of this action.
  ///
  /// Defaults to [Colors.black] if [background]'s brightness is
  /// [Brightness.light], or to [Colors.white] if [background]'s brightness is
  /// [Brightness.dark].
  /// {@endtemplate}
  final Color? foregroundColor;

  /// {@template slidable.actions.autoClose}
  /// Whether the enclosing [Slidable] will be closed after [onPressed]
  /// occurred.
  /// {@endtemplate}
  final bool autoClose;

  /// {@template slidable.actions.onPressed}
  /// Called when the action is tapped or otherwise activated.
  ///
  /// If this callback is null, then the action will be disabled.
  /// {@endtemplate}
  final SlidableActionCallback? onPressed;

  /// Typically the action's icon or label.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final effectiveForegroundColor = foregroundColor ??
        (ThemeData.estimateBrightnessForColor(backgroundColor) ==
                Brightness.light
            ? Colors.black
            : Colors.white);

    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.only(left: 8),
        width: 48,
        height: double.infinity,
        child: OutlinedButton(
          onPressed: () => _handleTap(context),
          style: OutlinedButton.styleFrom(
            backgroundColor: backgroundColor,
            primary: effectiveForegroundColor,
            onSurface: effectiveForegroundColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            side: BorderSide.none,
          ),
          child: child,
        ),
      ),
    );
  }

  void _handleTap(BuildContext context) {
    onPressed?.call(context);
    if (autoClose) {
      Slidable.of(context)?.close();
    }
  }
}
