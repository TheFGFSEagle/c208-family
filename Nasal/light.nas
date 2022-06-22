##################################################################
####      light.nas - ePilot                                  ####
####                                                          ####
####    Flashing light (Beacon and Strobe) timings            ####
####                                                          ####
##################################################################



strobe_switch = props.globals.getNode("controls/electric/strobe-switch", 1);
aircraft.light.new("sim/model/lights/strobe", [0.005, 1.4], strobe_switch);
beacon_switch = props.globals.getNode("controls/electric/bcn-switch", 1);
aircraft.light.new("sim/model/lights/beacon", [0.025, 1.5], beacon_switch);
