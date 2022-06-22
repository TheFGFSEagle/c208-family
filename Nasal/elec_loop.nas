##################################################################
####      elec_loop.nas - ePilot                              ####
####                                                          ####
####    Main electrical loop provides output voltages         ####
####    to various systems                                    ####
##################################################################

var elec_loop = func {

   var battery_on = getprop("controls/electric/battery-switch");
   var external_on = getprop("controls/electric/external-power");
   var engine1_on = getprop("engines/engine[0]/running");
   var n1 = getprop("engines/engine[0]/n1")>25;
   var viewnum = getprop("sim/current-view/view-number");


   if (battery_on or external_on or engine1_on or n1) {
      setprop("systems/electrical/on", 1);
      setprop("systems/electrical/outputs/adf", 28);
      setprop("systems/electrical/outputs/audio-panel", 28);
      setprop("systems/electrical/outputs/avionics-fan", 28);
      setprop("systems/electrical/outputs/comm", 28);
      setprop("systems/electrical/outputs/comm[1]", 28);
      setprop("systems/electrical/outputs/dme", 28);
      if (viewnum != 0) {
        setprop("systems/electrical/outputs/efis", 0);
      } else {
        setprop("systems/electrical/outputs/efis", 28);
      }
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
      setprop("systems/electrical/outputs/efis", 0);
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
      setprop("systems/electrical/outputs/voltmeter", 0);
   }

   settimer(elec_loop, 0.5);

}

setlistener("/sim/signals/fdm-initialized", func { elec_loop() } );

