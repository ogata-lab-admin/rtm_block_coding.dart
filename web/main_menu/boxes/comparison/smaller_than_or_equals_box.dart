part of boxes;

@PolymerRegister('smaller-than-or-equals-box')
class SmallerThanOrEqualsBox extends ComparisonBox {


  static SmallerThanOrEqualsBox createBox(program.SmallerThanOrEquals m) {
    return new html.Element.tag('smaller-than-or-equals-box') as SmallerThanOrEqualsBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  SmallerThanOrEqualsBox.created() : super.created();

}

