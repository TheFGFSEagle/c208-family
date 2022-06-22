##################################################################
####      dctc.nas - ePilot                                   ####
####                                                          ####
####    Find Tutorial Menu Entry and disable                  ####
####                                                          ####
##################################################################


##
# Enable/disable named menu entry
#
var dctc = func {
    foreach (var menu; props.globals.getNode("/sim/menubar/default").getChildren("menu")) {
        foreach (var name; menu.getChildren("name")) {
            if (name.getValue() == "tutorial-start") {
                menu.getNode("enabled").setBoolValue(0);
            }
        }
        foreach (var item; menu.getChildren("item")) {
            foreach (var name; item.getChildren("name")) {
                if (name.getValue() == "tutorial-start") {
                    item.getNode("enabled").setBoolValue(0);
                }
            }
        }
    }
}
setlistener("/sim/signals/fdm-initialized", dctc, 0, 0);

