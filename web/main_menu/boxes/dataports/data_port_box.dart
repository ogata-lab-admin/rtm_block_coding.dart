library read_inport_box;

@HtmlImport('data_port_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:async' as async;
import '../../../scripts/application.dart' as program;
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/iron_selector.dart';
import '../../../controller/controller.dart';
import '../box_base.dart';


@PolymerRegister('port-selector')
class PortSelector extends PolymerElement {
  PortSelector.created() : super.created();

  Type dataType;

  async.StreamController<program.AddPort> _onSelect = new async.StreamController<program.AddPort>();
  async.Stream get onSelect => _onSelect.stream.asBroadcastStream();


  void attached() {
    $$('#dropdown-menu').addEventListener('iron-select', onIronSelected);
  }

  void onIronSelected(var e) {
    if (e.detail != null) {
      String name_ = e.detail['item'].innerHtml;
      var pl = globalController.onInitializeApp.find(
          dataType, name: name_);
      if (pl.length > 0) {
        var port = pl[0];
        _onSelect.add(pl[0]);
      }
    }
  }

  void updatePortList(Type type) {
    dataType = type;
    $$('#dropdown').children.clear();

    int counter = 0;
    var ports = globalController.onInitializeApp.find(type);
    ports.forEach((var p) {
      $$('#dropdown').children.add(
          new html.Element.tag('paper-item')
            ..innerHtml = p.name
            ..setAttribute('value', counter.toString())
      );
      counter++;
    });
  }

  void selectPort(String name) {
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


}


@PolymerRegister('typed-data-selector')
class TypedDataSelector extends PolymerElement {

  TypedDataSelector.created() : super.created();

  String _selectedName;
  Type dataType;

  async.StreamController<program.AddPort> _onSelectPort = new async.StreamController<program.AddPort>();
  async.Stream get onSelectPort => _onSelectPort.stream.asBroadcastStream();



  async.StreamController<String> _onSelectAccessor = new async.StreamController<String>();
  async.Stream get onSelectAccessor => _onSelectAccessor.stream.asBroadcastStream();


  PortSelector _portSelector;


  IronSelector accessDropDown;
  @property String indexInputValue;

  void attached() {
    _portSelector = $$('#port-selector');
    if (dataType != null) {
      updatePortList(dataType);
    }

    if (_selectedName != null) {
      selectPort(_selectedName);
    }

    _portSelector.onSelect.listen((var e) {
      _onSelectPort.add(e);
    });

    ($$('#access-dropdown') as IronSelector).addEventListener('iron-select', onIronSelected);
    ($$('#access-dropdown-menu') as PaperDropdownMenu).alwaysFloatLabel = true;
  }

  void onIronSelected(var e) {
    if (e.detail != null) {
      String accessor_ = e.detail['item'].innerHtml.trim();
      _onSelectAccessor.add(accessor_);

    }
  }

  void updateAccessAlternatives(program.DataType dataType, {String access : ''}) {
    var add = $$('#access-dropdown');
    add.children.clear();
    int counter = 0;
    List<List<String>> accesses = program.DataType.access_alternatives(dataType.typename);
    accesses.forEach((List<String> alternative_pair) {
      add.children.add(new html.Element.tag('paper-item')
        ..innerHtml = alternative_pair[0] + ' '
        ..setAttribute('value', counter.toString())
      );
      counter++;
    });

    selectAccess(dataType, access + ' ');

    ($$('#access-dropdown') as IronSelector).attrForSelected = ('value');
    ($$('#access-dropdown') as IronSelector).addEventListener('iron-select', onIronSelected);
    ($$('#access-dropdown-menu') as PaperDropdownMenu).alwaysFloatLabel = true;
  }


  void updatePortList(Type type) {
    dataType = type;
    if (_portSelector != null) {
      _portSelector.updatePortList(type);
    }
  }

  void selectPort(String name, {String access : ''}) {
    _selectedName = name;
    if (_portSelector != null) {
      _portSelector.selectPort(name);

      var pl = globalController.onInitializeApp.find(
          dataType, name: name);
      if (pl.length > 0) {
        updateAccessAlternatives(pl[0].dataType, access: access);
      }
    }
  }

  void updateIndexer(program.DataType dataType, String accessor) {
    String accessTypeName = program.DataType.access_alternative_type(dataType.typename, accessor);
    if (program.DataType.isSeqType(accessTypeName)) {
      $['index-left'].style.display = 'block';
      $['index-input'].style.display = 'block';
      $['index-right'].style.display = 'block';
    } else {
      $['index-left'].style.display = 'none';
      $['index-input'].style.display = 'none';
      $['index-right'].style.display = 'none';
    }
  }

  void selectAccess(program.DataType dataType, String accessName) {
    var add = $$('#access-dropdown');

    accessName = accessName.trim();
    var plainAccessor = accessName;
    if (accessName.endsWith(']')) {
      plainAccessor = plainAccessor.substring(0, accessName.indexOf('[')).trim();
      indexInputValue = accessName.substring(accessName.indexOf('[')+1, accessName.indexOf(']'));
    } else {
      indexInputValue = ' ';
    }

    int counter = 0;
    add.children.forEach((PaperItem p) {
      var target_name = p.innerHtml;
      if (p.innerHtml.startsWith('.')) {
        target_name = p.innerHtml.substring(1).trim();
      }
      if (plainAccessor + " " == target_name) {
        updateIndexer(dataType, plainAccessor);
        ($$('#access-dropdown') as IronSelector).attrForSelected = ('value');
        ($$('#access-dropdown') as IronSelector).select(counter.toString());
      }
      counter++;
    });
    print('Invalid OutPort Access is selected in outport_data');
  }
}