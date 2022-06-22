##################################################################
####      copilot.nas - ePilot                                ####
####                                                          ####
####    Provides various co-pilot callouts                    ####
####                                                          ####
##################################################################

setlistener("/sim/signals/fdm-initialized", func {
    copilot.init();
});

# var V1 = props.globals.initNode("/instrumentation/fmc/vspeeds/V1",140,"DOUBLE");
# var V2 = props.globals.initNode("/instrumentation/fmc/vspeeds/V2",150,"DOUBLE");
# var VR = props.globals.initNode("/instrumentation/fmc/vspeeds/VR",170,"DOUBLE");


# Copilot V-Speed announcements

var copilot = {
  init : func {
        me.UPDATE_INTERVAL = 1.73;
        me.loopid = 0;
    # Initialize state variables.
    me.Fortyannounced = 0;
    me.V1announced = 0;
    me.VRannounced = 0;
    me.V2announced = 0;
    me.PRannounced = 0;
        me.reset();
        print("Copilot ready");
    },
  update : func {



var grossweight = getprop("fdm/jsbsim/inertia/weight-lbs") or 0.00;
var V1 = 0;
var VR = 0;
var V2 = 0;
if (grossweight < 7300) {
   V1 = 65;
   VR = 75;
   V2 = 82;
   } elsif ((grossweight >7300) and (grossweight <7800)) {
   V1 = 68;
   VR = 77;
   V2 = 84;
   } elsif ((grossweight >7800) and (grossweight <8300)) {
   V1 = 71;
   VR = 79;
   V2 = 87;
   } elsif (grossweight >8300) {
   V1 = 74;
   VR = 81;
   V2 = 89;
   }

    setprop("/instrumentation/fmc/vspeeds/V1", V1);
    setprop("/instrumentation/fmc/vspeeds/VR", VR);
    setprop("/instrumentation/fmc/vspeeds/V2", V2);

    var airspeed = getprop("velocities/airspeed-kt");
    var V1 = getprop("/instrumentation/fmc/vspeeds/V1");
    var VR = getprop("/instrumentation/fmc/vspeeds/VR");
    var V2 = getprop("/instrumentation/fmc/vspeeds/V2");

        if ((airspeed > 39) and (me.Fortyannounced == 0)) {
            me.announce("40 Knots");
      me.Fortyannounced = 1;
        } elsif ((airspeed != nil) and (V1 != nil) and (airspeed > V1) and (me.V1announced == 0)) {
            me.announce("V1");
      me.V1announced = 1;
        } elsif ((airspeed != nil) and (VR != nil) and (airspeed > VR) and (me.VRannounced == 0)) {
            me.announce("Rotate");
      me.VRannounced = 1;
        } elsif ((airspeed != nil) and (V2 != nil) and (airspeed > V2) and (me.V2announced == 0)) {
            me.announce("V2");
      me.V2announced = 1;
        } elsif ((V1 == nil) or (V2 == nil) or (VR == nil)){
      print ("FMU Toast - Vspeeds not calculated");
    }

    },
  announce : func(msg) {
      if (getprop("sim/co-pilot")) {
        setprop("/sim/messages/copilot", msg);
      }
    },
    reset : func {
        me.loopid += 1;
        me._loop_(me.loopid);
    },
    _loop_ : func(id) {
        id == me.loopid or return;
        me.update();
        settimer(func { me._loop_(id); }, me.UPDATE_INTERVAL);
    }
};






var parkingbrake = func {

if (getprop("sim/co-pilot")) {

# Check for reverser on and confirm activated

  if (getprop("/controls/gear/brake-parking") == 1) {
     setprop("/sim/messages/copilot", "Parking Brake Engaged");
  }

# Check for reverser off and confirm

  if (getprop("/controls/gear/brake-parking") == 0) {
    setprop("/sim/messages/copilot", "Parking Brake Off");
  }
}
}

setlistener("/controls/gear/brake-parking", parkingbrake, 0, 0);



var flappos = func {

# Report Flap Setting

  if (getprop("sim/co-pilot")) {

    var flapval= getprop("/controls/flight/flaps");

    if (flapval == 0) { var flapdeg="Up"; }
    if (flapval == 0.333333) { var flapdeg="10";  }
    if (flapval == 0.666666) { var flapdeg="20";  }
    if (flapval == 1.000) { var flapdeg="Full"; }

    setprop("/sim/messages/copilot", "Flaps " ~ flapdeg);
  }
}

setlistener("/controls/flight/flaps", flappos, 0, 0);



var reverse = func {

if (getprop("sim/co-pilot")) {

# Check for reverser on and confirm activated

  if (getprop("/controls/engines/engine[0]/reverser") == 1) {
     setprop("/sim/messages/copilot", "Thrust Reverse Active");
  }

# Check for reverser off and confirm

  if (getprop("/controls/engines/engine[0]/reverser") == 0) {
    setprop("/sim/messages/copilot", "Thrust Reverse Off");
  }
}
}

setlistener("/controls/engines/engine[0]/reverser", reverse, 0, 0);



var floats = func {

if (getprop("sim/co-pilot")) {

# Check for floats attached

  if (getprop("/sim/model/floats") == 1) {
     setprop("/sim/messages/copilot", "Floats Attached");
  }

# Check for reverser off and confirm

  if (getprop("/sim/model/floats") == 0) {
    setprop("/sim/messages/copilot", "Floats Removed");
  }
}
}

setlistener("/sim/model/floats", floats, 0, 0);



var waterrudders = func {

  if (getprop("sim/co-pilot")) {

# Check for float rudder position

    if (getprop("/controls/gear/wrudders") == 1) {
      setprop("/sim/messages/copilot", "Float Rudders Lowered");
    } else {
      setprop("/sim/messages/copilot", "Float Rudders Raised");
    }
  }
}

setlistener("/controls/gear/wrudders", waterrudders, 0, 0);


var cargomaster = func {

  if (getprop("sim/co-pilot")) {


    if (getprop("/sim/model/cargo") == 1) {
      setprop("/sim/messages/copilot", "Cargomaster Configuration Enabled");
    } else {
      setprop("/sim/messages/copilot", "Cargomaster Configuration Removed");
    }
  }
}

setlistener("/sim/model/cargo", cargomaster, 0, 0);


var cargopod = func {

  if (getprop("sim/co-pilot")) {


    if (getprop("/sim/model/cargo-pod") == 1) {
      setprop("/sim/messages/copilot", "Cargo Tank Attached");
    } else {
      setprop("/sim/messages/copilot", "Cargo Tank Removed");
    }
  }
}

setlistener("/sim/model/cargo-pod", cargopod, 0, 0);

var yokes = func {

  if (getprop("sim/co-pilot")) {

    if (getprop("/sim/model/yokes") == 1) {
      setprop("/sim/messages/copilot", "Yokes Added");
    } else {
      setprop("/sim/messages/copilot", "Yokes Removed");
    }
  }
}

setlistener("/sim/model/yokes", yokes, 0, 0);


var jumpship = func {

  if (getprop("sim/co-pilot")) {

    if (getprop("/sim/model/jumpship") == 1) {
      setprop("/sim/messages/copilot", "Skydiving Configuration Enabled");
    } else {
      setprop("/sim/messages/copilot", "Skydiving Configuration Removed");
    }
  }
}

setlistener("/sim/model/jumpship", jumpship, 0, 0);
