##################################################################
####      fuelcondition.nas - ePilot                          ####
####                                                          ####
####    Controls engine operation based on fuel condition     ####
####    lever on throttle quadrant pedestal                   ####
##################################################################



var fuelcutoff = func {



# Set Fuel Cutoff to 0 on change of mixture setting from 0 when starter engaged


  if (getprop("controls/engines/engine[0]/starter") == 1) {
    setprop("/controls/engines/engine[0]/cutoff", 0);
  }

  if (getprop("engines/engine[0]/running") == 1) {
      if (getprop("controls/engines/engine[0]/mixture") == 0) {
      #Shutdown engines
      setprop("controls/engines/engine[0]/propeller-pitch", 0);
      setprop("/controls/engines/engine[0]/cutoff",1);
      setprop("engines/engine[0]/running", 0);

      call(set_elec,[]);
      }
  } else {
        if (getprop("controls/engines/engine[0]/mixture") == 0) {
       setprop("/controls/engines/engine[0]/cutoff",1);
        }
  }

}

setlistener("/controls/engines/engine[0]/mixture", fuelcutoff, 0, 0);

var set_elec = func {

var battery_on = getprop("controls/electric/battery-switch");
var external_on = getprop("controls/electric/external-power");
var engine1_on = getprop("engines/engine[0]/running");

    if (battery_on or external_on or engine1_on) {
        setprop("systems/electrical/on", 1);
        setprop("systems/electrical/outputs/adf", 28);
        setprop("systems/electrical/outputs/audio-panel", 28);
        setprop("systems/electrical/outputs/avionics-fan", 28);
        setprop("systems/electrical/outputs/comm", 28);
        setprop("systems/electrical/outputs/comm[1]", 28);
        setprop("systems/electrical/outputs/dme", 28);
#        setprop("systems/electrical/outputs/fuel-pump", 28);
#        setprop("systems/electrical/outputs/fuel-pump[1]", 28);
#        setprop("systems/electrical/outputs/fuel-pump[2]", 28);
#        setprop("systems/electrical/outputs/fuel-pump[3]", 28);
        setprop("systems/electrical/outputs/gps-mfd", 28);
        setprop("systems/electrical/outputs/gps", 28);
        setprop("systems/electrical/outputs/hsi", 28);
        setprop("systems/electrical/outputs/inst-lights", 28);
        setprop("systems/electrical/outputs/mk-viii", 28);
        setprop("systems/electrical/outputs/nav", 28);
        setprop("systems/electrical/outputs/nav[1]", 28);
        setprop("systems/electrical/outputs/nav-lights", 28);
        setprop("systems/electrical/outputs/tacan", 28);
        setprop("systems/electrical/outputs/transponder", 28);
        setprop("systems/electrical/outputs/turn-coordinator", 28);
    } else {
        setprop("systems/electrical/on", 0);
        setprop("systems/electrical/outputs/adf", 0);
        setprop("systems/electrical/outputs/audio-panel", 0);
        setprop("systems/electrical/outputs/avionics-fan", 0);
        setprop("systems/electrical/outputs/comm", 0);
        setprop("systems/electrical/outputs/comm[1]", 0);
        setprop("systems/electrical/outputs/dme", 0);
#        setprop("systems/electrical/outputs/fuel-pump", 0);
#        setprop("systems/electrical/outputs/fuel-pump[1]", 0);
#        setprop("systems/electrical/outputs/fuel-pump[2]", 0);
#        setprop("systems/electrical/outputs/fuel-pump[3]", 0);
        setprop("systems/electrical/outputs/gps-mfd", 0);
        setprop("systems/electrical/outputs/gps", 0);
        setprop("systems/electrical/outputs/hsi", 0);
        setprop("systems/electrical/outputs/inst-lights", 0);
        setprop("systems/electrical/outputs/mk-viii", 0);
        setprop("systems/electrical/outputs/nav", 0);
        setprop("systems/electrical/outputs/nav[1]", 0);
        setprop("systems/electrical/outputs/nav-lights", 0);
        setprop("systems/electrical/outputs/tacan", 0);
        setprop("systems/electrical/outputs/transponder", 0);
        setprop("systems/electrical/outputs/turn-coordinator", 0);
    }
}
