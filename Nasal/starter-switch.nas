##################################################################
####      starter-switch.nas - ePilot                         ####
####                                                          ####
####    Provides engine start switch function                 ####s
####                                                          ####
##################################################################


var starter_switch = func {

   if (getprop("systems/electrical/on")) {
      #without power - do nothing
   var position=getprop("controls/electric/starter-switch");

      if (position == "1") {
      # Switch to START
          setprop("/controls/engines/engine[0]/starter",1);
          setprop("/sim/sound/Starter_Up",1);
          setprop("/sim/sound/Starter_Down",0);
      } else if (position == "0") {
         # Switch to OFF
          setprop("/controls/engines/engine[0]/starter",0);
          setprop("instrumentation/annun/starter",0);
          setprop("/sim/sound/Starter_Up",0);
          setprop("/sim/sound/Starter_Down",1);
          interpolate("controls/engines/engine[0]/motor-rpm", 0, 15);
      } else if (position == "-1") {
        # Switch to MOTOR
          interpolate("controls/engines/engine[0]/motor-rpm", 110, 5);
          setprop("instrumentation/annun/starter",1);
          setprop("/sim/sound/Starter_Up",1);
          setprop("/sim/sound/Starter_Up",1);
          setprop("/sim/sound/Starter_Down",0);
      }

   }

}

setlistener("/controls/electric/starter-switch", starter_switch, 0, 0);

