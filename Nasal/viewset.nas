##################################################################
####      viewset.nas - ePilot                                ####
####                                                          ####
####    Part of the active checklist system. Adjusts pilot    ####
####    view to location of items on checklists when the      ####
####    'where is this' button is clicked                     ####
##################################################################


var viewset = func (viewnumber,x,y,z,s,p,h) {

var defzoom=getprop("sim/view[" ~ viewnumber ~ "]/config/default-field-of-view-deg");
#var defpitch=getprop("sim/view[" ~ viewnumber ~ "]/config/pitch-offset-deg");
#var defheading=getprop("sim/view[" ~ viewnumber ~ "]/config/heading-offset-deg");
var curheading=getprop("sim/current-view/heading-offset-deg");

var newview=0;

if(viewnumber >100){
viewnumber=viewnumber-92;
}

setprop("sim/current-view/view-number", viewnumber);

setprop("sim/current-view/field-of-view", defzoom);


setprop("/sim/model/marker/x/value", x);
setprop("/sim/model/marker/y/value", y);
setprop("/sim/model/marker/z/value", z);
setprop("/sim/model/marker/scale/value", s);
interpolate("/sim/current-view/pitch-offset-deg", p, 1);

if ((curheading > 180) and (h < 180)) {
  h += 360;
} elsif ((curheading < 180) and (h > 180)) {
  setprop("/sim/current-view/heading-offset-deg", curheading+360);
}

interpolate("/sim/current-view/heading-offset-deg", h, 1);
setprop("sim/model/marker/arrow-enabled", 1);

}


