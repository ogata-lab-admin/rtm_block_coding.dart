part of boxes;

@PolymerRegister('integer-literal-box')
class IntegerLiteralBox extends BoxBase {

  static IntegerLiteralBox createBox(program.IntegerLiteral m) {
    return new html.Element.tag('integer-literal-box') as IntegerLiteralBox
      ..model = m
      ..intvalue = m.value
      ..set('intvarstr', m.value.toString());
  }

  int intvalue = 1;
  @property String intvarstr;

  IntegerLiteralBox.created() : super.created();

  @reflectable
  void onInputValue(var e, var d) {
    intvalue = int.parse(intvarstr);
    (model as program.IntegerLiteral).value = intvalue;
  }

  void attached() {

  }

}
