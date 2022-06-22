##################################################################
####      propeller.nas - ePilot                              ####
####                                                          ####
####    Prop animations                                       ####
####    Implements Reverse                                    ####
##################################################################


#######################  Pitch  #################################


var proppitch = func {

  throttle1 = "/controls/engines/engine[0]/throttle";
#  engine1 = "/fdm/jsbsim/propulsion/engine[0]";
  control1 = "/sim/model/BladeAngle";
  setting1 = "/controls/engines/engine[0]/propeller-pitch";
  cspeed1 = "/fdm/jsbsim/propulsion/engine[0]/constant-speed-mode";
  engselect = "/sim/input/selected";
  reversed1 = "/controls/engines/engine[0]/reverser";
  feathered1 = "/controls/engines/engine[0]/propeller-feather";
  n1value1 = "/engines/engine[0]/n1";

  if (getprop(feathered1) or (getprop(n1value1) < 60)) {

      interpolate(control1, 105, 1);

  } else if (getprop(reversed1)) {

      interpolate(control1, 0, 1);

  } else {

    var1 = getprop(setting1);
    interpolate(control1, (abs(var1 - 1) * 45) + 30, 1);
  }

}

setlistener("/controls/engines/engine[0]/propeller-pitch", proppitch, 0, 0);
setlistener("/controls/engines/engine[0]/reverser", proppitch, 0, 0);
setlistener("/engines/engine[0]/running", proppitch, 0, 0);
setlistener("/controls/engines/engine[0]/propeller-feather", proppitch, 0, 0);
setlistener("/sim/time/local-day-seconds", proppitch, 0, 0);

#################################  Reverse  #################################


togglereverse = func {

if (getprop("engines/engine[0]/running")) {


  throttle1 = "/controls/engines/engine[0]/throttle";
  control1 = "/controls/engines/engine[0]/reverser";
  control2 = "/engines/engine[0]/reverser-pos-norm";
  cspeed1 = "/fdm/jsbsim/propulsion/engine[0]/constant-speed-mode";
  engselect = "/sim/input/selected";
  pitch1 = "/fdm/jsbsim/propulsion/engine[0]/blade-angle";
#  pitchcontrol1 = "/controls/engines/engine[0]/propeller-pitch";
  angle1 = "/fdm/jsbsim/propulsion/engine[0]/reverser-angle-rad";
  pi= math.pi;

#  gearL = "/gear/gear[1]/wow";
#  gearR = "/gear/gear[2]/wow";


  # The reverse can only be actuated while the engine is idling. TODO: Loop through all bogeys/contacts and make sure at least 2 of them are on the ground

  if (getprop(throttle1) < 0.01 ) {

    val1 = getprop(control1);
    if (val1 == 0) {
      setprop(cspeed1, 0);
      setprop(control1, 1);
      interpolate(pitch1, -14, 2);
      interpolate(control2, 1, 1);
      setprop(angle1, pi);
      setprop(engselect,"engine[0]", 1);
      setprop(throttle1, 0);
#     setprop(pitchcontrol1, getprop(pitchcontrol1));    previously used to trigger animation but not needed now

    } else {

      interpolate(pitch1, 11.6, 2);
      setprop(angle1, 0);
      setprop(control1, 0);
      interpolate(control2, 0, 1);
      setprop(engselect,"engine[0]", 1);
      setprop(throttle1, 0);
      setprop(cspeed1, 1);
#     setprop(pitchcontrol1, getprop(pitchcontrol1));
    }
  }
}

}

