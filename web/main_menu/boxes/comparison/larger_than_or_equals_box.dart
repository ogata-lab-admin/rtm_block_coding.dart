part of boxes;

@PolymerRegister('larger-than-or-equals-box')
class LargerThanOrEqualsBox extends ComparisonBox {


  static LargerThanOrEqualsBox createBox(program.LargerThanOrEquals m) {
    return new html.Element.tag('larger-than-or-equals-box') as LargerThanOrEqualsBox
      ..model = m
      ..attachLeft(BoxFactory.parseBlock(m.left))
      ..attachRight(BoxFactory.parseBlock(m.right));
  }

  LargerThanOrEqualsBox.created() : super.created();

}

