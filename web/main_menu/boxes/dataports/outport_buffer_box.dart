part of boxes;


@PolymerRegister('outport-buffer-box')
class OutPortBufferBox extends BoxBase {

  static OutPortBufferBox createBox(program.OutPortBuffer m) {
    return new html.Element.tag('outport-buffer-box') as OutPortBufferBox
    ..model = m;
  }

  @property String indexInputValue = '0';

  OutPortBufferBox.created() : super.created();

  TypedDataSelector dataSelector;

  void attached() {
    dataSelector = $$('#data-selector');
    dataSelector.updatePortList(program.AddOutPort);
    dataSelector.selectPort(model.name);
    dataSelector.selectAccess((model as program.OutPortBuffer).dataType, (model as program.OutPortBuffer).accessSequence);

    dataSelector.onSelectPort.listen((program.AddOutPort p) {
      model.name = p.name;
      if ((model as program.OutPortBuffer).dataType.typename != p.dataType.typename) {
        (model as program.OutPortBuffer).dataType = p.dataType;
        dataSelector.updateAccessAlternatives(p.dataType);
        (model as program.OutPortBuffer).accessSequence = '';
        dataSelector.selectAccess((model as program.OutPortBuffer).dataType, (model as program.OutPortBuffer).accessSequence);
      }
    });

    dataSelector.onSelectAccessor.listen((String str) {
      (model as program.OutPortBuffer).accessSequence = str;
      dataSelector.updateIndexer((model as program.OutPortBuffer).dataType, str);
    });

    dataSelector.onSelectIndex.listen((String str) {
      if (str.trim().length > 0) {
        var accessor = (model as program.OutPortBuffer).accessSequence;
        if (accessor.endsWith(']')) {
          accessor = accessor.substring(0, accessor.indexOf('['));
        }
        (model as program.OutPortBuffer).accessSequence = accessor + '[$str]';
        //dataSelector.updateIndexer((model as program.OutPortBuffer).dataType, str);
      } else {
        var accessor = (model as program.OutPortBuffer).accessSequence;
        if (accessor.endsWith(']')) {
          accessor = accessor.substring(0, accessor.indexOf('['));
        }
        (model as program.OutPortBuffer).accessSequence = accessor;
      }
    });
  }

}
