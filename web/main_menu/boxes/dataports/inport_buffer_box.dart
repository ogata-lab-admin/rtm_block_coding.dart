library inport_buffer_box;

@HtmlImport('inport_buffer_box.html')
import 'dart:html' as html;
import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import '../../../scripts/application.dart' as program;
import '../../../controller/controller.dart';
import '../box_base.dart';
import 'data_port_box.dart';

@PolymerRegister('inport-buffer-box')
class InPortBufferBox extends BoxBase {

  static InPortBufferBox createBox(program.InPortBuffer m) {
    return new html.Element.tag('inport-buffer-box') as InPortBufferBox
      ..model = m;
  }

  InPortBufferBox.created() : super.created();

  @property String indexInputValue = '0';

  TypedDataSelector dataSelector;

  void attached() {
    dataSelector = $$('#data-selector');
    dataSelector.updatePortList(program.AddInPort);
    dataSelector.selectPort(model.name);
    dataSelector.selectAccess((model as program.InPortBuffer).dataType,
        (model as program.InPortBuffer).accessSequence);

    dataSelector.onSelectPort.listen((program.AddInPort p) {
      model.name = p.name;
      if ((model as program.InPortBuffer).dataType.typename !=
          p.dataType.typename) {
        (model as program.OutPortBuffer).dataType = p.dataType;
        dataSelector.updateAccessAlternatives(p.dataType);
        (model as program.OutPortBuffer).accessSequence = '';
        dataSelector.selectAccess((model as program.InPortBuffer).dataType,
            (model as program.InPortBuffer).accessSequence);
      }
    });

    dataSelector.onSelectAccessor.listen((String str) {
      (model as program.InPortBuffer).accessSequence = str;
      dataSelector.updateIndexer(
          (model as program.InPortBuffer).dataType, str);
    });

    dataSelector.onSelectIndex.listen((String str) {
      if (str
          .trim()
          .length > 0) {
        var accessor = (model as program.InPortBuffer).accessSequence;
        if (accessor.endsWith(']')) {
          accessor = accessor.substring(0, accessor.indexOf('['));
        }
        (model as program.InPortBuffer).accessSequence = accessor + '[$str]';
        //dataSelector.updateIndexer((model as program.OutPortBuffer).dataType, str);
      } else {
        var accessor = (model as program.InPortBuffer).accessSequence;
        if (accessor.endsWith(']')) {
          accessor = accessor.substring(0, accessor.indexOf('['));
        }
        (model as program.InPortBuffer).accessSequence = accessor;
      }
    });
  }
}
