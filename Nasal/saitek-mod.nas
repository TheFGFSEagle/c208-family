##################################################################
####      saitek-mod.nas - ePilot                             ####
####                                                          ####
####    Overwrite improper Saitek xml thrust                  ####
####    reverse implementation                                ####
####                                                          ####
####  Fixme: Only execute if Saitek quadrant detected         ####
####  otherwise we might accidentally overwrite some other    ####
####  joy config that has 20+ buttons                         ####
##################################################################


var fix_saitek_xml = func {

# Overwrite improper Saitek xml thrust reverse implementation

  if (getprop("sim/initialized")) {

    setprop("input/joysticks/js[01]/button[20]/desc", "Correct Saitek Thrust Reverse");
    setprop("input/joysticks/js[0]/button[20]/repeatable", "false");
    setprop("input/joysticks/js[0]/button[20]/binding/command", "nasal");
    setprop("input/joysticks/js[0]/button[20]/binding/script", "reversethrust.togglereverser()");
    setprop("input/joysticks/js[0]/button[20]/mod-up/binding/command", "nasal");
    setprop("input/joysticks/js[0]/button[20]/mod-up/binding/script", "");

    setprop("input/joysticks/js[1]/button[20]/desc", "Correct Saitek Thrust Reverse");
    setprop("input/joysticks/js[1]/button[20]/repeatable", "false");
    setprop("input/joysticks/js[1]/button[20]/binding/command", "nasal");
    setprop("input/joysticks/js[1]/button[20]/binding/script", "reversethrust.togglereverser()");
    setprop("input/joysticks/js[1]/button[20]/mod-up/binding/command", "nasal");
    setprop("input/joysticks/js[1]/button[20]/mod-up/binding/script", "");

  }

}

setlistener("/sim/initialized", fix_saitek_xml, 0, 0);

