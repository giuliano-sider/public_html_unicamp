// Exemplo de arquivo de descricao de cena para POV-ray
// Last edited on 2010-03-04 15:44:01 by stolfi

// ======================================================================
// CORES E TEXTURAS

background{ color rgb < 0.75, 0.80, 0.85 > }

#declare tx_plastico = 
  texture{
    pigment{ color rgb < 0.10, 0.80, 1.00 > }
    finish{ diffuse 0.8 ambient 0.1 specular 0.5 roughness 0.005 }
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
    pigment{ color rgb < 0.85, 0.95, 1.00 > filter 0.70 }
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
#declare raio = 2.000;

// Partes da cena:
  
#declare bolinha = 
  sphere{ < 0,0,0 >, 0.60 }
 
#declare bolota = 
  sphere{ < 0,0,0 >, 1.50 }
 
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
    0.75*raio
    texture{ tx_fosca }
  }

#declare chao = 
  box{ <-20,-20,-1>, <+20,+20,0> }

*/

//CACTO:

#declare seedAngle = seed(483);
#declare seedLength = seed(5732);
#declare seedHeight = seed(2342);

#macro make_cactus_body(altura, raio)
  union{
    cylinder{
      <0,0,0> , <0,altura-raio,0>, raio
      pigment {cacto_green }
    }
    difference{
      sphere{
        <0,altura-raio,0>, raio
        pigment{cacto_green }
      }
      cylinder{
        <0,0,0> , <0,altura-raio,0>, raio
        pigment {cacto_green }
      }
    }
  }
#end

#macro make_cactus_thorn(altura, raio) //a altura e o raio sao do cacto mesmo
  cone{
    #local alturadothorn = rand(seedHeight);
    <0, (altura-raio)*alturadothorn, 0>, altura/100.0,
    <raio+rand(seedLength)*raio, (altura-raio)*alturadothorn, 0> , 0.00
  
    pigment{thorn_color}
    rotate <0,rand(seedAngle)*360,0>
  }
#end

#macro make_cactus(profundidade, num_espinhos, altura, raio, num_sub_cactos)

  #declare cacto_green = color rgb <0.0,1.0,0.2>;
  #declare thorn_color = color rgb <1.0,0.7,0.9>;
  #declare shrink_factor = 2.0/4.0;
  #local cactus_body = make_cactus_body(altura, raio);
  #local i = 0;

  union{
    object{cactus_body}
    #for(i, 0, num_espinhos)
      difference{
        make_cactus_thorn(altura, raio)
        object{cactus_body}
      }
      #local i = i + 1;
    #end
    
    #if(profundidade>0)
      #local i = 0;
      #for(i, 0, num_sub_cactos)
        object{
          make_cactus(profundidade-1, num_espinhos*shrink_factor, altura*shrink_factor, raio*shrink_factor, num_sub_cactos) //sub cactos terao dimensoes mais modestas
          rotate <-90+180*rand(seedAngle), 360*rand(seedAngle), /*360*rand(seedAngle)*/>
          translate <0,altura/2 + (altura/2)*rand(seedHeight),0>
        }
        #local i = i + 1;
      #end

    #else
        
        //make flower
    #end
  }


#end

#include "eixos.inc"

// Aqui está a cena, finalmente:

object{
  make_cactus(5, 100, 10, 1, 3) //profundidade, num_espinhos, altura, raio, num_sub_cactos
  rotate 90*x
  rotate 90*z
  //rotate 360*clock*z
}


union{
  //object{ eixos(12.00) }
  /*
  object{ chao  translate < 0,0,-5 > texture{ tx_xadrez } }
  object{ bolota  translate < -2,+1,+3 > texture{ tx_espelho } }
  object{ bolinha translate < +5,+4,+2 > texture{ tx_vidro } interior { ior 1.01 } }

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
#declare centro_cena = < 0.00, 0.00, 7.00 >;
#declare raio_cena = 15.0;
#declare dir_camera = < 14.00, 7.00, 4.00 >;
#declare dist_camera = 30.0;
#declare intens_luz = 1.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
