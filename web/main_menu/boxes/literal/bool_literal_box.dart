part of boxes;

@PolymerRegister('bool-literal-box')
class BoolLiteralBox extends BoxBase {

  static BoolLiteralBox createBox(program.BoolLiteral m) {
    return new html.Element.tag('bool-literal-box') as BoolLiteralBox
      ..model = m;//
       // ..selectBool(m.value);
  }

  BoolLiteralBox.created() : super.created();

  void attached() {
    selectBool((model as program.BoolLiteral).value);
    $$('#dropdown').addEventListener('iron-select', (var e) {
      (model as program.BoolLiteral).value = e.detail['item'].innerHtml.toString().indexOf('True') > 0;
    });
  }

  void selectBool(bool flag) {
    if (flag) {
      ($$('#dropdown') as IronSelector).select('0');
    } else {
      ($$('#dropdown') as IronSelector).select('1');
    }
  }
}
