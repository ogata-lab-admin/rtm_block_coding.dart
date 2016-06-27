library collapse_menu;
@HtmlImport('collapse_menu.html')

import 'package:polymer/polymer.dart';
import 'dart:html' as html;
import 'package:web_components/web_components.dart' show HtmlImport;
import 'package:polymer_elements/iron_collapse.dart';

@PolymerRegister('collapse-menu')
class CollapseMenu extends PolymerElement {

  CollapseMenu.created() :  super.created();
  IronCollapse coreCollapse;

  @property String label = 'title';
  @property String state = 'opened';
  @property String toolbarOpenColor = '#f2f2f2';
  @property String toolbarCloseColor = '#ffffff';
  @property String toolbarOpenTextColor = '#b42d50';
  @property String toolbarCloseTextColor = '#212121';
  @property String toolbarDisabledColor = '#B6B6B6';
  @property String toolbarDisabledTextColor = '#565656';


  get opened => coreCollapse.opened;

  bool disabled = false;


  void disableMenu(bool flag) {
    if(flag) {
      closeCollapse(null);


      $['coreToolbar'].style.backgroundColor = toolbarDisabledColor;
      $['coreToolbar'].style.color = toolbarDisabledTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";

    } else {

      $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
      $['coreToolbar'].style.color = toolbarCloseTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";
    }
    disabled = flag;
  }

  void disableMenuItem(String id, bool flag) {
    /*
    AddElementButton btn = null;
    this.children.forEach((var e) {
      if ((e as html.HtmlElement).id == (id)) {
        btn = e;
      }
    });
    btn.setEnabled(!flag);
    */
  }

  @override
  void attached() {
    coreCollapse = $['coreCollapse'];

    if (state=='opened') {
      openCollapse(null);
    } else {
      closeCollapse(null);
    }
  }

  void openCollapse(var e) {
    if(disabled) {return;}

    if(!coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'opened';
    $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
/*    $['coreToolbar'].style.backgroundColor = transparent;
    $['coreToolbar'].style.Color =toolbarOpenColor;*/

    $['coreToolbar'].style.color = toolbarOpenTextColor;
    $['coreToolbar'].style.border = "3px groove #B6B6B6";
  }

  void closeCollapse(var e) {
    if(disabled) {return;}

    if(coreCollapse.opened) {
      coreCollapse.toggle();
    }
    state = 'closed';
    $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
    $['coreToolbar'].style.color = toolbarCloseTextColor;
    $['coreToolbar'].style.border = "1px groove #B6B6B6";

  }

  @reflectable
  void toggleCollapse(var e, var d) {
    if(disabled) {return;}

    coreCollapse.toggle();
    if (state == 'opened') {
      $['coreToolbar'].style.backgroundColor = toolbarCloseColor;
      $['coreToolbar'].style.color = toolbarCloseTextColor;
      $['coreToolbar'].style.border = "1px groove #B6B6B6";

      state = 'closed';
    } else {
      $['coreToolbar'].style.backgroundColor = toolbarOpenColor;
      $['coreToolbar'].style.color = toolbarOpenTextColor;
      $['coreToolbar'].style.border = "3px groove #B6B6B6";

      state = 'opened';
    }
  }

}