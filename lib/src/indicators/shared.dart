part of 'indicators.dart';

@immutable
class FortuneIndicator {
  final Alignment alignment;
  final Alignment? customAlignment;
  final Widget child;

  const FortuneIndicator({
    this.alignment = Alignment.center,
    this.customAlignment,
    required this.child,
  });

  @override
  int get hashCode => hash3(alignment, customAlignment, child);

  @override
  bool operator ==(Object other) {
    return other is FortuneIndicator &&
        alignment == other.alignment &&
        customAlignment == other.customAlignment &&
        child == other.child;
  }
}
