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
/*
  ****************************************************************************************
  ****************************   MACRO CASA   *********************************************
  ****************************************************************************************
*/

#macro dom(obrot_y)
        // Definição da cor das paredes (amarelo açafrão)
        #local kolor_scian = <0.99609375, 0.66796875, 0.34765625>;  

        // Corpo principal da casa - combinação de cilindro e caixa
        #local glowna_bryla = union {
        // dimensões aproximadas 7.4 x 4 x 5.4
                  cylinder {
                    <-1.5, -2, 0>
                    <-1.5, 1.8, 0>
                    2
                    pigment {color kolor_scian}  // cor das paredes
                  }
                  box {
                    <-1.5, -2, -2>
                    <2, 1.8, 2>
                    pigment {color kolor_scian}  // cor das paredes
                  } 
                
                  // telhado da casa
                  cylinder {
                    <-1.5, 1.8, 0>
                    <-1.5, 2, 0>
                    2.2
                    pigment {color rgb <0.5, 0, 0>}  // cor vermelho escuro (telhado)
                  }
                  box {
                    <-1.7, 1.8, -2.7>
                    <2.2, 2, 2.7>
                    pigment {color rgb <0.5, 0, 0>}  // cor vermelho escuro (telhado)
                  }
        }

        // Espaço vazio dentro do prédio (interior da casa)
        #local puste = union {
          // interior da construção        
                cylinder {
                    <-1.5, -1.9, 0>
                    <-1.5, 1.7, 0>
                    1.9
                    // pigment {color Red}  // cor comentada, possivelmente usada para debug
                }
                box {
                  <-1.5, -1.9, -1.9>
                  <1.9, 1.7, 1.9>
                  // pigment {color Green}  // cor comentada, possivelmente usada para debug
                }
          // porta
                box {
                   <1, -1.9, -2.65>
                   <1.8, -0.3, -1.8>
                }
          // janelas
            // janelas superiores
                box {
                  <0.4, 0.65, -2.26>
                  <1.4, 1.5, -1.8>
                }
                box {
                  <-1, 0.9, -2.26>
                  <0, 1.5, 2.05>
                }
                // janelas laterais
                box {
                  <-5, 0.9, -0.5>
                  <5, 1.5, 0.5>
                }
            // janelas inferiores
                box {
                  <-1, -0.9, -2.26>
                  <0, -0.2, 2.05>
                }
                // janelas laterais inferiores
                box {
                  <-5, -0.9, -0.5>
                  <5, -0.2, 0.5>
                }               
         
        }
        
        // Varanda da casa
        #local balkon = union{
                box {
                  <-0.9, -0.1, -0.7>
                  <0.9, 0.1, 0.7>
                  pigment {color rgb kolor_scian}  // cor da varanda (mesma que paredes)
                }
                cylinder {
                  <-0.9, 0.5, -0.6>
                  <0.9, 0.5, -0.6>
                  0.06
                  pigment {color Brown}  // cor marrom (possivelmente corrimão)
                }
                // pilares da varanda espaçados em 0.3 unidades
                #local i=-0.82;
                #while (i<=0.82)
                        cylinder {
                          <i, 0.1, -0.6>
                          <i, 0.5, -0.6>
                          0.05
                          pigment {color rgb <0.5, 0, 0>} // cor ferrugem (vermelho escuro)
                        }
                        #local i= i+0.3;
                #end
        }

        // Parapeito da janela
        #local parapet = union {
          box {
            <-0.55, -0.1, -0.15>
            <0.55, 0.1, 0.15>
            //pigment {color rgb <0.99609375, 0.95703125, 0.88671875>} // cor perolada (comentada)
            pigment {color rgb <0.5, 0, 0>}  // cor vermelho escuro
          }
        }
        
        
        // Porta da casa
        #local drzwi = union {
                box {
                  <-0.4, -0.8, -0.05>
                  <0.4, 0.8, 0.05>
                  pigment {color rgb <0.5, 0, 0>} // cor ferrugem (vermelho escuro)
                }
        }
        
        // Estrutura da casa (corpo menos interior)
        #local szkielet_domu = difference {
                        #object {glowna_bryla}
                        #object {puste}
        }
        
        // Combinação de todos os componentes para formar a casa completa
        #local wszystko = union {
                object {szkielet_domu}
                object {balkon
                        translate <1, 0.5, -2>}
                object {drzwi
                        translate <1.37, -1.1, -2>}
                object {parapet
                        translate <-0.5, 0.8, -2.2>}
                object {parapet
                        translate <-0.5, -0.9, -2.2>}
       }
       // Exibe a casa com rotação em torno do eixo Y (vertical)
       object {wszystko rotate <0,  obrot_y, 0>}
#end