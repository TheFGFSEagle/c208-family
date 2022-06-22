##################################################################
####      help.nas - ePilot                                   ####
####                                                          ####
####    Provides images on custom canvas based help dialog    ####
####                                                          ####
##################################################################



<canvas>
  <name>headerimage</name>
  <valign>fill</valign>
  <halign>fill</halign>
  <stretch>true</stretch>
  <pref-width>600</pref-width>
  <pref-height>92</pref-height>
  <nasal>      
    <load>
      <![CDATA[
      
var (width,height) = (600,512);
var title = 'Cessna 208B Help';

# create a new window, dimensions are WIDTH x HEIGHT, using the dialog decoration (i.e. titlebar)
var window = canvas.Window.new([width,height],"dialog")
 .set('title',title);


##
# the del() function is the destructor of the Window
# which will be called upon termination (dialog closing)
# you can use this to do resource management (clean up timers, listeners or background threads)
#window.del = func()
#{
#  print("Cleaning up window:",title,"\n");
# explanation for the call() technique at: http://wiki.flightgear.org/Object_oriented_programming_in_Nasal#Making_safer_base-class_calls
#  call(canvas.Window.del, [], me);
#};

# adding a canvas to the new window and setting up background colors/transparency
var myCanvas = window.createCanvas().set("background", canvas.style.getColor("bg_color"));

# Using specific css colors would also be possible:
# myCanvas.set("background", "#ffaac0");

# creating the top-level/root group which will contain all other elements/group
var root = myCanvas.createGroup();


var path = "Aircraft/Cessna-208B/Nasal/cessna.png";
# create an image child for the texture
var child = root.createChild("image")
    .setFile(path)
    .setTranslation(0, 0)
    .setSize(600, 92);
 
 
 
      ]]>
    </load>
  </nasal>
</canvas>






