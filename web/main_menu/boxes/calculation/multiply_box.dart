part of boxes;

@PolymerRegister('multiply-box')
class MultiplyBox extends CalculationBox {

  static MultiplyBox createBox(program.Multiply multiplyBlock) {
    return (new html.Element.tag('multiply-box') as MultiplyBox)
      ..model = multiplyBlock
      ..attachLeft(BoxFactory.parseBlock(multiplyBlock.a))
      ..attachRight(BoxFactory.parseBlock(multiplyBlock.b));
  }


  MultiplyBox.created() : super.created();

}