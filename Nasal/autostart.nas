##################################################################
####      autostart.nas - ePilot                              ####
####                                                          ####
####    Provides AutoStart / AutoShutdown functionality       ####
####                                                          ####
##################################################################


# Autostart #

var autostart = func {

var leftempty=getprop("/consumables/fuel/tank[0]/empty");
var rightempty=getprop("/consumables/fuel/tank[1]/empty");
if ( (!leftempty) or (!rightempty) ) {

   setprop("/sim/input/selected/engine[0]",1);
   setprop("/controls/engines/engine[0]/propeller-pitch", 1);
   setprop("/controls/electric/battery-switch",1);
   setprop("/systems/electrical/on",1);
   setprop("/fdm/jsbsim/propulsion/tank[0]/collector-valve",1);
   setprop("/controls/doors/LeftFuelSelect",1);
   setprop("/fdm/jsbsim/propulsion/tank[1]/collector-valve",1);
   setprop("/controls/doors/RightFuelSelect",1);
   setprop("/controls/fuel/boostpump",2);
   setprop("/controls/electric/starter-switch",1);
   setprop("/controls/engines/engine[0]/cutoff",1);
   setprop("/controls/engines/engine[0]/mixture",0);

   if (getprop("/engines/engine[0]/n1") >= 19) {
      setprop("/controls/engines/engine[0]/mixture",0.33);
      setprop("/controls/electric/battery-switch",0);
      setprop("/controls/fuel/boostpump",1);
      setprop("/controls/electric/starter-switch",0);
      setprop("/controls/electric/avionics-pwr-switch1",1);
      setprop("/controls/electric/avionics-pwr-switch2",1);
    }


   if (getprop("/engines/engine[0]/n1") < 19) settimer(autostart,0);

   }
}


var autoshutdown = func {
    setprop("/controls/engines/engine[0]/propeller-pitch",0);
    setprop("/controls/electric/battery-switch",0);
    setprop("/controls/electric/starter-switch",0);
    setprop("/controls/fuel/boostpump",0);
    setprop("/controls/engines/engine[0]/cutoff",1);
    setprop("/fdm/jsbsim/propulsion/tank[0]/collector-valve",0);
    setprop("/controls/doors/LeftFuelSelect",0);
    setprop("/fdm/jsbsim/propulsion/tank[1]/collector-valve",0);
    setprop("/controls/doors/RightFuelSelect",0);
    setprop("/controls/electric/avionics-pwr-switch1",0);
    setprop("/controls/electric/avionics-pwr-switch2",0);

}

