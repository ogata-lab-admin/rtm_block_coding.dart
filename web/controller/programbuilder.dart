library programbuilder;

import '../scripts/application.dart';
import 'controller.dart';
import 'dart:mirrors';
import '../main_menu/boxes/boxes.dart';

class ProgramBuilder {


  ProgramBuilder() {}


  void addToApp(Application selectedApp, Block selectedBlock, Block b) {

    var s = new Statement(b);
    if (b is Condition) {
      if (selectedBlock == null) {
        return;
      }

      if(selectedBlock.parent is ConditionalFlowControl) {
        selectedBlock.parent.condition = b;
      }
    } else {
      if (selectedBlock == null) {
        selectedApp.statements.add(s);
      } else if (selectedBlock is ContainerBlock) {
        selectedBlock.statements.add(s);
      } else if (selectedBlock.parent is BasicOperator) {
        if (selectedBlock.parent.isLeft(selectedBlock)) {
          selectedBlock.parent.left = b;
        } else {
          selectedBlock.parent.right = b;
        }
      } else {
        selectedApp.statements.add(s);
      }
    }
  }

  void build(Model model, Application selectedApp, Block selectedBlock, String command) {
    print('ProgramBuilder.build($command)');

    MirrorSystem mirrors = currentMirrorSystem();
    mirrors.libraries.forEach((var uri, var lib) {
      print ('$uri, $lib');
    });
    LibraryMirror appMirror = mirrors.findLibrary(new Symbol('application'));
    ClassMirror cm = appMirror.declarations[new Symbol(command)];
    addToApp(selectedApp, selectedBlock, cm.newInstance(new Symbol('fromAppDefault'), [model]).reflectee);

  }


}






