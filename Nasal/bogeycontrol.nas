##################################################################
####      bogeycontrol.nas - ePilot                           ####
####                                                          ####
####    Main Float Bogey management. Controls initial load    ####
####    fuselage configuration and float bogey positioning,   ####
####    hydrodynamic drag, float side forces and              ####
####    float rudder forces                                   #### 
##################################################################

var configbogeys = func {


  var surface=getprop("fdm/jsbsim/ground/solid");

  if(surface ) {
# if over land hide floats and 0 all float bogeys/structures

    setprop("sim/model/floats", 0);

    for (var bogey=3; bogey < 7; bogey = bogey +1) {
      setprop("fdm/jsbsim/gear/unit[" ~ bogey ~ "]/z-position", "0");
    }
    for (var struc=7; struc < 21; struc = struc +1) {
      setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
    }


  } else {
# if over water show floats, hide gear, raise float gear, zero hard float structures

    setprop("sim/model/floats", 1);
    setprop("controls/gear/gear-down", 0);
    setprop("controls/gear/brake-parking", 0);

    for (var struc=7; struc < 15; struc = struc +1) {
     setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
    }


  }



}

setlistener("/sim/signals/fdm-initialized", configbogeys);

######################## Auto config #########################

var autoconfig = func {

# setprop("/sim/messages/copilot","Fired");

  var floats=getprop("sim/model/floats");
  if (floats) {

    var surface=getprop("fdm/jsbsim/ground/solid");
    if (surface) {
    # floats on and over land - raise water bogeys, lower float structures
    for (var struc=15; struc < 19; struc = struc +1) {
      setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
    }



      setprop("fdm/jsbsim/contact/unit[7]/z-position", "-102.436221");
      setprop("fdm/jsbsim/contact/unit[8]/z-position", "-102.436221");
      setprop("fdm/jsbsim/contact/unit[9]/z-position", "-116.483858");
      setprop("fdm/jsbsim/contact/unit[10]/z-position", "-116.483858");
      setprop("fdm/jsbsim/contact/unit[11]/z-position", "-119.688583");
      setprop("fdm/jsbsim/contact/unit[12]/z-position", "-119.688583");
      setprop("fdm/jsbsim/contact/unit[13]/z-position", "-87.911024");
      setprop("fdm/jsbsim/contact/unit[14]/z-position", "-87.911024");
  } else {
    # floats on and over water - raise float strucs and lower water bogeys
    for (var struc=7; struc < 15; struc = struc +1) {
      setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
    }
      setprop("fdm/jsbsim/contact/unit[15]/z-position", "-93.6248");
      setprop("fdm/jsbsim/contact/unit[16]/z-position", "-93.6248");
      setprop("fdm/jsbsim/contact/unit[17]/z-position", "-90.5606");
      setprop("fdm/jsbsim/contact/unit[18]/z-position", "-90.5606");
  }

  }
settimer(autoconfig, 2);
}
autoconfig();

var manualconfig = func {

  var floats=getprop("/sim/model/floats");
  if (!floats) {

    # switching to floats

    var wow=getprop("/fdm/jsbsim/gear/wow");
    if (wow) {
      # if on ground raise the plane, raise water bogeys and lower the float gear
      setprop("/controls/gear/gear-down", 1);

      var agl=getprop("/fdm/jsbsim/position/h-agl-ft");
      setprop("/fdm/jsbsim/position/h-agl-ft", agl + 5);
      for (var struc=15; struc < 19; struc = struc +1) {
        setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
      }
    } else {
      # if in air just raise the float gear
      setprop("/controls/gear/gear-down", 0);
    }

    setprop("/sim/model/floats", 1);
  
    # lower all float structures/bogeys
    for (var bogey=3; bogey < 7; bogey = bogey +1) {
      setprop("fdm/jsbsim/gear/unit[" ~ bogey ~ "]/z-position", "-126.6248");
    }
      setprop("fdm/jsbsim/contact/unit[7]/z-position", "-102.436221");
      setprop("fdm/jsbsim/contact/unit[8]/z-position", "-102.436221");
      setprop("fdm/jsbsim/contact/unit[9]/z-position", "-116.483858");
      setprop("fdm/jsbsim/contact/unit[10]/z-position", "-116.483858");
      setprop("fdm/jsbsim/contact/unit[11]/z-position", "-119.688583");
      setprop("fdm/jsbsim/contact/unit[12]/z-position", "-119.688583");
      setprop("fdm/jsbsim/contact/unit[13]/z-position", "-87.911024");
      setprop("fdm/jsbsim/contact/unit[14]/z-position", "-87.911024");

  } else {

    # removing floats

    var floating=getprop("/fdm/jsbsim/contact/unit[18]/compression-ft");
    if (floating == 0) {

      #raise bogeys/structures
      for (var bogey=3; bogey < 7; bogey = bogey +1) {
        setprop("fdm/jsbsim/gear/unit[" ~ bogey ~ "]/z-position", "0");
      }
      for (var struc=7; struc < 21; struc = struc +1) {
        setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/z-position", "0");
      }
      setprop("sim/model/floats", 0);

    } else {
      setprop("sim/messages/copilot","We are curently using the floats captain - cannot remove");
    }

  }

}

setlistener("/sim/model/float-command", manualconfig, 0, 0);

##############################  water drag  #############################################


var bogeydrag = func {


var running = getprop("/engines/engine[0]/running");

if (running) {

  var speed = getprop("/velocities/groundspeed-kt");
  var throttle = getprop("/controls/engines/engine[0]/throttle");

  var coeff = (0.15 + (speed/500) - (throttle/3));

# setprop("sim/messages/copilot", "Setting strucs to " ~ coeff);

    for (var struc=15; struc < 19; struc = struc + 1) {
      setprop("fdm/jsbsim/contact/unit[" ~ struc ~ "]/dynamic_friction_coeff", coeff);
    }
  }
  settimer(bogeydrag, 0.5);
}
bogeydrag();


##############################  water rudders  #############################################


var rudderboost = func {


  var onleftfloat = getprop("/gear/gear[17]/compression-ft");
  var onrightfloat = getprop("/gear/gear[18]/compression-ft");

  if (onleftfloat and onrightfloat) {

    var wrudders = getprop("/controls/gear/wrudders");

    if (wrudders) {
      var speed = getprop("/velocities/groundspeed-kt");
      var targetvar = 20 - (speed / 1.8);
      if (targetvar < 1) { targetvar = 1; }
      setprop("fdm/jsbsim/fcs/yaw-hydro", targetvar);
    } else {
      setprop("fdm/jsbsim/fcs/yaw-hydro", 1);
    }
  }
settimer(rudderboost, 0.5);

}
rudderboost();

