#include "camlight.inc"
#include "eixos.inc"      

#declare hexapode_minor_radius = 10.0;
#declare hexapode_location = <0, 15, 0>;
#declare leg_length = 10.0;
#declare leg_radius = 1.0;

camlight(hexapode_location, 40, <1,1,1>, 40, y, 5.0)
object { eixos(50) translate hexapode_location }

  // {ctr} = center of interest in scene.
  // {rad} = approx radius of scene.
  // {cav} = vector pointing from {ctr} to camera; only its direction matters.
  // {dst} = the distance from camera to {ctr}.
  // {upp} = the scene's vertical axis ({sky} parameter), usually {z} or {y}.
  // {lux} = a scaling factor for the intensity of standard light sources.

#macro make_subleg(subleg_length, subleg_radius, ) 

    cylinder {
        <0, 0, 0>, <subleg_length, 0, 0>, subleg_radius
        pigment{
            rgbt <0, 0, 1, 0.9>
        }
    }

#end



#macro make_leg(leg_length, leg_radius, )

    

merge {
    sphere {   //de facto hip
        <0,0,0>, leg_radius*2
        pigment{
            rgbt <0.1,0.1,0.3,0.1>
        }
    }
    cylinder {
        <0,0,0>, <leg_length,0,0>, leg_radius
        pigment {
            rgbt <0.8,0.1, 0.9, 0.3>
        }
     }
     sphere {       //de facto knee
        <leg_length, 0, 0>, leg_radius*2
        pigment {
            rgbt <0.5,0.7,0.0,0.1>
        }  
     }
     object{ 
        make_subleg(leg_length, leg_radius )
        rotate 20*z  //latitude angle with respect to the 'parent' leg
        rotate 40*y  //azimuthal angle with respect to the 'parent' leg
        translate <leg_length, 0, 0>
     }
        
       
       
}  

#end

#macro make_hexapode(minor_radius, leg_lengths, leg_radii) //minor radius os the radius of our hexapod (along 2 dimensions. on the third dimension *he is twice as long!)

merge{                 

    sphere{
        <0,0,0>, minor_radius
        pigment{
            rgbt <0.4, 0.3, 0.3, 0.5>
        }
        scale 2*x
    }
    
     object{ make_leg(leg_lengths, leg_radii)     //front right leg
           rotate -30*z //seria a latitude
           rotate -40*y //azimuthal angle (y is our vertical reference)
           translate <minor_radius, 0, sqrt(3)/2.0 * minor_radius>
          }
     object{ make_leg(leg_lengths, leg_radii)      // front left leg
           rotate -30*z //seria a latitude
           rotate +40*y //azimuthal angle (y is our vertical reference)
           translate <minor_radius, 0, -sqrt(3)/2.0 * minor_radius>
          }
     object{ make_leg(leg_lengths, leg_radii)        // left central leg
           rotate -30*z //seria a latitude
           rotate 90*y //azimuthal angle (y is our vertical reference)
           translate <0, 0, -minor_radius>
          }
     object{ make_leg(leg_lengths, leg_radii)    //left hind leg
           rotate -30*z //seria a latitude
           rotate 135*y //azimuthal angle (y is our vertical reference)
           translate <-minor_radius, 0, -sqrt(3)/2.0 * minor_radius>
          }
     object{ make_leg(leg_lengths, leg_radii)     //right hind leg
           rotate -30*z //seria a latitude
           rotate -145*y //azimuthal angle (y is our vertical reference)
           translate <-minor_radius, 0, sqrt(3)/2.0 * minor_radius>
          }
     object{ make_leg(leg_lengths, leg_radii)     //right central leg
           rotate -30*z //seria a latitude
           rotate -90*y //azimuthal angle (y is our vertical reference)
           translate <0, 0, minor_radius>
          }          
}          
         
          
#end
          
plane {
    y, -1
    pigment {
        checker
        rgb <1,0,0>, rgb <0,1,0>
        scale 10
    }
}
           
object{ 
    make_hexapode(hexapode_minor_radius, leg_length, leg_radius)          
    translate <0,20,0>
}