part of boxes;

@PolymerRegister('larger-than-box')
class LargerThanBox extends ComparisonBox {

  static LargerThanBox createBox(program.LargerThan m) {
    return new html.Element.tag('larger-than-box') as LargerThanBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  LargerThanBox.created() : super.created();
}

