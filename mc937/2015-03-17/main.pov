// Laboratorio 02 de MC930. Giuliano Sider, ra146271, 2015-03-17.
// maioria do código herdado diretamente do template do prof. Stolfi
// ======================================================================
// CORES E TEXTURAS

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

#declare myBgColor =  color rgb < 0.75, 0.10, 0.25 > ;
#declare vermelho =  color rgb <1,0,0> ;
#declare verde =  color rgb <0,1,0> ;
#declare azul =  color rgb <0,0,1> ;
#declare branco = color rgb <1.0, 1.0, 1.0>;
#declare preto = color rgb <1.0, 1.0, 1.0>;

#macro make_taxi(length, cor)
//produces a taxi with desired <length>, facing <xorientation> degrees relative to the
//positive x semi axis (in the xz plane, counterclockwise), and with its <center_pos> given
  
  union{
    box{
      <5,2-3>,<-5,3,3>  pigment{cor} 
    }
    cylinder{
      <3,0.5,0.8>,<3,0.5,0.6>, 1 pigment{preto}
    }
    cylinder{
      <3,0.5,-0.8>,<3,0.5,-0.6>, 1 pigment{preto}
    }
    cylinder{
      <-3,0.5,-0.8>,<-3,0.5,-0.6>, 1 pigment{preto}
    }
    cylinder{
      <-3,0.5,0.8>,<-3,0.5,0.6>, 1 pigment{preto}
    }
    scale <length/10.0,length/10.0,length/10.0>
    
  }
  
#end

#macro fileira_taxi(quantos, xorientation, center_pos)

  #local i=0;
  union{
    #while (i<quantos)

      object{ 
        make_taxi(10, color rgb <0.2,0.3,0.4> )
        #if (mod(i,2) = 0)
          translate <0,0,5*i>
        #else
          translate <0,0,-5*i>
        #end
      }

      #local i = i + 1;

    #end

    rotate xorientation*y
    translate center_pos
  }

#end



//vamos declarar objetos da cena:



#include "eixos.inc"

// Aqui está a cena, finalmente:

background {  myBgColor }

box { 
  <-100, 0, -100>, <100, 0.01, 100>
  pigment {
    checker vermelho, azul
  }
  
}

object{
  fileira_taxi(5, 0, <0,0,0> )
}

/*
camera {
  location <0, 10, -20>
  rotate -70*y
  look_at  <0, 0, 0>
}
*/

light_source { <10, 10, 0> branco }
light_source { <10, 10, 0> branco rotate 90*y }
light_source { <10, 10, 0> branco rotate 180*y }
light_source { <10, 10, 0> branco rotate 270*y }



#include "camlight.inc"
#declare centro_cena = < 0.00, 0.00, 1.00 >;
#declare raio_cena = 50;
#declare dir_camera = < 7.00, 7.00, 4.00 >;
#declare dist_camera = 100.0;
#declare intens_luz = 2.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
