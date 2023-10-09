part of 'wheel.dart';

class SpinWheelSideItem extends StatelessWidget {
  final bool isLine;

  const SpinWheelSideItem({
    Key? key,
    this.isLine = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLine ? _buildLine(context) : _buildItem(context);
  }

  Widget _buildLine(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 1.7,
      width: 3,
      decoration: BoxDecoration(
        color: const Color(0xFF2C69AA),
        border: Border.all(
          color: const Color(0x50282828),
          width: 2,
          style: BorderStyle.solid,
        ),
        shape: BoxShape.rectangle,
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 1.7,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: SizedBox(
            height: 10,
            width: 10,
            child: Stack(
              children: <Widget>[
                _buildBackgroundBody(),
                _buildTopBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBody() {
    return Center(
      child: ClipOval(
        child: Container(
          height: 6,
          width: 6,
          decoration: BoxDecoration(
            color: const Color(0xFFF8D539),
            border: Border.all(
              color: const Color(0xFFDF6836),
              width: 0.5,
              style: BorderStyle.solid,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 2,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundBody() {
    return Center(
      child: ClipOval(
        child: Container(
          height: 10, // height of the button
          width: 10, // width of the button
          decoration: BoxDecoration(
            color: const Color(0xFFF6C743),
            border: Border.all(
              color: const Color(0xFFAB5C26),
              width: 0.5,
              style: BorderStyle.solid,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 3,
                offset: const Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
