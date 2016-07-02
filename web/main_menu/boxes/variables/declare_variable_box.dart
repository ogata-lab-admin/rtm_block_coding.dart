part of boxes;

@PolymerRegister('declare-variable-box')
class DeclareVariableBox extends BoxBase {


  static DeclareVariableBox createBox(program.DeclareVariable m) {
    return new html.Element.tag('declare-variable-box') as DeclareVariableBox
      ..model = m
      ..set('varname', m.name)
      ..set('vartype', m.dataType.typename);
  }

  @property String varname = "defaultName";
  @property String vartype = "defaultType";

  DeclareVariableBox.created() : super.created();

  void attached() {

    var types = program.DataType.PrimitiveTypes;
    types.sort();
    int counter = 0;
    types.forEach((String typename) {
      $$('#dropdown').children.add(new html.Element.tag('paper-item')
        ..innerHtml = typename
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectType((model as program.DeclareVariable).dataType.typename);
    $$('#dropdown').addEventListener('iron-select', onIronSelect);
  }

  void onIronSelect(var e) {
    if (e.detail != null) {
      String typename = e.detail['item'].innerHtml;
      onTypeChange(typename);
    }
  }

  @reflectable
  void onInputName(var e, var d) {
    onNameChange(varname);
  }

  void selectType(String name) {
    int counter = 0;
    $$('#dropdown').children.forEach((PaperItem p) {
      if (name == p.innerHtml) {
        ($$('#dropdown') as IronSelector).attrForSelected = ('value');
        ($$('#dropdown') as IronSelector).select(counter.toString());
        return;
      }
      counter++;
    });

    print('Invalid InPort is selected in inport_data');

  }

  void onNameChange(String new_name) {
    String old_name = model.name;
    globalController.findFromAllApp(program.DeclareVariable, old_name).forEach((
        program.DeclareVariable v) {
      v.name = new_name;
    });

    globalController.findFromAllApp(program.ReferVariable, old_name).forEach((
        program.ReferVariable v) {
      v.name = new_name;
    });

    model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }

  void onTypeChange(String typename) {
    (model as program.DeclareVariable).dataType = new program.DataType.fromTypeName(typename);

    String old_name = model.name;
    globalController.findFromAllApp(program.DeclareVariable, old_name).forEach((
        program.DeclareVariable v) {
      v.dataType = (model as program.DeclareVariable).dataType;
    });

    globalController.findFromAllApp(program.ReferVariable, old_name).forEach((
        program.ReferVariable v) {
      v.dataType = (model as program.DeclareVariable).dataType;
    });

   /// model.name = new_name;
    globalController.refreshAllPanel(except: 'onInitialize');
  }



}