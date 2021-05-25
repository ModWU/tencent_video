import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:tencent_video/common/listener/tap.dart';

class RiveSimpleStateMachineWidget extends StatefulWidget {
  final TapListener tapListener;
  final String uri;
  final Object? value;
  final String input;
  final double size;
  final BoxFit fit;
  final Alignment alignment;
  final bool useArtboardSize;
  final String stateMachineName;

  const RiveSimpleStateMachineWidget({
    required this.uri,
    required this.tapListener,
    this.value,
    this.size = 24,
    this.fit = BoxFit.cover,
    this.useArtboardSize = false,
    this.alignment = Alignment.center,
    required this.input,
    required this.stateMachineName,
  }) : assert(size > 0);
  @override
  State<StatefulWidget> createState() => _RiveSimpleStateMachineWidgetState();
}

class _RiveSimpleStateMachineWidgetState extends State<RiveSimpleStateMachineWidget> {
  Object? currentValue;
  late bool active;

  Artboard? _riveArtboard;
  //StateMachineController? _controller;
  SMIInput<bool>? _input;

  @override
  void initState() {
    super.initState();
    active = (widget.value == widget.tapListener.value);
    currentValue = widget.tapListener.value;
    widget.tapListener.addListener(_onTap);

    rootBundle.load(widget.uri).then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        // The artboard is the root of the animation and gets drawn in the
        // Rive widget.
        final Artboard artboard = file.mainArtboard;

        for (final animation in artboard.animations) {
          print("animation name: ${animation.name}, animation is StateMachine: ${animation is StateMachine}");
        }

        var controller =
            StateMachineController.fromArtboard(artboard, widget.stateMachineName);
        print("initstate=> ${widget.value} => controller: $controller");
        if (controller != null) {
          artboard.addController(controller);
          _input = controller.findInput(widget.input);
          print("initstate=> ${widget.value} => _input: $_input");
          _input!.value = active;
        }
        setState(() => _riveArtboard = artboard);
      },
    );
  }

  @override
  void dispose() {
    widget.tapListener.removeListener(_onTap);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RiveSimpleStateMachineWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tapListener != oldWidget.tapListener) {
      oldWidget.tapListener.removeListener(_onTap);
      widget.tapListener.addListener(_onTap);
      currentValue = widget.tapListener.value;

      if (widget.tapListener.value != widget.value) {
        if (active) {
          _input!.value = false;
        }
      } else {
        if (!active) {
          _input!.value = true;
        }
      }
    }
  }

  void _onTap() {
    if (widget.tapListener.value == widget.value) {
      print("被点击 active: $active");
      //点击状态
      if (!active) {
        _input!.value = active = true;
      }
      print("被点击 value: ${widget.value}");
    } else if (currentValue == widget.value) {
      //消失状态
      print("消失点击 value: ${widget.value}");
      _input!.value = active = false;
    }

    currentValue = widget.tapListener.value;
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? const SizedBox()
        : Container(
            width: widget.size,
            height: widget.size,
            child: Rive(
              fit: widget.fit,
              alignment: widget.alignment,
              useArtboardSize: widget.useArtboardSize,
              artboard: _riveArtboard!,
            ),
          );
  }
}



class RiveSimpleWidget extends StatefulWidget {
  final TapListener tapListener;
  final String uri;
  final Object? value;
  final double size;
  final BoxFit fit;
  final Alignment alignment;
  final bool useArtboardSize;
  final String animationName;

  const RiveSimpleWidget({
    required this.uri,
    required this.tapListener,
    this.value,
    this.size = 24,
    this.fit = BoxFit.cover,
    this.useArtboardSize = false,
    this.alignment = Alignment.center,
    required this.animationName,
  }) : assert(size > 0);
  @override
  State<StatefulWidget> createState() => _RiveSimpleWidgetState();
}

class _RiveSimpleWidgetState extends State<RiveSimpleWidget> {
  Object? currentValue;
  late bool active;

  Artboard? _riveArtboard;
  RiveAnimationController? _controller;

  @override
  void initState() {
    super.initState();
    active = (widget.value == widget.tapListener.value);
    currentValue = widget.tapListener.value;
    widget.tapListener.addListener(_onTap);

    rootBundle.load(widget.uri).then(
          (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);

        final artboard = file.mainArtboard;
        // Add a controller to play back a known animation on the main/default
        // artboard. We store a reference to it so we can toggle playback.
        artboard.addController(_controller = SimpleAnimation(widget.animationName));
        setState(() => _riveArtboard = artboard);
        WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
            _controller!.isActive = active;
        });
      },
    );
  }

  @override
  void dispose() {
    widget.tapListener.removeListener(_onTap);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant RiveSimpleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tapListener != oldWidget.tapListener) {
      oldWidget.tapListener.removeListener(_onTap);
      widget.tapListener.addListener(_onTap);
      currentValue = widget.tapListener.value;

      if (widget.tapListener.value != widget.value) {
        if (active) {
          _controller!.isActive = false;
        }
      } else {
        if (!active) {
          _controller!.isActive = true;
        }
      }
    }
  }

  void _onTap() {
    if (widget.tapListener.value == widget.value) {
      print("被点击 active: $active");
      //点击状态
      if (!active) {
        _controller!.isActive = active = true;
      }
      print("被点击 value: ${widget.value}");
    } else if (currentValue == widget.value) {
      //消失状态
      print("消失点击 value: ${widget.value}");
      _controller!.isActive = active = false;
    }

    currentValue = widget.tapListener.value;
  }

  @override
  Widget build(BuildContext context) {
    return _riveArtboard == null
        ? const SizedBox()
        : Container(
      width: widget.size * 2,
      height: widget.size,
      child: Rive(
        fit: widget.fit,
        alignment: widget.alignment,
        useArtboardSize: widget.useArtboardSize,
        artboard: _riveArtboard!,
      ),
    );
  }
}
