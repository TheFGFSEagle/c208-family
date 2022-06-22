##################################################################
####      apdis.nas - ePilot                                  ####
####                                                          ####
####    Automatically disconnects the a/p if agl is           ####
####    less than 300 ft                                      ####
##################################################################


var apdis = func {




# Disengage A/P if < 300 AGL

  if (getprop("autopilot/internal/CMD")) {
      var curagl = getprop("position/altitude-agl-ft");
           if (curagl < 300) {
          if (curagl != 0) {

          setprop("autopilot/internal/CMD", 0);
          setprop("/autopilot/internal/LNAV-NAV1", 0);
          setprop("/autopilot/internal/LNAV-HDG", 0);
          setprop("/autopilot/internal/LNAV-BC", 0);
          setprop("/autopilot/internal/FMS", 0);
          setprop("/autopilot/internal/VNAV-ALT", 0);
          setprop("/autopilot/internal/APPR", 0);
          setprop("/autopilot/internal/SPD", 0);
                 if (getprop("/gear/gear/wow")) {
                  setprop("sim/messages/copilot", "On the Ground Cannot Engage");
                 } else {
                  setprop("sim/messages/copilot", "Auto-Pilot Disengaged");
                 }
           }
       }
  }
}

setlistener("/instrumentation/clock/indicated-sec", apdis, 0, 0);

