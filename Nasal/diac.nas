##################################################################
####      diac.nas - ePilot                                   ####
####                                                          ####
####   Find Aircraft Checklist Menu Entry and disable         ####
####                                                          ####
##################################################################



##
# Enable/disable named menu entry
#
var diac = func {
  foreach (var menu; props.globals.getNode("/sim/menubar/default").getChildren("menu")) {
    foreach (var item; menu.getChildren("item")) {
      foreach (var name; item.getChildren("name")) {
        if (name.getValue() == "aircraft-checklists") {
          item.getNode("enabled").setBoolValue(0);
        }
        if (name.getValue() == "aircraft-keys") {
          item.getNode("enabled").setBoolValue(0);
        }

      }
    }
  }
}


setlistener("/sim/signals/fdm-initialized", diac, 0, 0);
