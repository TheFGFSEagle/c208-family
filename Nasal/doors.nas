##################################################################
####      doors.nas - ePilot                                  ####
####                                                          ####
####    Provides interpolation for slow moving parts like     ####
####    doors, levers, etc.                                   ####
##################################################################



var Pilot = props.globals.initNode("/controls/doors/Pilot",0,"DOUBLE");
var CoPilot = props.globals.initNode("/controls/doors/CoPilot",0,"DOUBLE");
var UCabin = props.globals.initNode("/controls/doors/CabinDoorUpper",0,"DOUBLE");
var LCabin = props.globals.initNode("/controls/doors/CabinDoorLower",0,"DOUBLE");
var Vent = props.globals.initNode("/controls/doors/Vent",0,"DOUBLE");
var IntSep = props.globals.initNode("/controls/doors/IntSep",0,"DOUBLE");
var AltAir = props.globals.initNode("/controls/doors/AltAir",0,"DOUBLE");
var FuelShutoff = props.globals.initNode("/controls/doors/FuelShutoff",0,"DOUBLE");
var CompDoor = props.globals.initNode("/controls/doors/CompDoor",0,"DOUBLE");
var RudderLever = props.globals.initNode("/controls/doors/RudderLever",1,"DOUBLE");
var HandPumpLever = props.globals.initNode("/controls/doors/HandPumpLever",0,"DOUBLE");
var LeftFuelSelect = props.globals.initNode("/controls/doors/LeftFuelSelect",0,"DOUBLE");
var RightFuelSelect = props.globals.initNode("/controls/doors/RightFuelSelect",0,"DOUBLE");

var cargododoor1 = props.globals.initNode("/controls/doors/cargodoor1",0,"DOUBLE");
var cargododoor2 = props.globals.initNode("/controls/doors/cargodoor2",0,"DOUBLE");
var cargododoor3 = props.globals.initNode("/controls/doors/cargodoor3",0,"DOUBLE");
var cargododoor4 = props.globals.initNode("/controls/doors/cargodoor4",0,"DOUBLE");

var movedoor = func (indevice, rate) {
        var wdevice = props.globals.getNode(indevice) ;
        var devicevalue = wdevice.getValue();
        if ( devicevalue < 0.01 ) {
          interpolate(wdevice.getPath(), 1, rate);
        } else {
          interpolate(wdevice.getPath(), 0, rate);
        }

}
