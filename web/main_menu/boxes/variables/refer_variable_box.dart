part of boxes;


@PolymerRegister('refer-variable-box')
class ReferVariableBox extends BoxBase {


  static ReferVariableBox createBox(program.ReferVariable m) {
    return new html.Element.tag('refer-variable-box') as ReferVariableBox
      ..model = m;
  }

  ReferVariableBox.created() : super.created();

  void attached() {
    updateNameList();
    selectName(model.name);

    PaperDropdownMenu ndd = $$('#dropdown');
    ndd.addEventListener('iron-select', onSelected);
  }

  void onSelected(var e) {
    if (e.detail != null) {
      String name_ = e.detail['item'].innerHtml;
      var pl = globalController.onInitializeApp.find(
          program.DeclareVariable, name: name_);
      if (pl.length > 0) {
        program.DeclareVariable v = pl[0];
        model.name = name_;
        if ((model as program.ReferVariable).dataType != v.dataType) {
          (model as program.ReferVariable).dataType = v.dataType;
        }
      }
    }
  }

  void updateNameList() {
    $$('#dropdown').children.clear();
    int counter = 0;
    var variables = globalController.onInitializeApp.find(program.DeclareVariable);
    if(variables == null)variables = [];
    variables.forEach((program.DeclareVariable p) {
      $$('#dropdown').children.add(new html.Element.tag('paper-item')
        ..innerHtml = p.name
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectName(String name) {
    int counter = 0;
    $$('#dropdown').children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        ($$('#dropdown') as IronSelector).attrForSelected = ('value');
        ($$('#dropdown') as IronSelector).select(counter.toString());
        return;
      }
      counter++;
    });


    print('Invalid Name is selected in assing_block');
  }



}
