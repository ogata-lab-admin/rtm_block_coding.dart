library read_inport_box;

@HtmlImport('data_port_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'dart:async' as async;
import '../../../scripts/application.dart' as program;
import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_input.dart';
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

  String get selectedName {
    return (($$('#dropdown') as IronSelector).selectedItem as PaperItem).innerHtml;
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
  Type _type;

  async.StreamController<program.AddPort> _onSelectPort = new async.StreamController<program.AddPort>();
  async.Stream get onSelectPort => _onSelectPort.stream.asBroadcastStream();



  async.StreamController<String> _onSelectAccessor = new async.StreamController<String>();
  async.Stream get onSelectAccessor => _onSelectAccessor.stream.asBroadcastStream();


  async.StreamController<String> _onSelectIndex = new async.StreamController<String>();
  async.Stream get onSelectIndex => _onSelectIndex.stream.asBroadcastStream();

  PortSelector _portSelector;


  IronSelector accessDropDown;
  @property String indexInputValue;


  int _numPaperItem = 50;

  void attached() {
    var add = $$('#access-dropdown');
    for (int i = 0; i < _numPaperItem; i++) {
      add.children.add(new html.Element.tag('paper-item')
        .. innerHtml = i.toString()
        ..setAttribute('value', i.toString())
        ..style.display = 'none');
    }

    _portSelector = $$('#port-selector');
    if (_type != null) {
      updatePortList(_type);
    }

    if (_selectedName != null) {
      selectPort(_selectedName);
    }

    _portSelector.onSelect.listen((var e) {
      _onSelectPort.add(e);
    });


    add.removeEventListener('iron-select', onIronSelected);
    ($$('#access-dropdown') as IronSelector).attrForSelected = ('value');
    ($$('#access-dropdown') as IronSelector).addEventListener(
        'iron-select', onIronSelected);
    ($$('#access-dropdown-menu') as PaperDropdownMenu).alwaysFloatLabel = true;


    ($$('#index-input') as PaperInput).alwaysFloatLabel = true;
  }

  void onIronSelected(var e) {
    if (e.detail != null) {
      String accessor_ = e.detail['item'].innerHtml.trim();
      _onSelectAccessor.add(accessor_);

    }
  }

  void updateAccessAlternatives(program.DataType dataType, {String access : ''}) {
    var add = $$('#access-dropdown');

    int counter = 0;
    List<List<String>> accesses = program.DataType.access_alternatives(dataType.typename);
    for(counter = 0;counter < accesses.length;counter++) {
      add.children[counter].innerHtml = accesses[counter][0] + ' ';
      add.children[counter].style.display = 'block';
    }

    for(int i = counter;i < _numPaperItem;i++) {
      add.children[i].style.display = 'none';
    }

    selectAccess(dataType, access + ' ');

    /*
    ($$('#access-dropdown') as IronSelector).attrForSelected = ('value');
    ($$('#access-dropdown') as IronSelector).addEventListener('iron-select', onIronSelected);
    ($$('#access-dropdown-menu') as PaperDropdownMenu).alwaysFloatLabel = true;
    */
  }


  void updatePortList(Type type) {
    _type = type;
    if (_portSelector != null) {
      _portSelector.updatePortList(type);
    }
  }

  void selectPort(String name, {String access : ''}) {
    _selectedName = name;
    if (_portSelector != null) {
      _portSelector.selectPort(name);

      var pl = globalController.onInitializeApp.find(
          _type, name: name);
      if (pl.length > 0) {
        updateAccessAlternatives(pl[0].dataType, access: access);
      }
    }
  }

  void updateIndexer(program.DataType dataType, String accessor) {

    indexInputValue = '';

    if (accessor.endsWith(']')) {
      String accessor_ = accessor;
      accessor = accessor_.substring(0, accessor_.indexOf('[')).trim();
      indexInputValue = accessor_.substring(accessor_.indexOf('[')+1, accessor_.indexOf(']'));
    }

    String accessTypeName = program.DataType.access_alternative_type(dataType.typename, accessor);
    if (program.DataType.isSeqType(accessTypeName)) {
      $['index-left'].style.display = 'block';
      $['index-input'].style.display = 'block';
      $['index-right'].style.display = 'block';
      if (indexInputValue.length == 0) {
        indexInputValue = '';
      }
    } else {
      $['index-left'].style.display = 'none';
      $['index-input'].style.display = 'none';
      $['index-right'].style.display = 'none';

    }
    set('indexInputValue', indexInputValue);
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

  get selectedName => _portSelector.selectedName;

  get selectedAccessor => (($$('#access-dropdown') as IronSelector).selectedItem as PaperItem).innerHtml;

  get selectedIndex => indexInputValue;

  @reflectable
  void onInputIndex(var e, var d) {

    var pl = globalController.onInitializeApp.find(
        _type, name: selectedName);

    if (pl.length > 0) {

      program.DataType dataType = pl[0].dataType;
      String accessTypeName = program.DataType.access_alternative_type(dataType.typename, selectedAccessor);
      if (program.DataType.isSeqType(accessTypeName)) {
        _onSelectIndex.add(indexInputValue);
      }
    }
  }


  /*
    String accessTypeName = program.DataType.access_alternative_type(_type.typename, accessor);
    if (program.DataType.isSeqType(accessTypeName)) {

    program.DataType.isSeqType()
    if (_model.accessSequence.endsWith(']')) {
      _model.accessSequence =
          _model.accessSequence.substring(
              0, _model.accessSequence.indexOf('['));
    }
    String accessTypeName = program.DataType.access_alternative_type(_model.dataType.typename, _model.accessSequence);
    if(program.DataType.isSeqType(accessTypeName)) {
      if (indexInputValue.trim().length > 0) {
        _model.accessSequence = _model.accessSequence + '[' + indexInputValue + ']';
      }
    }
  }
  */

}