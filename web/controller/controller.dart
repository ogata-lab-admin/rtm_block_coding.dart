library controller;

import '../main_menu/editor_panel.dart';
import '../scripts/application.dart' as program;
import 'package:xml/xml.dart' as xml;
import 'package:polymer/polymer.dart';
import 'dart:html' as html;


import '../main_menu/boxes/boxes.dart';
import '../main_menu/state_panel.dart';
import '../right_menu/python_panel.dart';


import 'programbuilder.dart';

class Controller {

  ProgramBuilder programBuilder = new ProgramBuilder();

  program.Model model = new program.Model();

  EditorPanel _editorPanel;
  PythonPanel _pythonPanel;
  StatePanel _statePanel;

  /// String _mode = "on_initialize";

  set editorPanel(EditorPanel p) => _editorPanel = p;

  set pythonPanel(PythonPanel p) => _pythonPanel = p;

  set statePanel(StatePanel p) => _statePanel = p;

  BoxBase _selectedBox = null;

  BoxBase get selectedBox => _selectedBox;

  Controller() {
  }

  void setMode(String mode) {
    if (_pythonPanel != null) {
      _pythonPanel.setMode(mode);
    }
    _statePanel.setMode(mode);
  }

  String getSelectedEditorPanelName() {
    switch(_editorPanel.selected) {
      case 0:
        return 'onInitialize';
      case 1:
        return 'onActivated';
      case 2:
        return 'onExecute';
      case 3:
        return 'onDeactivated';
      default:
        return null;
    }
  }

  get selectedApp {
    switch(_editorPanel.selected) {
      case 0:
        return model.onInitializeApp;
      case 1:
        return model.onActivatedApp;
      case 2:
        return model.onExecuteApp;
      case 3:
        return model.onDeactivatedApp;
      default:
        return null;
    }
  }

  /*
  program.Application getSelectedEditorApplication() {
    switch(_editorPanel.selected) {
      case 0:
        return onInitializeApp;
      case 1:
        return onActivatedApp;
      case 2:
        return onExecuteApp;
      case 3:
        return onDeactivatedApp;
      default:
        return null;
    }
  }*/

  void setSelectedBox(BoxBase box) {
    //previousMouseEvent = event;
    if (_selectedBox != null) {
      _selectedBox.deselect();
    }
    _selectedBox = box;
    if (_selectedBox != null) {
      _selectedBox.select();
    }

    _editorPanel.onUpdateSelection();
    _pythonPanel.onUpdateSelection();
  }





  void addElement(String command) {
    print('controller.addElement($command) called');
    programBuilder.build(command);
    /*
//  variables_menu
    if (command == 'declare_variable') {
      var n = getVariableName();
      program.DeclareVariable v = new program.DeclareVariable(n, new program.DataType.fromTypeName("long"));
      program.Statement new_s = new program.Statement(v);
      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
    }

    if (command == 'refer_variable') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.ReferVariable v = new program.ReferVariable(variableList[0].name, variableList[0].dataType);
        //program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          //app.statements.add(new_s);
        } else if (selectedElement.parentElement is AssignVariableBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is AdditionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is SubtractionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is MultiplicationBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        } else if (selectedElement.parentElement is DivisionBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        }
      }
    }

    if (command == 'assign_variable') {
      var outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList == null) {outPortList = [];}
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (outPortList.length + variableList.length > 0) {
        var firstAlternative = null;
        if (variableList.length > 0) {
          firstAlternative = new program.ReferVariable(variableList[0].name, variableList[0].dataType);
        } else {
          firstAlternative = new program.OutPortBuffer(outPortList[0].name, outPortList[0].dataType, '');
        }

        program.Assign v = new program.Assign(
            firstAlternative, new program.IntegerLiteral(1));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        }
        else if (selectedStatement() is ReadInPortBox) {
          (selectedStatement() as ReadInPortBox).model.statements.add(new_s);
        } else if (selectedElement.parentElement is IfBox) {
          selectedElement.parentElement.model.statements.add(new_s);
        } else if (selectedElement.parentElement is WhileBox) {
          selectedElement.parentElement.model.yes.add(new_s);
        }
      }
    }


//  port_data_menu
    if(command == 'read_inport') {
      //var inPortMap = onInitializeApp.getInPortMap();
      var inPortList = onInitializeApp.find(program.AddInPort);
      if (inPortList.length == 0) return;

      if (selectedStatement() == null) {
          program.ReadInPort v = new program.ReadInPort(inPortList[0].name, inPortList[0].dataType);
          program.Statement new_s = new program.Statement(v);
          app.statements.add(new_s);
      }
    }

    if(command == 'inport_data') {
      List<program.AddInPort> inPortList = onInitializeApp.find(program.AddInPort);
      if (inPortList.length == 0) return;

      ///program.OutPortWrite v = new program.OutPortWrite(outPortList[0].name, outPortList[0].dataType);

      //var inPortMap = onInitializeApp.getInPortMap();
      //if (inPortMap.keys.length == 0) return;

      //var inports = globalController.inportList();
      //var defaultInPort = new program.ReadInPort(inPortList[0].name, inPortList[0].dataType);
      //if (inports.length > 0) {
      //  defaultInPort = inports[0];
      // }

      program.InPortBuffer v = new program.InPortBuffer(inPortList[0].name, inPortList[0].dataType, "");
      program.Statement new_s = new program.Statement(v);

/*      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else */
      if(selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox) .model.right = v;
      }
      else if (selectedStatement() is OutPortBufferBox) {
        (selectedStatement() as OutPortBufferBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          AssignVariableBox avb = elem.parentElement as AssignVariableBox;
          if (selectedElement.model == avb.model.right) {
            avb.model.right = v;
          } else {
            avb.model.left = v;
          }
        } else if (elem.parentElement is AdditionBox) {
          AdditionBox ab = elem.parentElement as AdditionBox;

          if (ab.model.a == elem.model) {
            ab.model.a = v;
          } else {
            ab.model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          SubtractionBox sb = elem.parentElement as SubtractionBox;
          if (sb.model.a == elem.model) {
            sb.model.a = v;
          } else {
            sb.model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          MultiplicationBox mb = elem.parentElement as MultiplicationBox;
          if (mb.model.a == elem.model) {
            mb.model.a = v;
          } else {
            mb.model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          DivisionBox db = elem.parentElement as DivisionBox;
          if (db.model.a == elem.model) {
            db.model.a = v;
          } else {
            db.model.b = v;
          }
        }
      }
    }

    if (command == 'outport_data') {
      List<program.AddOutPort> outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList == null) outPortList = [];
      if (outPortList.length == 0) return;

      //program.OutPortWrite v = new program.OutPortWrite(outPortList[0].name, outPortList[0].dataType);
      //program.AccessOutPort v = new program.AccessOutPort(outPortList[0].name, outPortList[0].dataType, '', new program.IntegerLiteral(1));
      program.OutPortBuffer v = new program.OutPortBuffer(outPortList[0].name, outPortList[0].dataType, '');


      //var outPortMap = onInitializeApp.getOutPortMap();
      //if (outPortMap.keys.length == 0) return;

      //program.OutPortData v = new program.OutPortData(outPortMap.keys.first, outPortMap[outPortMap.keys.first], '', new program.Integer(1));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        //app.statements.add(new_s);
      }
      /*
      else if (selectedStatement() is SetVariable) {
        selectedStatement().model.right = v;
      }
      */
      else if (selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox).model.left = v;
      }
      else if (selectedStatement() is ReadInPortBox) {
        (selectedStatement() as ReadInPortBox).model.statements.add(new_s);
      }
      else {
        if (selectedElement.parentElement is AssignVariableBox) {
          program.Assign a = selectedElement.parentElement.model;
          if (a.left == selectedElement.model) {
            a.left = v;
          } else {
            a.right = v;
          }
        }
      }
    }

    if(command == 'write_outport') {
      List<program.AddOutPort> outPortList = onInitializeApp.find(program.AddOutPort);
      if (outPortList.length == 0) return;

      program.WriteOutPort v = new program.WriteOutPort(outPortList[0].name, outPortList[0].dataType);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() == null) {
        app.statements.add(new_s);
      }
      else if (selectedStatement() is ReadInPortBox) {

        (selectedStatement() as ReadInPortBox).model.statements.add(new_s);
      }
    }

//  calculate_menu
    if (command == 'int_literal') {
      program.IntegerLiteral v = new program.IntegerLiteral(1);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
//        if (selectedStatement() is SetVariable) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        //PolymerElement parentElement = elem.parentElement;
        if (elem.parentElement is AssignVariableBox) {
//          if (elem.parentElement is SetVariable) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        } else if (elem.parentElement is AdditionBox) {
          if ((elem.parentElement as AdditionBox).model.a == elem.model) {
            (elem.parentElement as AdditionBox).model.a = v;
          } else {
            (elem.parentElement as AdditionBox).model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          if ((elem.parentElement as SubtractionBox).model.a == elem.model) {
            (elem.parentElement as SubtractionBox).model.a = v;
          } else {
            (elem.parentElement as SubtractionBox).model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          if ((elem.parentElement as MultiplicationBox).model.a == elem.model) {
            (elem.parentElement as MultiplicationBox).model.a = v;
          } else {
            (elem.parentElement as MultiplicationBox).model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          if ((elem.parentElement as DivisionBox).model.a == elem.model) {
            (elem.parentElement as DivisionBox).model.a = v;
          } else {
            (elem.parentElement as DivisionBox).model.b = v;
          }
        }
      }
    }

    if (command == 'real_literal') {
      program.RealLiteral v = new program.RealLiteral(1.0);
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        } else if (elem.parentElement is AdditionBox) {
          if ((elem.parentElement as AdditionBox).model.a == elem.model) {
            (elem.parentElement as AdditionBox).model.a = v;
          } else {
            (elem.parentElement as AdditionBox).model.b = v;
          }
        } else if (elem.parentElement is SubtractionBox) {
          if ((elem.parentElement as SubtractionBox).model.a == elem.model) {
            (elem.parentElement as SubtractionBox).model.a = v;
          } else {
            (elem.parentElement as SubtractionBox).model.b = v;
          }
        } else if (elem.parentElement is MultiplicationBox) {
          if ((elem.parentElement as MultiplicationBox).model.a == elem.model) {
            (elem.parentElement as MultiplicationBox).model.a = v;
          } else {
            (elem.parentElement as MultiplicationBox).model.b = v;
          }
        } else if (elem.parentElement is DivisionBox) {
          if ((elem.parentElement as DivisionBox).model.a == elem.model) {
            (elem.parentElement as DivisionBox).model.a = v;
          } else {
            (elem.parentElement as DivisionBox).model.b = v;
          }
        }
      }
    }

    if (command == 'addition') {
      program.Add v = new program.Add(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
//        if (selectedStatement() is SetVariable) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
//          if (elem.parentElement is SetVariable) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        }
      }
    }

    if (command == 'subtraction') {
      program.Subtract v = new program.Subtract(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        }
      }
    }

    if (command == 'multiplication') {
      program.Multiply v = new program.Multiply(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        }
      }
    }

    if (command == 'division') {
      program.Divide v = new program.Divide(new program.IntegerLiteral(3), new program.IntegerLiteral(2));
      program.Statement new_s = new program.Statement(v);

      if (selectedStatement() is AssignVariableBox) {
        (selectedStatement() as AssignVariableBox).model.right = v;
      }
      else {
        BoxBase elem = globalController.selectedElement;
        if (elem.parentElement is AssignVariableBox) {
          (elem.parentElement as AssignVariableBox).model.right = v;
        }
      }
    }


//  if_switch_loop_menu
    if(command =='if') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.If v = new program.If(new program.Equals(
            new program.IntegerLiteral(1), new program.IntegerLiteral(1)), new program.StatementList([new program.Statement
            (new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        //no:new program.StatementList([new program.Statement(new program.SetVariable(new program.Variable('variable1'), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        } else if (selectedStatement() is ReadInPortBox) {
          (selectedStatement() as ReadInPortBox).model.statements.add(new_s);
        } else {

        }
      }
    }

    if(command =='else') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.Else v = new program.Else(new program.StatementList([new program.Statement
            (new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        //no:new program.StatementList([new program.Statement(new program.SetVariable(new program.Variable('variable1'), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          if (app.statements.length > 0) {
            if (app.statements.last.block is program.If) {
              app.statements.add(new_s);
            }
          }
        } else if (selectedElement is IfBox) {
          var index = (selectedStatement().parent as html.DivElement).children.indexOf(selectedElement);

          if (index >= 0) {
            (selectedElement.model as program.If).parent.parent.insert(index + 1, new_s);
          }
        } else {

        }
      }
    }

    if(command =='while') {
      var variableList = onInitializeApp.find(program.DeclareVariable);
      if (variableList == null) {variableList = [];}
      if (variableList.length > 0) {
        program.While v = new program.While(new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1)), new program.StatementList([new program.Statement(
            new program.Assign(new program.ReferVariable(variableList[0].name, variableList[0].dataType), new program.IntegerLiteral(1)))]));
        program.Statement new_s = new program.Statement(v);

        if (selectedStatement() == null) {
          app.statements.add(new_s);
        }
      }
    }

//  condition_menu
    if(command == 'equals') {
      program.Equals v = new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'not_equals') {
      program.NotEquals v = new program.NotEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'larger') {
      program.LargerThan v = new program.LargerThan(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        (( selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'larger_equals') {
      program.LargerThanOrEquals v = new program.LargerThanOrEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'smaller') {
      program.SmallerThan v = new program.SmallerThan(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'smaller_equals') {
      program.SmallerThanOrEquals v = new program.SmallerThanOrEquals(new program.IntegerLiteral(1), new program.IntegerLiteral(1));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }

    if(command == 'logical_not') {
      program.Not v = new program.Not(new program.Equals(new program.IntegerLiteral(1), new program.IntegerLiteral(1)));
      program.Statement new_s = new program.Statement(v);

      if(selectedStatement() == null) {

      } else if(selectedElement is IfBox) {
        (selectedStatement() as IfBox).model.condition = v;
      } else if(selectedElement.parentElement is IfBox) {
        ((selectedStatement() as BoxBase).parentElement as IfBox).model.condition = v;
      } else if(selectedElement is WhileBox) {
        (selectedStatement() as WhileBox).model.condition = v;
      } else if(selectedElement.parentElement is WhileBox) {
        ((selectedStatement() as BoxBase).parentElement as WhileBox).model.condition = v;
      }
    }
*/
    refreshPanel();
  }



  void refreshAllPanel({String except: ''}) {
    if (except != 'onInitialize') {
      _editorPanel.onInitializeEditor.refresh(model.onInitializeApp);
    }
    if (except != 'onActivated') {
      _editorPanel.onActivatedEditor.refresh(model.onActivatedApp);
    }
    if (except != 'onDeactivated') {
        _editorPanel.onDeactivatedEditor.refresh(model.onDeactivatedApp);
    }
    if (except != 'onExecute') {
        _editorPanel.onExecuteEditor.refresh(model.onExecuteApp);
    }

    _pythonPanel.onUpdateSelection();
    _statePanel.showRTCImage(model.getRTCProfile());
  }


  void refreshPanel() {
    /*
    program.Application app;
    switch (_editorPanel.selected) {
      case 0:
        app = onInitializeApp;
        break;
      case 1:
        app = onActivatedApp;
        break;
      case 2:
        app = onExecuteApp;
        break;
      case 3:
        app = onDeactivatedApp;
        break;
    }
    */
    _editorPanel.refresh();
    _pythonPanel.onUpdateSelection();
    _statePanel.showRTCImage(model.getRTCProfile());
  }

}

Controller globalController = new Controller();