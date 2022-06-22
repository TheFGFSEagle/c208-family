##################################################################
####      auto-apdis.nas - ePilot                             ####
####                                                          ####
####  Provides flight control deflection A/P auto disconnect  ####
####                                                          ####
##################################################################


autoapdis = func {
  # Check for movement of flight surfaces while A/P engaged


  if(getprop("/autopilot/internal/CMD")) {

    var aileronpos=getprop("controls/flight/aileron");
    var elevatorpos=getprop("controls/flight/elevator");
    var rudderpos=getprop("controls/flight/rudder");
    
   
    if(abs(aileronpos) > .1 or abs(elevatorpos) > .1 or abs(rudderpos) > .1) {
      setprop("/autopilot/internal/LNAV-NAV1", 0);
      setprop("/autopilot/internal/LNAV-HDG", 0);
      setprop("/autopilot/internal/LNAV-BC", 0);
      setprop("/autopilot/internal/FMS", 0);
      setprop("/autopilot/internal/VNAV-ALT", 0);
    }
    
  }
  # End of if CMD
 
    settimer(autoapdis, 0.2);   
} 
# End of autoapdis
 
init = func {
   settimer(autoapdis, 0.2);
}

init();
