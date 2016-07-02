part of boxes;

@PolymerRegister('real-literal-box')
class RealLiteralBox extends BoxBase {

  static RealLiteralBox createBox(program.RealLiteral m) {
    return new html.Element.tag('real-literal-box') as RealLiteralBox
      ..model = m
      ..realvalue = m.value
      ..set('realvarstr', m.value.toString());
  }

  double realvalue = 0.0;
  @property String realvarstr;

  RealLiteralBox.created() : super.created();

  @reflectable
  void onInputValue(var e, var d) {
    realvalue = double.parse(realvarstr);
    (model as program.RealLiteral).value = realvalue;
  }

  void attached() {
  }

}
