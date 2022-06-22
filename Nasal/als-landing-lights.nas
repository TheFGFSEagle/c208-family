##################################################################
####      als-landing-lights.nas - ePilot                     ####
####                                                          ####
####    Enable/disable landing lights under ALS               ####
####                                                          ####
##################################################################



var als_landing_lights = func {

  if (getprop("systems/electrical/on")) {
    if (getprop("controls/electric/leftldg-switch")) {
      setprop("sim/rendering/als-secondary-lights/use-landing-light-left",1);
    } else {
      setprop("sim/rendering/als-secondary-lights/use-landing-light-left",0);
    }
    if (getprop("controls/electric/rightldg-switch")) {
      setprop("sim/rendering/als-secondary-lights/use-landing-light-right",1);
    } else {
      setprop("sim/rendering/als-secondary-lights/use-landing-light-right",0);
    }
  } else {
  setprop("sim/rendering/als-secondary-lights/use-landing-light-left",0);
  setprop("sim/rendering/als-secondary-lights/use-landing-light-right",0);
  }


}


var als_taxi_lights = func {

  if (getprop("systems/electrical/on")) {
    if (getprop("controls/electric/taxi-switch")) {
      setprop("sim/rendering/als-secondary-lights/use-taxi-light-left",1);
      setprop("sim/rendering/als-secondary-lights/use-taxi-light-right",1);
    } else {
      setprop("sim/rendering/als-secondary-lights/use-taxi-light-left",0);
      setprop("sim/rendering/als-secondary-lights/use-taxi-light-right",0);
    }
  } else {
  setprop("sim/rendering/als-secondary-lights/use-taxi-light-left",0);
  setprop("sim/rendering/als-secondary-lights/use-taxi-light-right",0);
  }

}


setlistener("/systems/electrical/on", als_landing_lights, 0, 0);
setlistener("/systems/electrical/on", als_taxi_lights, 0, 0);
setlistener("/controls/electric/leftldg-switch", als_landing_lights, 0, 0);
setlistener("/controls/electric/rightldg-switch", als_landing_lights, 0, 0);
setlistener("/controls/electric/taxi-switch", als_taxi_lights, 0, 0);
