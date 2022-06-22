##################################################################
####      annun.nas - ePilot                                  ####
####                                                          ####
####    Controls Annunciator Panel warning lights             ####
####                                                          ####
##################################################################



var annunciators = func {

var elec_on=getprop("systems/electrical/on");

if (elec_on) {

   var running=getprop("engines/engine[0]/running");
   var starter=getprop("controls/electric/starter-switch");


### Starter (also ignition if on START position but NOT in MOTOR position)
    if (starter != 0) {
      setprop("instrumentation/annun/starter",1);
    } else {
      setprop("instrumentation/annun/starter",0);
    }

### Ignition Manual on Mode or Starter Mode
    var ignition=getprop("controls/engines/engine[0]/ignition");
    if((ignition >0) or (starter >0)) {
      setprop("instrumentation/annun/ignition",1);
    } else {
      setprop("instrumentation/annun/ignition",0);
    }


### Doors
    var Pilot=getprop("controls/doors/Pilot");
    var CoPilot=getprop("controls/doors/CoPilot");
    var CabinDoorUpper=getprop("controls/doors/CabinDoorUpper");
    var CabinDoorLower=getprop("controls/doors/CabinDoorLower");
    var cargo1=getprop("controls/doors/cargodoor1");
    var cargo2=getprop("controls/doors/cargodoor2");
    var cargo3=getprop("controls/doors/cargodoor3");
    var cargo4=getprop("controls/doors/cargodoor4");
    var jumpship=getprop("sim/model/jumpship");
    var pod=getprop("sim/model/cargo-pod");

#    var Vent=getprop("controls/doors/Vent");
    if((Pilot != 0) or (CoPilot != 0) or ((CabinDoorUpper != 0) and !jumpship) or ((CabinDoorLower != 0) and !jumpship) or ((cargo1 != 0) and pod) or ((cargo2 != 0) and pod) or ((cargo3 != 0) and pod) or ((cargo4 != 0) and pod)) {
      setprop("instrumentation/annun/doorwarning",1);
    } else {
      setprop("instrumentation/annun/doorwarning",0);
    }

### Oil Pressure
    var oilpress=getprop("engines/engine[0]/oil-pressure-psi");
    if(oilpress < 10) {
      setprop("instrumentation/annun/oilpreslow",1);
    } else {
      setprop("instrumentation/annun/oilpreslow",0);
    }

### Vacuum
    var vacuum=getprop("systems/vacuum/suction-inhg");
    if(vacuum < 3) {
      setprop("instrumentation/annun/vacuumlow",1);
    } else {
      setprop("instrumentation/annun/vacuumlow",0);
    }

### Generator Off
    var gentrip=getprop("controls/electric/engine[0]/generator");
    if((!gentrip) or (!running) or (starter != 0)) {
      setprop("instrumentation/annun/generatoroff",1);
    } else {
      setprop("instrumentation/annun/generatoroff",0);
    }

### Stby Elec Pwr Inop
    if(!running) {
      setprop("instrumentation/annun/stbyelecinop",1);
    } else {
      setprop("instrumentation/annun/stbyelecinop",0);
    }

### Fuel Boost Pump
    var fuelboost=getprop("controls/fuel/boostpump");
    if(fuelboost >1) {
      setprop("instrumentation/annun/auxfuelpump",1);
    } else {
      setprop("instrumentation/annun/auxfuelpump",0);
    }

### Fuel Pressure
    var resempty=getprop("consumables/fuel/tank[2]/empty");
    if((fuelboost < 1) or resempty) {
      setprop("instrumentation/annun/fuelpreslow",1);
    } else {
      setprop("instrumentation/annun/fuelpreslow",0);
    }

### Left Fuel Low
    var leftfuellow=getprop("consumables/fuel/tank[0]/level-gal_us");
    if(leftfuellow < 25) {
      setprop("instrumentation/annun/leftfuellow",1);
    } else {
      setprop("instrumentation/annun/leftfuellow",0);
    }

### Left Fuel Low
    var rightfuellow=getprop("consumables/fuel/tank[1]/level-gal_us");
    if(rightfuellow < 25) {
      setprop("instrumentation/annun/rightfuellow",1);
    } else {
      setprop("instrumentation/annun/rightfuellow",0);
    }

### Fuel Select
    var leftfuelselect=getprop("/fdm/jsbsim/propulsion/tank[0]/collector-valve");
    var rightfuelselect=getprop("/fdm/jsbsim/propulsion/tank[1]/collector-valve");
    if(!leftfuelselect and !rightfuelselect) {
      setprop("instrumentation/annun/fuelselectoff",1);
    } else {
      setprop("instrumentation/annun/fuelselectoff",0);
    }

### Voltmeter display value
    var voltmeterselect=getprop("controls/electric/voltmeterselect");

    if(voltmeterselect == 0) { #Gen
      if (running) {
        setprop("systems/electrical/outputs/voltmeter",28);
      } else {
        setprop("systems/electrical/outputs/voltmeter",0);
      }
    } elsif (voltmeterselect == 1) { #Alt
      if (running) {
        setprop("systems/electrical/outputs/voltmeter",28);
      } else {
        setprop("systems/electrical/outputs/voltmeter",0);
      }
    } elsif ((voltmeterselect == 2) or (voltmeterselect==3)) { #Batt
        setprop("systems/electrical/outputs/voltmeter",28);
    }

### Caculate Lights brightness
    var inst_elec=getprop("systems/electrical/outputs/inst-lights");

    var inst_dim=getprop("controls/lighting/inst-lights-dim");
    setprop("controls/lighting/inst-lights-bright",inst_dim * inst_elec);

    var inst_eng_dim=getprop("controls/lighting/inst-lights-eng-dim");
    setprop("controls/lighting/inst-lights-eng-bright",inst_eng_dim * inst_elec);




} else {
  setprop("instrumentation/annun/starter",0);
  setprop("instrumentation/annun/doorwarning",0);
  setprop("instrumentation/annun/oilpreslow",0);
  setprop("instrumentation/annun/vacuumlow",0);
  setprop("instrumentation/annun/generatoroff",0);
  setprop("instrumentation/annun/auxfuelpump",0);
  setprop("instrumentation/annun/fuelpreslow",0);
  setprop("instrumentation/annun/ignition",0);
  setprop("instrumentation/annun/stbyelecinop",0);
  setprop("instrumentation/annun/leftfuellow",0);
  setprop("instrumentation/annun/rightfuellow",0);
  setprop("instrumentation/annun/fuelselectoff",0);
  setprop("systems/electrical/outputs/voltmeter",0);
  setprop("controls/lighting/inst-lights-bright",0);
  setprop("controls/lighting/inst-lights-eng-bright",0);


} ## end of elec_on


    settimer(annunciators, 0.2);

}

setlistener("sim/signals/fdm-initialized", annunciators);


#  setprop("/sim/messages/copilot", sprintf("%i",starter));
