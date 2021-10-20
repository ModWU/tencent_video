import 'package:flutter/material.dart';

typedef CountdownWidgetBuilder = Widget Function(
    BuildContext context, Duration remaining, String formatStr);
typedef CountdownErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error);
typedef TimeFormatHandler = String Function(Duration duration);

class CountdownBuilder extends StatefulWidget {
  const CountdownBuilder(
      this.initialValue, {
        required this.builder,
        this.errorBuilder,
        this.onFinish,
        this.formatter,
        this.resetTag = const Object(),
      });

  final Duration initialValue;
  final Object resetTag;
  final CountdownWidgetBuilder builder;
  final TimeFormatHandler? formatter;
  final CountdownErrorWidgetBuilder? errorBuilder;
  final VoidCallback? onFinish;

  @override
  State<StatefulWidget> createState() => _CountdownBuilderState();
}

DateTime _kBaseTimeline = DateTime(2021, 9, 24);

class _CountdownBuilderState extends State<CountdownBuilder>
    with RestorationMixin {
  Stream<Duration>? _countdownTicker;

  late final RestorableDateTime _currentValue =
  RestorableDateTime(_toEpochFromCountdown(widget.initialValue));

  String _getFormatCountDown(Duration countdown) {
    if (widget.formatter != null) return widget.formatter!(countdown);
    if (countdown.inHours >= 1) return _formatByHours(countdown);
    if (countdown.inMinutes >= 1) return _formatByMinutes(countdown);

    return _formatBySeconds(countdown, keepPlace: false);
  }

  @override
  void initState() {
    super.initState();
    _countdownTicker = _createCountDownTicker(widget.initialValue);
  }

  static Stream<Duration> _createCountDownTicker(Duration tickCount) {
    final Stream<Duration> stream = Stream<Duration>.periodic(
      const Duration(seconds: 1),
          (int count) => tickCount - Duration(seconds: count + 1),
    ).take(tickCount.inSeconds);
    return stream;
  }

  @override
  void didUpdateWidget(covariant CountdownBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool needReset = widget.resetTag != oldWidget.resetTag;

    if (needReset) {
      setState(() {
        _countdownTicker = _createCountDownTicker(widget.initialValue);
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
            return widget.errorBuilder!(context, snapshot.error!);
          } else if (!snapshot.hasData) {
            return widget.errorBuilder!(context, 'No data!');
          }
        }

        final Duration countdown = snapshot.data!;
        _currentValue.value = _toEpochFromCountdown(countdown);
        if (countdown == Duration.zero && widget.onFinish != null) {
          WidgetsBinding.instance!.addPostFrameCallback((_) {
            widget.onFinish?.call();
          });
        }

        return widget.builder(
            context, countdown, _getFormatCountDown(countdown));
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
