// Exemplo de arquivo de descricao de cena para POV-ray
// Last edited on 2010-03-04 15:44:01 by stolfi

// ======================================================================
// CORES E TEXTURAS

background{ color rgb < 0.75, 0.10, 0.25 > }

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

// ======================================================================
// DESCRIÇÃO DA CENA 



/*
#declare raio = 1.500;

// Partes da cena:
  
#declare bolinha = 
  sphere{ < 0,0,0 >, 0.60 }
 
#declare bolota = 
  sphere{ < 1,0,0 >, 1.50 }
 
#declare bola =
  sphere{
    < 0.00, 0.00, 0.00 >, raio 
    texture{ tx_plastico }
  }
  
#declare pino = 
  cylinder{
    < -2.00, +2.00, -1.00 >,
    < +2.00, -2.00, +1.00 >,
    0.75
    texture{ tx_fosca }
  }
  
#declare furo = 
  cylinder{
    < -1.00, -2.00, -2.00 >,
    < +1.00, +2.00, +2.00 >,
    0.45*raio
    texture{ tx_fosca }
  }
*/

#declare scale_pyramid = 5.0;
#declare raio_mistico = 0.5; //para a esfera
#declare cyl_raio = 0.1;

#declare chao = 
  box{ <-20,-20,-1>, <+20,+20,0> }


#declare bottom_face = 
  box{ <1.0, 0.0, 0.0> , <0.0, 1.0 , 0.01> texture{ tx_fosca }
  }

#declare t1 = 
  triangle{ <0,0,0> , <1.0, 0.0, 0.0> , <0.5, 0.5, 1.0> texture{ tx_fosca }
  }

#declare t2 = 
  triangle{ <1,0,0> , <1,1,0> , <0.5, 0.5, 1.0> texture{ tx_fosca }
  }

#declare t3 =
  triangle{ <0.0, 1.0, 0.0> , < 1.0 , 1.0, 0.0> , <0.5, 0.5, 1.0> texture{ tx_fosca } 
  }

#declare t4 = 
  triangle{ <0,0,0> , <0.0, 1.0, 0.0> , <0.5, 0.5, 1.0> texture{ tx_fosca }
  }


#declare esfera_mistica =
  sphere{ <0.5, 0.5, 1.0 + raio_mistico> , raio_mistico texture{ tx_vidro } 
  }


#declare cyl1 = 
  cylinder { <-0.1, -0.1, 0.0> , <-0.1, -0.1, 0.3>, cyl_raio texture { tx_plastico }
  }

#declare cyl2 = 
  cylinder { <1.1, -0.1, 0.0> , <1.1, -0.1, 0.3>, cyl_raio texture { tx_plastico }
  }

#declare cyl3 = 
  cylinder { <1.1, 1.1, 0.0> , <1.1, 1.1, 0.3>, cyl_raio texture { tx_plastico }
  }

#declare cyl4 = 
  cylinder { <-0.1, 1.1, 0.0> , <-0.1, 1.1, 0.3>, cyl_raio texture { tx_plastico }
  }


#declare con1 = 
  cone{ <-0.1, -0.1, 0.3> , cyl_raio, <-0.1, -0.1, 0.5> , 0 texture {tx_espelho}
  }

#declare con2 = 
  cone{ <1.1, -0.1, 0.3> , cyl_raio, <1.1, -0.1, 0.5> , 0 texture {tx_espelho}
  }

#declare con3 = 
  cone{ <1.1, 1.1, 0.3> , cyl_raio, <1.1, 1.1, 0.5> , 0 texture {tx_espelho}
  }

#declare con4 = 
  cone{ <-0.1, 1.1, 0.3> , cyl_raio, <-0.1, 1.1, 0.5> , 0 texture {tx_espelho}
  }

#declare mytexto =
  text {
  ttf "mytype.ttf" "My name is Ozymandias, king of kings; look on my Works, ye mighty, and Despair!" 1, 0
  translate <1.0, 1.0, 1.0>
  }



#include "eixos.inc"

// Aqui está a cena, finalmente:

union{
  object{ eixos(30.00) }

  object{ chao  translate < 0,0,-5 > texture{ tx_xadrez } }

  object{ bottom_face scale scale_pyramid }
  object{ t1 scale scale_pyramid }
  object{ t2 scale scale_pyramid }
  object{ t3 scale scale_pyramid }
  object{ t4 scale scale_pyramid }
  object{ esfera_mistica scale scale_pyramid }

  object{ cyl1 scale scale_pyramid }
  object{ cyl2 scale scale_pyramid }
  object{ cyl3 scale scale_pyramid }
  object{ cyl4 scale scale_pyramid }
  object{ con1 scale scale_pyramid }
  object{ con2 scale scale_pyramid }
  object{ con3 scale scale_pyramid }
  object{ con4 scale scale_pyramid }
 
  object{ mytexto scale 0.5 rotate <0.0, 90.0, 0.0> }
  /*object{text {
	  ttf "mytype.ttf" "My name is Ozymandias, king of kings; look on my Works, ye mighty, and Despair!" 1, 0
	  pigment { Red }
	  }
  }*/

/*
  //object{ bolota  translate < -2,+1,+3 > texture{ tx_espelho } }
  //object{ bolinha translate < +5,+4,+2 > texture{ tx_vidro } interior { ior 1.01 } }

  difference{ 
    union{
      object{ bola } 
      object{ pino }
    }
    object{ furo }
  }
*/


}



#include "camlight.inc"
#declare centro_cena = < 0.00, 0.00, 1.00 >;
#declare raio_cena = 9.0;
#declare dir_camera = < 7.00, 7.00, 4.00 >;
#declare dist_camera = 19.0;
#declare intens_luz = 2.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
