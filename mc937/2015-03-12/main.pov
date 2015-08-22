//my .pov file from scratch (let's see how it goes)

//#include "colors.inc" //standard include file for color descriptions

//#include "eixos.inc"  //includes do prof.
//#include "camlight.inc" //includes do prof.

/****************************** Texturas padrão do professor ************************/

#declare tx_plastico = 
  texture{
    pigment{ color rgb < 0.70, 0.80, 1.00 > }
    finish{ diffuse 0.8 ambient 0.2 specular 0.5 roughness 0.005 }
  }

#declare tx_fosca = 
  texture{
    pigment{ color rgb < 1.00, 0.80, 0.10 > }
    finish{ diffuse 0.9 ambient 0.1 }
  }

#declare tx_espelho = 
  texture{
    pigment{ color rgb < 1.00, 0.85, 0.30 > }
    finish{ diffuse 0.2 reflection 0.7*< 1.00, 0.85, 0.30 > ambient 0.1 }
  }

#declare tx_vidro = 
  texture{
    pigment{ color rgb < 0.85, 0.15, 0.00 > filter 0.70 }
    finish{ diffuse 0.03 reflection 0.25 ambient 0.02 specular 0.25 roughness 0.005 }
  }


#declare tx_xadrez =
  texture{
    pigment{ checker color rgb < 0.10, 0.32, 0.60 >, color rgb < 1.00, 0.97, 0.90 > }
    finish{ diffuse 0.9 ambient 0.1 }
    scale 2.0
  }

/*************************************************************************************/


background{ color rgb < 0.75, 0.10, 0.25 > }

camera {
  location <0, 2, -3>
  look_at  <0, 1,  2>
}


sphere {
  <0, 1, 2>, 2
  texture {
    pigment { color rgb <1.0, 0.8, 0.8> }
  }
}

box {
  <-10,0,-10> , <10,0.01,10> 
  texture{
    tx_xadrez
  }
}


light_source { <2, 4, -3> color rgb <1.0, 1.0, 1.0> }
