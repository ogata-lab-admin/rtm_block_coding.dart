part of application;


class Model {

  Block createBlock(String command) {

    MirrorSystem mirrors = currentMirrorSystem();
    mirrors.libraries.forEach((var uri, var lib) {
      print ('$uri, $lib');
    });
    LibraryMirror appMirror = mirrors.findLibrary(new Symbol('application'));
    ClassMirror cm = appMirror.declarations[new Symbol(command)];
    return cm.newInstance(new Symbol('fromAppDefault'), [this]).reflectee;
  }

  Model() {

  }

  /// アプリケーション
  Application onInitializeApp = new Application();
  Application onActivatedApp = new Application();
  Application onExecuteApp = new Application();
  Application onDeactivatedApp = new Application();

  List<dynamic> findFromAllApp(Type t, String name) {
    List<dynamic> ps = [];
    ps.addAll(onExecuteApp.find(t, name: name));
    ps.addAll(onActivatedApp.find(t, name: name));
    ps.addAll(onDeactivatedApp.find(t, name: name));
    return ps;
  }

  String pythonCode({bool pure: false}) {

    var dec = onInitializeApp.toDeclarePython(2);
    //dec += onActivatedApp.toDeclarePython(2);
    //dec += onExecuteApp.toDeclarePython(2);
    //dec += onDeactivatedApp.toDeclarePython(2);

    var bin = onInitializeApp.toBindPython(2);
    //bin += onActivatedApp.toBindPython(2);
    //bin += onExecuteApp.toBindPython(2);
    //bin += onDeactivatedApp.toBindPython(2);

    var a = onActivatedApp.toPython(2);

    var e = onExecuteApp.toPython(2);

    var d = onDeactivatedApp.toPython(2);

    div(var id) {
      if (!pure) {
        return '<div id="$id">';
      }
      return '';
    }

    vid() {
      if (!pure) {
        return '</div>';
      }
      return '';
    }
    final string = """
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- Python -*-

import sys, time, traceback
sys.path.append(".")

# Import RTM module
import RTC
import OpenRTM_aist

block_rtc_spec = ["implementation_id", "BlockRTC",
    "type_name",         "BlockRTC",
    "description",       "RTM Block Coding Component",
    "version",           "1.0.0",
    "vendor",            "Ogata Lab Waseda Univ.",
    "category",          "Education",
    "activity_type",     "STATIC",
    "max_instance",      "1",
    "language",          "Python",
    "lang_type",         "SCRIPT",

    "conf.default.debug", "1",

    "conf.__widget__.debug", "text",

    ""]

class BlockRTC(OpenRTM_aist.DataFlowComponentBase):

  ${div('constructor')}
  def __init__(self, manager):
    OpenRTM_aist.DataFlowComponentBase.__init__(self, manager)
${dec}
    self._debug = [1]
  ${vid()}
  ${div("on-initialize-block")}
  def onInitialize(self):
    self.bindParameter("debug", self._debug, "1")
${bin}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-activated-block")}
  def onActivated(self, ec_id):
${a}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-deactivated-block")}
  def onDeactivated(self, ec_id):
${d}
    return RTC.RTC_OK
  ${vid()}
  ${div("on-execute-block")}
  def onExecute(self, ec_id):
${e}
    return RTC.RTC_OK
  ${vid()}

def BlockRTCInit(manager):
  profile = OpenRTM_aist.Properties(defaults_str=block_rtc_spec)
  manager.registerFactory(profile,
                          BlockRTC,
                          OpenRTM_aist.Delete)

def MyModuleInit(manager):
  BlockRTCInit(manager)
  comp = manager.createComponent("BlockRTC")

def main():
  mgr = OpenRTM_aist.Manager.init(sys.argv)
  mgr.setModuleInitProc(MyModuleInit)
  mgr.activateManager()
  mgr.runManager()

if __name__ == "__main__":
  main()


    """;
    return string;
  }


  List<ReadInPort> inportList() {
    var inports = [];
    var f = (var block) {
      if (block is ReadInPort) {
        inports.add(block);
      }
    };

    onActivatedApp.iterateBlock(f);
    onDeactivatedApp.iterateBlock(f);
    onExecuteApp.iterateBlock(f);

    return inports;
  }

  xml.XmlDocument buildXML() {
    xml.XmlBuilder builder = new xml.XmlBuilder();
    builder.processing(
        'xml', 'version="1.0" encoding="UTF-8" standalone="yes"');
    builder.element('RTMBlockCoding',
        attributes: {
        },
        nest: () {
          builder.element('onInitializeApp',
              nest : () {
                onInitializeApp.buildXML(builder: builder);
              });
          builder.element('onActivatedApp',
              nest : () {
                onActivatedApp.buildXML(builder: builder);
              });

          builder.element('onDeactivatedApp',
              nest : () {
                onDeactivatedApp.buildXML(builder: builder);
              });

          builder.element('onExecuteApp',
              nest : () {
                onExecuteApp.buildXML(builder: builder);
              });
        }

    );

    return builder.build();
  }

  void loadFromXML(xml.XmlDocument doc) {
    doc.children.forEach((xml.XmlNode node) {
      if (node is xml.XmlElement) {
        if (node.name.toString() == 'RTMBlockCoding') {
          node.children.forEach((xml.XmlNode childNode) {
            if (childNode is xml.XmlElement) {
              if (childNode.name.toString() == 'onInitializeApp') {
                childNode.children.forEach((xml.XmlNode gChildNode) {
                  if (Application.isClassXmlNode(gChildNode)) {
                    onInitializeApp.loadFromXML(gChildNode);
                  }
                });
              } else if (childNode.name.toString() == 'onActivatedApp') {
                childNode.children.forEach((xml.XmlNode gChildNode) {
                  if (Application.isClassXmlNode(gChildNode)) {
                    onActivatedApp.loadFromXML(gChildNode);
                  }
                });
//                  onActivatedApp.loadFromXML(childNode);
              } else if (childNode.name.toString() == 'onDeactivatedApp') {
                onDeactivatedApp.loadFromXML(childNode);
              } else if (childNode.name.toString() == 'onExecuteApp') {
                onExecuteApp.loadFromXML(childNode);
              }
            }
          });
        }
      }
    });
  }



  RTCProfile getRTCProfile() {
    var rtcp = new RTCProfile();
    List<AddInPort> inPortList = onInitializeApp.find(AddInPort);
    if (inPortList != null) {
      inPortList.forEach((AddInPort ip) {
        rtcp.addDataPorts(
            new DataPorts.InPort(name: ip.name, type: ip.dataType.typename));
      });
    }


    List<AddOutPort> outPortList = onInitializeApp.find(AddOutPort);
    if (outPortList != null) {
      outPortList.forEach((AddOutPort ip) {
        rtcp.addDataPorts(
            new DataPorts.OutPort(name: ip.name, type: ip.dataType.typename));
      });
    }
    return rtcp;

  }

}