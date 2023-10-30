// ignore_for_file: constant_identifier_names, use_key_in_widget_constructors

import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final String initialText, finalText;
  final buttonstyle buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;
  final Function onTap;

  AnimatedButton(
      {required this.initialText,
      required this.finalText,
      required this.iconData,
      required this.iconSize,
      required this.animationDuration,
      required this.buttonStyle,
      required this.onTap});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late ButtonState _currentState;
  late Duration _smallDuration;
  late Animation<double> _scaleFinalTextAnimation;

  @override
  void initState() {
    super.initState();
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _smallDuration = Duration(
        milliseconds: (widget.animationDuration.inMilliseconds * 0.2).round());
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _controller.addListener(() {
      double _controllerValue = _controller.value;
      if (_controllerValue < 0.2) {
        setState(() {
          _currentState = ButtonState.SHOW_ONLY_ICON;
        });
      } else if (_controllerValue > 0.8) {
        setState(() {
          _currentState = ButtonState.SHOW_TEXT_ICON;
          _resetTimer = Timer(Duration(seconds: 2), () {
            setState(() {
              _currentState = ButtonState.SHOW_ONLY_TEXT;
            });
          });
        });
      }
    });

    _controller.addStatusListener((currentStatus) {
      if (currentStatus == AnimationStatus.completed) {
        return widget.onTap();
      }
    });

    _scaleFinalTextAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _resetTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  Timer? _resetTimer;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: widget.buttonStyle.elevation,
      borderRadius:
          BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)),
      child: GestureDetector(
        onTap: () {
          _controller.reset();

          _controller.forward();
        },
        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconSize + 16,
          decoration: BoxDecoration(
            color: (_currentState == ButtonState.SHOW_ONLY_ICON ||
                    _currentState == ButtonState.SHOW_TEXT_ICON)
                ? widget.buttonStyle.secondaryColor
                : widget.buttonStyle.primaryColor,
            border: Border.all(
                color: (_currentState == ButtonState.SHOW_ONLY_ICON ||
                        _currentState == ButtonState.SHOW_TEXT_ICON)
                    ? widget.buttonStyle.primaryColor
                    : Colors.transparent),
            borderRadius: BorderRadius.all(
                Radius.circular(widget.buttonStyle.borderRadius)),
          ),
          padding: EdgeInsets.symmetric(
            horizontal:
                (_currentState == ButtonState.SHOW_ONLY_ICON) ? 16.0 : 48.0,
            vertical: 8.0,
          ),
          child: AnimatedSize(
            //  vsync: this,
            curve: Curves.easeIn,
            duration: _smallDuration,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                (_currentState == ButtonState.SHOW_ONLY_ICON ||
                        _currentState == ButtonState.SHOW_TEXT_ICON)
                    ? Icon(
                        widget.iconData,
                        size: widget.iconSize,
                        color: widget.buttonStyle.primaryColor,
                      )
                    : Container(),
                SizedBox(
                  width:
                      _currentState == ButtonState.SHOW_TEXT_ICON ? 30.0 : 0.0,
                ),
                getTextWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getTextWidget() {
    if (_currentState == ButtonState.SHOW_ONLY_TEXT) {
      return Text(
        widget.initialText,
        style: widget.buttonStyle.initialTextStyle,
      );
    } else if (_currentState == ButtonState.SHOW_ONLY_ICON) {
      return Container();
    } else {
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
        child: Text(
          widget.finalText,
          style: widget.buttonStyle.finalTextStyle,
        ),
      );
    }
  }
}

class buttonstyle {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  buttonstyle(
      {required this.primaryColor,
      required this.secondaryColor,
      required this.initialTextStyle,
      required this.finalTextStyle,
      required this.elevation,
      required this.borderRadius});
}

enum ButtonState { SHOW_ONLY_TEXT, SHOW_ONLY_ICON, SHOW_TEXT_ICON }
