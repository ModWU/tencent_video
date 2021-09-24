import 'package:flutter/cupertino.dart';

typedef CountdownBuilder = Widget Function(
    BuildContext context, Duration remaining, String formatStr);
typedef CountdownErrorBuilder = Widget Function(
    BuildContext context, Object error);
typedef TimeFormatHandler = String Function(Duration duration);

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
    this.initialValue, {
    required this.builder,
    this.errorBuilder,
    this.onFinish,
    this.formatter,
    this.resetTag = const Object(),
    this.isBroadcast = false,
  });

  final Duration initialValue;
  final Object resetTag;
  final bool isBroadcast;
  final CountdownBuilder builder;
  final TimeFormatHandler? formatter;
  final CountdownErrorBuilder? errorBuilder;
  final VoidCallback? onFinish;

  @override
  State<StatefulWidget> createState() => CountdownWidgetState();
}

DateTime _kBaseTimeline = DateTime(2021, 9, 24);

class CountdownWidgetState extends State<CountdownWidget>
    with RestorationMixin {
  Stream<Duration>? _countdownTicker;

  late final RestorableDateTime _currentValue =
      RestorableDateTime(_toEpochFromCountdown(widget.initialValue));

  String _formatter(Duration duration) {
    if (widget.formatter != null) return widget.formatter!(duration);
    if (duration.inHours >= 1) return _formatByHours(duration);
    if (duration.inMinutes >= 1) return _formatByMinutes(duration);

    return _formatBySeconds(duration, keepPlace: false);
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialValue > Duration.zero) {
      _countdownTicker =
          _tick(widget.initialValue, broadcast: widget.isBroadcast);
    }
  }

  static Stream<Duration> _tick(Duration tickCount, {bool broadcast = false}) {
    final Stream<Duration> stream = Stream<Duration>.periodic(
      const Duration(seconds: 1),
      (int count) => tickCount - Duration(seconds: count + 1),
    ).take(tickCount.inSeconds);
    if (broadcast) {
      return stream.asBroadcastStream();
    }
    return stream;
  }

  @override
  void didUpdateWidget(covariant CountdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool isNeedReset = widget.resetTag != oldWidget.resetTag;

    if (isNeedReset || widget.isBroadcast != oldWidget.isBroadcast) {
      setState(() {
        if (isNeedReset || _countdownTicker == null) {
          _countdownTicker = _tick(
            isNeedReset
                ? widget.initialValue
                : _parseCountdownFromEpoch(_currentValue.value),
            broadcast: widget.isBroadcast,
          );
        } else {
          if (widget.isBroadcast) {
            _countdownTicker = _countdownTicker!.asBroadcastStream();
          } else {
            _countdownTicker = _tick(
                _parseCountdownFromEpoch(_currentValue.value),
                broadcast: widget.isBroadcast);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: _countdownTicker,
      initialData: _parseCountdownFromEpoch(_currentValue.value),
      builder: (BuildContext context, AsyncSnapshot<Duration> snapshot) {
        if (widget.errorBuilder == null) {
          if (!snapshot.hasData || snapshot.hasError) {
            return const SizedBox();
          }
        } else {
          if (snapshot.hasError) {
            widget.errorBuilder!(context, snapshot.error!);
          } else if (!snapshot.hasData) {
            widget.errorBuilder!(context, 'No data!');
          }
        }

        final Duration countdown = snapshot.data!;
        _currentValue.value = _toEpochFromCountdown(countdown);
        if (countdown == Duration.zero && widget.onFinish != null) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            widget.onFinish?.call();
          });
        }

        return widget.builder(context, countdown, _formatter(countdown));
      },
    );
  }

  @override
  String? get restorationId => 'countdown_widget';

  @override
  void dispose() {
    _currentValue.dispose();
    _countdownTicker = null;
    super.dispose();
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_currentValue, 'countdown_value');
  }
}

Duration _parseCountdownFromEpoch(DateTime value) {
  final Duration countDownDuration = Duration(
      milliseconds:
          value.millisecondsSinceEpoch - _kBaseTimeline.millisecondsSinceEpoch);
  assert(countDownDuration >= Duration.zero);
  return countDownDuration;
}

DateTime _toEpochFromCountdown(Duration value) =>
    DateTime.fromMillisecondsSinceEpoch(
        _kBaseTimeline.millisecondsSinceEpoch + value.inMilliseconds);

String _oneOrTwoDigits(int n, {bool keepPlace = true}) {
  if (!keepPlace || n >= 10) return '$n';
  return '0$n';
}

String _formatBySeconds(Duration duration, {bool keepPlace = true}) =>
    _oneOrTwoDigits(duration.inSeconds.remainder(60), keepPlace: keepPlace);

String _formatByMinutes(Duration duration) {
  final String twoDigitMinutes =
      _oneOrTwoDigits(duration.inMinutes.remainder(60));
  return '$twoDigitMinutes:${_formatBySeconds(duration)}';
}

String _formatByHours(Duration duration) {
  return '${_oneOrTwoDigits(duration.inHours)}:${_formatByMinutes(duration)}';
}
