##################################################################
####      throttle-limit.nas - ePilot                         ####
####                                                          ####
####    Engine rpm / prop rpm governor                        ####
####    Implements ePower lever Op                            ####
##################################################################


var throttlelimit = func {

  throttle1 = "/controls/engines/engine[0]/throttle";
  ePower = "/controls/engines/engine[0]/ePower";
#  reversed = "/controls/engines/engine[0]/reverser";

#   if (getprop(reversed)) {
#      throttleposition = getprop(throttle1);  Seems to be automatic on the turboprop engine model so no limiting needed here.
#      if (throttleposition > 0.6) {
#         setprop(throttle1, 0.6)
#      }
#   } else {
      if (getprop(ePower)) {
         setprop(throttle1, 1);
      } else  {
         throttleposition = getprop(throttle1);
         if (throttleposition > 0.853) {
            setprop(throttle1, 0.853)
         }
      }
   #}
}

setlistener("/controls/engines/engine[0]/throttle", throttlelimit, 0, 0);
setlistener("/controls/engines/engine[0]/ePower", throttlelimit, 0, 0);

