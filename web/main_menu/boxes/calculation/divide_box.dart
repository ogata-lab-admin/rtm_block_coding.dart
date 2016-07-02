part of boxes;

@PolymerRegister('divide-box')
class DivideBox extends CalculationBox {

  static DivideBox createBox(program.Divide divideBlock) {
    return (new html.Element.tag('divide-box') as DivideBox)
      ..model = divideBlock
      ..attachLeft(BoxFactory.parseBlock(divideBlock.a))
      ..attachRight(BoxFactory.parseBlock(divideBlock.b));
  }

  DivideBox.created() : super.created();
}