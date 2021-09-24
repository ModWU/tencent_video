import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  VideoWidget.network(
    String dataSource, {
    Key? key,
    VideoFormat? formatHint,
    Future<ClosedCaptionFile>? closedCaptionFile,
    VideoPlayerOptions? videoPlayerOptions,
    Map<String, String> httpHeaders = const <String, String>{},
    this.aspectRatio,
  })  : _controllerConfigs = VideoPlayerController.network(dataSource,
            formatHint: formatHint,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions,
            httpHeaders: httpHeaders),
        _onlyControllerType = false,
        super(key: key);

  const VideoWidget.controller(
    VideoPlayerController controller, {
    Key? key,
    this.aspectRatio,
  })  : _controllerConfigs = controller,
        _onlyControllerType = true,
        super(key: key);

  VideoWidget.asset(
    String dataSource, {
    Key? key,
    String? package,
    Future<ClosedCaptionFile>? closedCaptionFile,
    VideoPlayerOptions? videoPlayerOptions,
    this.aspectRatio,
  })  : _controllerConfigs = VideoPlayerController.asset(dataSource,
            package: package,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions),
        _onlyControllerType = false,
        super(key: key);

  VideoWidget.file(
    File file, {
    Key? key,
    Future<ClosedCaptionFile>? closedCaptionFile,
    VideoPlayerOptions? videoPlayerOptions,
    this.aspectRatio,
  })  : _controllerConfigs = VideoPlayerController.file(file,
            closedCaptionFile: closedCaptionFile,
            videoPlayerOptions: videoPlayerOptions),
        _onlyControllerType = false,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoWidgetState();

  final VideoPlayerController _controllerConfigs;
  final bool _onlyControllerType;
  final double? aspectRatio;
}

class _VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController? _videoController;
  Duration? _currentPosition;
  bool? _hasError;

  bool _isControllerInitialized(VideoPlayerController? _videoController) =>
      _videoController?.value.isInitialized == true;

  bool get hasError => _hasError ?? false;

  @override
  void dispose() {
    _disposeController();
    _hasError = null;
    super.dispose();
  }

  void _disposeController() {
    if (!widget._onlyControllerType) {
      _videoController?.dispose();
    }
    _videoController?.removeListener(_playEvent);
    _videoController = null;
  }

  void _updateAndInitController(VideoPlayerController controller) {
    controller.removeListener(_playEvent);
    controller.addListener(_playEvent);

    if (_videoController != null) {
      _videoController!.dispose();
    }

    _videoController = controller;
    _initController(_videoController!);
  }

  void _initController(VideoPlayerController controller, {bool isCorrect = false}) {
    controller.initialize().then((_) {
      if (isCorrect) {
        _correctPosition();
      }
      _handleError(false);
    });
  }

  void _correctPosition() {
    if (_currentPosition != null) {
      if (_videoController!.value.position != _currentPosition) {
        _videoController!.seekTo(_currentPosition!);
      }
    }
  }

  bool _isNeedUpdateControllerWithFile(VideoPlayerController oldController,
      VideoPlayerController newController) {
    return oldController.dataSource != newController.dataSource ||
        oldController.closedCaptionFile != newController.closedCaptionFile ||
        oldController.videoPlayerOptions != newController.videoPlayerOptions;
  }

  bool _isNeedUpdateControllerWithAsset(VideoPlayerController oldController,
      VideoPlayerController newController) {
    assert(oldController.dataSourceType == newController.dataSourceType);
    return oldController.dataSource != newController.dataSource ||
        oldController.package != newController.package ||
        oldController.closedCaptionFile != newController.closedCaptionFile ||
        oldController.videoPlayerOptions != newController.videoPlayerOptions;
  }

  bool _isNeedUpdateControllerWithNetwork(VideoPlayerController oldController,
      VideoPlayerController newController) {
    assert(oldController.dataSourceType == newController.dataSourceType);
    return oldController.dataSource != newController.dataSource ||
        oldController.closedCaptionFile != newController.closedCaptionFile ||
        oldController.videoPlayerOptions != newController.videoPlayerOptions ||
        oldController.formatHint != newController.formatHint ||
        oldController.httpHeaders != newController.httpHeaders;
  }

  bool _isNeedUpdateController() {
    if (_videoController == null) return true;

    if (_videoController == widget._controllerConfigs) return false;

    if (widget._onlyControllerType) return true;

    final DataSourceType oldDataSourceType = _videoController!.dataSourceType;
    final DataSourceType newDataSourceType =
        widget._controllerConfigs.dataSourceType;
    if (oldDataSourceType == newDataSourceType) {
      switch (widget._controllerConfigs.dataSourceType) {
        case DataSourceType.file:
          return _isNeedUpdateControllerWithFile(
              _videoController!, widget._controllerConfigs);
        case DataSourceType.asset:
          return _isNeedUpdateControllerWithAsset(
              _videoController!, widget._controllerConfigs);
        case DataSourceType.network:
          return _isNeedUpdateControllerWithNetwork(
              _videoController!, widget._controllerConfigs);
      }
    }

    return true;
  }

  void _tryUpdateController() {
    final bool isNeedUpdate = _isNeedUpdateController();
    print("isNeedUpdate: ${isNeedUpdate}, hasError: $hasError");
    if (isNeedUpdate) {
      _updateAndInitController(widget._controllerConfigs);
    } else {
      if (hasError) {
        _initController(_videoController!, isCorrect: true);
      }
    }
  }

  void _handleError(bool hasError) {
    if (hasError != this.hasError) {
      setState(() {
        _hasError = hasError;
      });
    }
  }

  void _playEvent() {

    //_handleError();

    print(
        "_playEvent => isBuffering:${_videoController!.value.isBuffering}, position: ${_videoController!.value.position}, isError: ${_videoController!.value.hasError} duration: ${_videoController!.value.duration}");

    if (hasError) {
      return;
    }

    _currentPosition = _videoController!.value.position;

  }

  @override
  void initState() {
    super.initState();
    _tryUpdateController();
  }

  @override
  void didUpdateWidget(covariant VideoWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('_VideoWidgetState => didUpdateWidget');
    _tryUpdateController();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widget.aspectRatio ?? _videoController!.value.aspectRatio,
      child: Stack(
        children: <Widget>[
          VideoPlayer(_videoController!),
          TextButton(
            onPressed: () {
              _videoController!.play();
            },
            child: Text("play"),
          ),
        ],
      ),
    );
  }
}
