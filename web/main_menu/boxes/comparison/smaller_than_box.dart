part of boxes;

@PolymerRegister('smaller-than-box')
class SmallerThanBox extends ComparisonBox {

  static SmallerThanBox createBox(program.SmallerThan m) {
    return new html.Element.tag('smaller-than-box') as SmallerThanBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  SmallerThanBox.created() : super.created();

}

