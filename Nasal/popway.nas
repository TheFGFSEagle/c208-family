##################################################################
####      popway.nas - ePilot                                 ####
####                                                          ####
####    Pops route manager to next waypoint for smooth        ####
####    transition to next leg minimizing overshoot           ####
####                                                          ####
##################################################################

var popway = func {

# Next Wapoint

  if (getprop("autopilot/internal/CMD")) {
      if (getprop("autopilot/internal/FMS")) {
        if (getprop("autopilot/internal/eta-wp-hr") < 1) {
          if (getprop("autopilot/internal/eta-wp-min") < .2) {
				
        var curwp = getprop("autopilot/route-manager/current-wp");
        var nextwp = curwp + 1;
        setprop("autopilot/route-manager/current-wp", nextwp);
    
             }
           }
        }   
  }
}

setlistener("/autopilot/route-manager/flight-time", popway, 0, 0);

