library boxes;


@HtmlImport('boxes.html')
import 'dart:html' as html;
import 'dart:async' as async;
import 'dart:mirrors';

import 'package:polymer/polymer.dart';
import 'package:web_components/web_components.dart' show HtmlImport;

import 'package:polymer_elements/paper_item.dart';
import 'package:polymer_elements/paper_input.dart';
import 'package:polymer_elements/paper_dropdown_menu.dart';
import 'package:polymer_elements/iron_selector.dart';

import '../../scripts/application.dart' as program;
import '../../controller/controller.dart';

part 'box_base.dart';

part 'box_factory.dart';
part 'box_factory_impl.dart';

part 'flow_control/if_box.dart';
part 'flow_control/while_box.dart';
part 'flow_control/else_box.dart';

part 'literal/integer_literal_box.dart';
part 'literal/bool_literal_box.dart';
part 'literal/real_literal_box.dart';

part 'dataports/data_port_box.dart';
part 'dataports/inport_buffer_box.dart';
part 'dataports/is_new_inport_box.dart';
part 'dataports/outport_buffer_box.dart';
part 'dataports/read_inport_box.dart';
part 'dataports/write_outport_box.dart';

part 'rtm/add_port_box.dart';
part 'rtm/add_inport_box.dart';
part 'rtm/add_outport_box.dart';

part 'variables/declare_variable_box.dart';
part 'variables/assign_box.dart';
part 'variables/refer_variable_box.dart';

part 'calculation/calculation_box.dart';
part 'calculation/add_box.dart';
part 'calculation/subtract_box.dart';
part 'calculation/multiply_box.dart';
part 'calculation/divide_box.dart';


part 'comparison/comparison_box.dart';
part 'comparison/equals_box.dart';
part 'comparison/notequals_box.dart';
part 'comparison/smaller_than_or_equals_box.dart';
part 'comparison/smaller_than_box.dart';
part 'comparison/larger_than_or_equals_box.dart';
part 'comparison/larger_than_box.dart';