##################################################################
####      shadow_elev.nas - ePilot                            ####
####                                                          ####
####    Provides /position/altitude-agl-m needed for ALS      ####
####    shadow translation to ground level                    ####
##################################################################

var shadow_elev_loop = func {


var surface=getprop("fdm/jsbsim/ground/solid");
var feet=getprop("position/altitude-agl-ft");

    if (surface) {
        setprop ("/position/altitude-agl-m", (feet-0.5)*0.3048);
    } else {
        setprop ("/position/altitude-agl-m", (feet+0.3)*0.3048);
    }

    settimer(shadow_elev_loop, 0.5);
}

shadow_elev_loop();
