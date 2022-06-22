##################################################################
####      flaplimit.nas - ePilot                              ####
####                                                          ####
####    Limits flap operation to only when electrical         ####
####    power is available for hydraulic pump operation       ####
##################################################################


var flapsDown = func(step) {

    if(step == 0) return;
    if(!getprop("/systems/electrical/on")) return; 
    if(props.globals.getNode("/sim/flaps") != nil) {
        stepProps("/controls/flight/flaps", "/sim/flaps", step);
        return;
    }
    # Hard-coded flaps movement in 3 equal steps:
    var val = 0.3333334 * step + getprop("/controls/flight/flaps");
    setprop("/controls/flight/flaps", val > 1 ? 1 : val < 0 ? 0 : val);
}
