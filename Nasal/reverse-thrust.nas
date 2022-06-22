##################################################################
####      reverse-thrust.nas - ePilot                         ####
####                                                          ####
####    Controls availability of thrust reverse               ####
####    based on certain conditions                           ####
##################################################################


togglereverser = func {

  throttle1 = "/controls/engines/engine/throttle";
  angle1 = "/fdm/jsbsim/propulsion/engine";
  control1 = "/controls/engines/engine"; 
  engselect = "/sim/input/selected";
  pos1 = "/engines/engine/reverser-pos-norm"; 
  gearL = "/gear/gear[1]/wow";
  gearR = "/gear/gear[2]/wow";


  # The reverse can only be actuated while the engine is idling and both main gear compressed
  
  if (getprop(throttle1) < 0.01) {
  if (getprop(gearL)) {
  if (getprop(gearR)) {
  
    val = getprop(pos1);
    if (val == 0 or val == nil) {
      interpolate(pos1, 1.0, 1.4); 
      setprop(angle1,"reverser-angle-rad","2.35619");
      setprop(control1,"reverser", "true");
      setprop(engselect,"engine", "true");
      setprop(control1,"throttle", "0");
      
    } else {
      if (val == 1){
        interpolate(pos1, 0.0, 1.4);
        setprop(angle1,"reverser-angle-rad",0);
        setprop(control1,"reverser",0);
        setprop(engselect,"engine", "true");
        setprop(control1,"throttle", "0");
      }
    }
  }
}
}
}
