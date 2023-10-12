import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../common/common.dart';
import '../widgets/widgets.dart';

class FortuneWheelPage extends HookWidget {
  static const kRouteName = 'FortuneWheelPage';

  static void go(BuildContext context) {
    context.goNamed(kRouteName);
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(duration: Duration(seconds: 20));
    final alignment = useState(Alignment.topCenter);
    final selected = useStreamController<int>();
    final selectedIndex = useStream(selected.stream, initialData: 0).data ?? 0;
    final isAnimating = useState(false);

    final alignmentSelector = AlignmentSelector(
      selected: alignment.value,
      onChanged: (v) => alignment.value = v!,
    );

    void emitSelectedIndex() {
      selected.add(
        roll(Constants.fortuneValues.length),
      );
    }

    void startAnimation() {
      isAnimating.value = true;
      animationController.repeat();
    }

    void animateStop() async {
      await animationController.animateTo(1, duration: Duration(seconds: 10), curve: FortuneCurve.spin);
      animationController.stop();
      isAnimating.value = false;
    }

    return AppLayout(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            alignmentSelector,
            SizedBox(height: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () {
                    if (isAnimating.value) {
                      return;
                    }
                    startAnimation();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.yellowAccent),
                  ),
                  child: Text('Start rolling'),
                ),
                SizedBox(width: 10),
                RollButtonWithPreview(
                  selected: selectedIndex,
                  items: Constants.fortuneValues,
                  onPressed: emitSelectedIndex,
                ),
                SizedBox(width: 10),
                OutlinedButton(
                  onPressed: () {
                    if (!isAnimating.value) {
                      return;
                    }
                    animateStop();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.yellowAccent),
                  ),
                  child: Text('Stop rolling'),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: FortuneWheel(
                alignment: alignment.value,
                animationController: animationController,
                selected: selected.stream,
                onFling: startAnimation,
                animateFirst: false,
                curve: Curves.linear,
                hapticImpact: HapticImpact.heavy,
                indicators: [
                  FortuneIndicator(
                    alignment: alignment.value,
                    child: TriangleIndicator(),
                  ),
                ],
                items: [for (var it in Constants.fortuneValues) FortuneItem(child: Text(it), onTap: () => print(it))],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
