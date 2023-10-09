part of 'wheel.dart';

class _TransformedCircleSlice extends StatelessWidget {
  final TransformedFortuneItem item;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;
  final int index;

  const _TransformedCircleSlice({
    Key? key,
    required this.item,
    required this.styleStrategy,
    required this.index,
    required this.wheelData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = item.style ?? styleStrategy.getItemStyle(theme, index, wheelData.itemCount);

    return _CircleSliceLayout(
      handler: item,
      child: DefaultTextStyle(
        textAlign: style.textAlign,
        style: style.textStyle,
        child: item.child,
      ),
      slice: _CircleSlice(
        radius: wheelData.radius,
        angle: wheelData.itemAngle,
        fillColor: style.color,
        strokeColor: style.borderColor,
        strokeWidth: style.borderWidth,
      ),
    );
  }
}

class _CircleSlices extends StatelessWidget {
  final List<TransformedFortuneItem> items;
  final List<TransformedFortuneItem> decorationItems;
  final List<TransformedFortuneItem> borderItems;
  final StyleStrategy styleStrategy;
  final _WheelData wheelData;

  const _CircleSlices({
    Key? key,
    required this.items,
    required this.styleStrategy,
    required this.wheelData,
    required this.decorationItems,
    required this.borderItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slices = [
      for (var i = 0; i < items.length; i++)
        Transform.translate(
          offset: items[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: items[i].angle,
            child: _TransformedCircleSlice(
              item: items[i],
              styleStrategy: styleStrategy,
              index: i,
              wheelData: wheelData,
            ),
          ),
        ),
    ];
    final slices2 = [
      for (var i = 0; i < borderItems.length; i++)
        Transform.translate(
          offset: borderItems[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: borderItems[i].angle,
            child: SpinWheelSideItem(),
          ),
        ),
    ];

    final slices3 = [
      for (var i = 0; i < decorationItems.length; i++)
        Transform.translate(
          offset: decorationItems[i].offset,
          child: Transform.rotate(
            alignment: Alignment.topLeft,
            angle: decorationItems[i].angle,
            child: SpinWheelSideItem(
              isLine: false,
            ),
          ),
        ),
    ];

    return Stack(
      children: [...slices, ...slices2, ...slices3],
    );
  }
}
