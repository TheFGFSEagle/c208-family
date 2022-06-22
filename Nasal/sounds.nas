##################################################################
####      sounds.nas - ePilot                                 ####
####                                                          ####
####    Prevent sim startup sounds, provide clicks etc        ####
####                                                          ####
##################################################################



var initsounds = maketimer(1, func() {

### Enable Sounds after initial load
    var elapsed=getprop("sim/time/elapsed-sec");
    if (elapsed > 4) {
      setprop("sim/sound/on",1);
      initsounds.stop();
    }
  });

initsounds.start();


var fuelvalveoff = func() {
  setprop("sim/sound/fuelvalve",0);
}

var fuelvalve = func() {
  setprop("sim/sound/fuelvalve",1);
  settimer(fuelvalveoff, 0.9)
}


var clickoff = func() {
  setprop("sim/sound/click",0);
}

var click = func() {
  setprop("sim/sound/click",1);
  settimer(clickoff, 0.1)
}




setlistener("/controls/electric/battery-switch", click, 0, 0);
setlistener("/controls/electric/bustieswitchcover", click, 0, 0);
setlistener("/controls/electric/stbypwrswitchcover", click, 0, 0);
setlistener("/controls/electric/extpwrswitchcover", click, 0, 0);
setlistener("/controls/electric/ext-pwr-switch", click, 0, 0);
setlistener("/controls/electric/engine[0]/generator", click, 0, 0);
setlistener("/controls/fuel/boostpump", click, 0, 0);
setlistener("/controls/engines/engine[0]/ignition", click, 0, 0);
setlistener("/controls/electric/starter-switch", click, 0, 0);
setlistener("/controls/electric/avionics-stby-pwr-switch", click, 0, 0);
setlistener("/controls/electric/avionics-bus-tie-switch", click, 0, 0);
setlistener("/controls/electric/avionics-pwr-switch1", click, 0, 0);
setlistener("/controls/electric/avionics-pwr-switch2", click, 0, 0);
setlistener("/controls/electric/leftldg-switch", click, 0, 0);
setlistener("/controls/electric/rightldg-switch", click, 0, 0);
setlistener("/controls/electric/taxi-switch", click, 0, 0);
setlistener("/controls/electric/strobe-switch", click, 0, 0);
setlistener("/controls/electric/nav-switch", click, 0, 0);
setlistener("/controls/electric/bcn-switch", click, 0, 0);
setlistener("/controls/electric/nosmoke-switch", click, 0, 0);
setlistener("/controls/electric/seatbelt-switch", click, 0, 0);
setlistener("/controls/electric/cabin-switch", click, 0, 0);
setlistener("/controls/electric/pitotheat-switch", click, 0, 0);
setlistener("/controls/electric/stallheat-switch", click, 0, 0);
setlistener("/controls/electric/winglight-switch", click, 0, 0);
setlistener("/controls/electric/ws1-switch", click, 0, 0);
setlistener("/controls/electric/ws2-switch", click, 0, 0);
setlistener("/controls/electric/prop-switch", click, 0, 0);
setlistener("/controls/electric/bootpress-switch", click, 0, 0);

#setlistener("/controls/lighting/flashlight", click, 0, 0);

setlistener("/fdm/jsbsim/propulsion/tank[0]/collector-valve", fuelvalve, 0, 0);
setlistener("/fdm/jsbsim/propulsion/tank[1]/collector-valve", fuelvalve, 0, 0);
