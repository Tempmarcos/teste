/*
  ****************************************************************************************
  ************************   MACRO ÁRVORE   **********************************************
  ****************************************************************************************
*/

#macro arvore()
        // folhas da árvore - uma esfera verde com textura irregular
        #local folhas = sphere {
          <0,0,0>
          0.4
          pigment {color Green}  // pigmento verde
          normal {
            bumps 1               // textura com relevo
            scale 0.1             // escala da textura
          }
        }

        // Galho da árvore - cilindro marrom com uma coroa no topo
        #local tronco = union {
                cylinder {
                  <0, -0.9, 0>
                  <0, 0.9, 0>
                  0.1
                  pigment {color Brown} // pigmento marrom (cor de madeira)
                }
                object {
                  folhas                // adiciona a coroa ao topo do galho
                  translate <0, 0.7, 0> // posiciona a coroa acima do cilindro
                } 
        }

        // Tronco da árvore com ramificações maiores e menores
        #local galho = union {
                cylinder {
                  <0, -1, 0>
                  <0, 1, 0>
                  0.4
                  pigment {color Brown} // pigmento marrom do tronco
                }
                // Extensões do tronco - galhos maiores
                object {
                  tronco
                  scale <1.5, 1.5, 1.5> // aumenta o tamanho do galho
                  translate <0, 1.5, 0> // posiciona mais acima no tronco
                  rotate <15, 0, 20>    // rotaciona o galho
                  translate <-0.2, 0.2, 0> // pequeno ajuste na posição
                }
                object {
                  tronco
                  scale <2, 1.7, 2>     // galho maior e mais largo
                  translate <0, 1.7, 0>
                  rotate <5, 0, -10>
                  translate <-0.2, 0.2, 0>
                }
                // Galhos menores
                object {
                  tronco
                  translate <0, 0.6, 0>
                  rotate <0, 0, 40>
                  rotate <0, 90, 0>     // comentado: possível rotação adicional
                  translate <-0.2, 0, 0>
                }
                object {
                  tronco
                  translate <0, 0.8, 0>
                  rotate <0, 0, 40>
                  rotate <0, 90, 0>      // rotação em Y para orientação lateral
                  translate <0, 0, -0.2>
                }
                object {
                  tronco
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  translate <-0.2, 0.2, 0>
                }
                object {
                  tronco
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  rotate <0, 40, 0>
                  translate <-0.2, 0.2, 0>
                }
        }

        // Desenha o tronco com seus galhos
        object {
          galho
        }
#end

/*
  ****************************************************************************************
  ************************   MACRO ANCINHO   *********************************************
  ****************************************************************************************
*/
#macro grabie()
        // Dente do ancinho - forma cônica cinza
        #local zab = cone {
          <0, -0.1, 0>, 0.04
          <0, 0.1, 0>, 0
          pigment {color Grey}
        }
        // Extensão do dente - cilindro cinza com o dente no topo
        #local przedluzenieZeba = union {
          cylinder {
            <0,0.2,0>
            <0,-0.2,0>
             0.04
            pigment{color Grey}
          }
          object {
              zab
              translate <0, 0.3, 0>
          }
        }
        // Barra transversal do ancinho, contendo vários dentes espaçados
        #local poprzeczka = union {
          box {
            <1, 0.101, 0.08>
            <-1, -0.101, -0.08>
            pigment {color Grey}
          }
          
          #local i=-1;
          #local odleglosc=0.25; // distância entre dentes
          #while ((i+odleglosc)<=(1+odleglosc))
                object {
                        przedluzenieZeba
                        translate <0+i , 0.2, 0>
                }
                #local i = i+odleglosc;       
          #end
        }
        // Suporte do cabo - cilindro branco (madeira branca)
        #local podporka = cylinder {
                <0,0,0.4>, <0,0,-0.4>, 0.06  
                pigment {White_Wood}
        }
        // Cabo do ancinho - cilindro longo com dois suportes laterais e a barra transversal no topo
        #local kij = union {
          cylinder {
            <0,0,2>
            <0,0,-2>
            0.1
            pigment {White_Wood}
          }
          object {
                podporka         
                translate <0,0,-0.3>
                rotate <0, -120, 0>
                translate <0.1,0,1.6>
          }
          object {
                podporka         
                translate <0,0,0.3>
                rotate <0, -60, 0>
                translate <-0.1,0,1.6>
          }
          object {
                poprzeczka
                translate <0,0,2>
          }
        }
        
        // Desenha o ancinho completo (cabo com suportes e barra transversal com dentes)
        object {kij}
#end


/*
  ****************************************************************************************
  ************************   MACRO REGADOR   *********************************************
  ****************************************************************************************
*/
#macro konewka()
        // Funil do regador - forma cônica verde com uma pequena área interna subtraída (diference)
        #local lejek = difference {
                cone {
                  <0,0.1,0> , 0.01 
                  <0,-0.1,0> , 0.05
                  pigment {color Green}
                }
                union {
                        cone {
                          <0,0.101,0> , 0.008 
                          <0,-0.09,0> , 0.03
                          pigment {color Green}
                        }
                        box {
                          <0.1, 0.1, 0.>
                          <-0.1, -0.1, -0.1>
                          rotate <45,0,0>
                          translate <0, 0.8, 0>
                        }
                }
        }
        // Corpo principal do regador - cilindro verde com um toro e o funil posicionado
        #local srodek = union {
                cylinder {
                  <0,0.1,0>
                  <0,-0.1,0>
                  0.1
                  pigment {color Green}
                }
                torus {
                  0.07, 0.012
                  rotate <90, 90, 0>
                  scale <1, 1.3, 1>
                  translate <0,0.04,-0.16>
                  pigment {color Green}
                }
                object {
                  lejek
                  translate <0,0.08,0>
                  rotate <50, 0,0>
                  translate <0,0,0.05> 
                }
        }
        // Desenha o regador completo
        object {srodek}
#end
