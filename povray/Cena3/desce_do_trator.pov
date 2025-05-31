// Inclui bibliotecas com formas geométricas pré-definidas
#include "shapes.inc"
// Inclui bibliotecas de texturas
#include "textures.inc"
// Inclui definições de cores
#include "colors.inc"
// Inclui texturas de madeira
#include "woods.inc"

// Cria o céu de fundo
sky_sphere {
  pigment {
    gradient z // Degradê no eixo Z (vertical)
    color_map {
      [0.5 color <0, 0.74609375, 0.99609375>] // Azul claro
      [1.0 color MidnightBlue]                // Azul escuro (meia-noite)
    }
    scale 2 // Escala do degradê
  }
  pigment {
    bozo // Textura aleatória tipo nuvem
    turbulence 0.9 // Turbulência da textura
    omega 0.7      // Fator de repetição
    color_map {
      [0.0 color rgb <0.85, 0.85, 0.85>] // Cinza claro
      [0.1 color rgb <0.75, 0.75, 0.75>] // Cinza médio
      [0.5 color rgbt <1,1,1,1>]         // Branco transparente
      [1.0 color rgbt <1,1,1,1>]         // Branco transparente
    }
    scale <0.6, 0.3, 0.3> // Escala da textura das nuvens
  }
  rotate <0,90,0> // Rotaciona a esfera do céu em 90° no eixo Y
}

// Cria o plano de chão
plane {
  y, 0 // Plano horizontal no eixo Y = 0
  pigment {color Green} // Cor verde para simular grama
}

// Primeira fonte de luz
light_source {
  <30, 10, -45> // Posição da luz
  color White   // Cor da luz: branca
  area_light <30, 5, 0>, <0, 0, 30>, 3, 3 // Luz de área (mais realista)
  adaptive 1 // Qualidade de suavização
  jitter     // Aleatoriza as amostras de luz para um efeito mais natural
}

// Segunda fonte de luz (luz geral de cena)
light_source {
  <10, 300, -500> // Posição da luz
  color White     // Cor branca
}

// Define a câmera da cena
camera {
  location <8, 2, 3>    // Posição da câmera
  look_at <0, 1, 1.5>   // Ponto para onde a câmera está olhando
}


/*
  ****************************************************************************************
  ************************   MACRO STRZELBA   ********************************************
  ****************************************************************************************
*/

// Macro que define um modelo de espingarda (strzelba)
#macro strzelba()

        // Define a cor da espingarda
        #local kolor_strzelby = Grey;

        // Cria a coronha (parte de trás que apoia no ombro)
        #local rekojesc = union {
                cone {
                  <0, 0, -2>, 0.5     // Base do cone na posição <0, 0, -2> com raio 0.5
                  <0, 0, 2>, 0.3      // Topo do cone na posição <0, 0, 2> com raio 0.3
                  scale <0.8, 1, 1>   // Deforma o cone no eixo X
                  pigment {color Brown} // Cor marrom para a coronha
                }        
        }

        // Cria a mira (parte da frente para apontar)
        #local celownik = union {
                torus {
                  0.3, 0.05 // Toro (anel) com raio maior 0.3 e menor 0.05
                  scale <1, 0.5, 1> // Deforma no eixo Y
                  pigment {color kolor_strzelby}
                }
                box {
                  <-0.03, -0.07, -0.3> // Caixa pequena na horizontal
                  <0.03, 0.07, 0.3>
                  pigment {color kolor_strzelby}
                }
                box {
                  <-0.3, -0.07, -0.03> // Caixa pequena na vertical
                  <0.3, 0.07, 0.03>
                  pigment {color kolor_strzelby}
                }
        }

        // Cria o cano da espingarda (parte principal)
        #local glownia = union {
                
                // Tubos por onde passam os projéteis
                difference {
                        union {
                                cylinder {
                                  <-0.25, 0, -3>
                                  <-0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                                cylinder {
                                  <0.25, 0, -3>
                                  <0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                        }
                        // Remove cilindros internos menores para formar os canos ocos
                        union {
                                cylinder {
                                  <-0.25, 0, -2.9>
                                  <-0.25, 0, 3.1>
                                  0.2
                                  pigment {color kolor_strzelby}
                                }
                                cylinder {
                                  <0.25, 0, -2.9>
                                  <0.25, 0, 3.1>
                                  0.2
                                  pigment {color kolor_strzelby}
                                }    
                        }
                }

                // Adiciona a mira na extremidade do cano
                object {
                  celownik
                  rotate <90, 0, 0>         // Rotaciona a mira para alinhar no eixo X
                  translate <0, 0.7, 3>     // Posiciona a mira na ponta do cano
                }

                // Adiciona a coronha na parte traseira
                object {
                  rekojesc
                  translate <0,0,-2>        // Move a coronha para trás
                  rotate <-3, 0, 0>         // Inclina levemente para baixo
                  translate <0, 0, -3>      // Move novamente para posicionamento final
                }
        }

        // Insere a glownia (parte principal da espingarda) na cena
        object {glownia}

#end


/*
  ****************************************************************************************
  ****************************   MACRO DOM   *********************************************
  ****************************************************************************************
*/

// Macro para modelar uma casa (dom) com rotação em torno do eixo Y
#macro dom(obrot_y)

        // Cor das paredes — amarelo açafrão
        #local kolor_scian = <0.99609375, 0.66796875, 0.34765625>;

        // Estrutura principal da casa
        #local glowna_bryla = union {
                // Corpo principal — cilindro lateral
                cylinder {
                    <-1.5, -2, 0>
                    <-1.5, 1.8, 0>
                    2
                    pigment {color kolor_scian}
                }
                // Corpo principal — caixa retangular
                box {
                    <-1.5, -2, -2>
                    <2, 1.8, 2>
                    pigment {color kolor_scian}
                }

                // Telhado
                cylinder {
                    <-1.5, 1.8, 0>
                    <-1.5, 2, 0>
                    2.2
                    pigment {color rgb <0.5, 0, 0>}
                }
                box {
                    <-1.7, 1.8, -2.7>
                    <2.2, 2, 2.7>
                    pigment {color rgb <0.5, 0, 0>}
                }
        }

        // Aberturas internas (puste) — cavidades e janelas
        #local puste = union {
                // Interior do prédio
                cylinder {
                    <-1.5, -1.9, 0>
                    <-1.5, 1.7, 0>
                    1.9
                    // pigment {color Red}
                }
                box {
                  <-1.5, -1.9, -1.9>
                  <1.9, 1.7, 1.9>
                  // pigment {color Green}
                }

                // Porta
                box {
                   <1, -1.9, -2.65>
                   <1.8, -0.3, -1.8>
                }

                // Janelas
                // Superiores
                box {
                  <0.4, 0.65, -2.26>
                  <1.4, 1.5, -1.8>
                }
                box {
                  <-1, 0.9, -2.26>
                  <0, 1.5, 2.05>
                }
                // Laterais superiores
                box {
                  <-5, 0.9, -0.5>
                  <5, 1.5, 0.5>
                }
                // Inferiores
                box {
                  <-1, -0.9, -2.26>
                  <0, -0.2, 2.05>
                }
                // Laterais inferiores
                box {
                  <-5, -0.9, -0.5>
                  <5, -0.2, 0.5>
                }
        }

        // Varanda (balkon)
        #local balkon = union {
                // Base da varanda
                box {
                  <-0.9, -0.1, -0.7>
                  <0.9, 0.1, 0.7>
                  pigment {color rgb kolor_scian}
                }
                // Corrimão horizontal
                cylinder {
                  <-0.9, 0.5, -0.6>
                  <0.9, 0.5, -0.6>
                  0.06
                  pigment {color Brown}
                }
                // Barras verticais
                #local i=-0.82;
                #while (i<=0.82)
                        cylinder {
                          <i, 0.1, -0.6>
                          <i, 0.5, -0.6>
                          0.05
                          pigment {color rgb <0.5, 0, 0>} // cor ferrugem
                        }
                        #local i= i+0.3;
                #end
        }

        // Parapeito de janela (parapet)
        #local parapet = union {
          box {
            <-0.55, -0.1, -0.15>
            <0.55, 0.1, 0.15>
            // pigment {color rgb <0.99609375, 0.95703125, 0.88671875>} // cor perolada
            pigment {color rgb <0.5, 0, 0>}
          }
        }

        // Porta (drzwi)
        #local drzwi = union {
                box {
                  <-0.4, -0.8, -0.05>
                  <0.4, 0.8, 0.05>
                  pigment {color rgb <0.5, 0, 0>} // cor ferrugem
                }
        }

        // Estrutura da casa com as aberturas internas removidas
        #local szkielet_domu = difference {
                object {glowna_bryla}
                object {puste}
        }

        // União de todos os elementos da casa
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

        // Insere tudo na cena, aplicando a rotação informada em Y
        object {wszystko rotate <0, obrot_y, 0>}
#end


// Caixa mínima para evitar cena vazia
box {
<-100, -100, -100>
<-99, -99, -99>
}


/*
  ****************************************************************************************
  ************************   MACRO TRAKTOR   *********************************************
  ****************************************************************************************
*/

#macro traktor(_obr)
    // Definição da estrutura da roda
    #local kolo = union {

        // *** pneu + cortando um cilindro para formar a calota ***
        difference {
            torus {
              0.6, 0.4
              rotate <0, 0, 90>
              pigment {color rgb<0.3, 0.3, 0.3>}
            }
            cylinder {
              <-0.45, 0, 0>
              <0.45, 0, 0>
              0.549
              pigment {color rgb <0.7, 0.7, 0.7>}
            }
        }
        
        #local r=0;

        #while (r<=360)
        // *** saliência do pneu ***
            intersection {
                difference {
                    box {
                      <-0.4, -0.05, -1.1>
                      <0.4, 0.05, 1.1>
                      rotate <r, 0, 0>
                      pigment {color rgb<0.3, 0.3, 0.3>}
                    }
                    cylinder {
                      <-1,0,0>, <1,0,0>, 0.6
                    }
                } // fim do difference
                torus {
                    0.7, 0.43
                    rotate <0, 0, 90>
                    pigment {color rgb<0.3, 0.3, 0.3>}
                }
            }
            
        // *** calota ***
            difference {
                cylinder {
                  <-0.4, 0, 0>
                  <0.4, 0, 0>
                  0.55
                  pigment {color rgb <0.7, 0.7, 0.7>}
                }
                union {
                    cylinder {
                      <-0.5, 0, 0>
                      <-0.3, 0, 0>
                      0.4
                      pigment {color rgb <0.7, 0.7, 0.7>}
                    }
                    cylinder {
                      <0.5, 0, 0>
                      <0.3, 0, 0>
                      0.4
                      pigment {color rgb <0.7, 0.7, 0.7>}
                    }
                    // aberturas para parafusos da calota
                } // fim do union
            }
            
            #local r = r + 40;
        #end  // fim do while

    }  // fim do local 'kolo'

    // Definição da estrutura do volante (2 partes)
    #local kierownica = union {
        torus {
          0.5, 0.1
          pigment {color Grey}
          scale <1, 0.5, 1>
          rotate <90, 0, 0>
        }
        
        sphere {
          <0,0,0>
          0.2
          pigment {color Grey}
          scale <1, 1, 0.25>
        }
        
        box {
          <-0.5, -0.1, -0.04>
          <0.5, 0.1, 0.04>
          pigment {color Grey}
        }
        box {
          <-0.5, -0.1, -0.04>
          <0.5, 0.1, 0.04>
          rotate <0, 0, 90>
          pigment {color Grey}
        }
    }

    // Coluna de direção onde o volante está apoiado
    #local to_cos_na_czym_stoi_kierownica = union {
        cylinder {
          <0, 0, -0.6>
          <0, 0, 0.6>
          0.08
          pigment {color Grey}
        }
        object {
          kierownica
          rotate <0, 0, sin(clock*10)> // animação de giro do volante
          translate <0, 0, 0.65>
        }
    }

    // Assento do trator
    #local siedzenie_traktora_siedzisko = union {
        box {
          < -0.5,  -0.05, -0.2>
          < 0.5, 0.05, 0.2>
          pigment {color Grey}
        }
    }

    // Encosto do assento do trator
    #local siedzenie_traktora_oparcie = union {
        box {
          < -0.5, -0.5, -0.1>
          < 0.5, 0.5, 0.1>
          pigment {color Grey}
        }
        object {
          siedzenie_traktora_siedzisko
          translate <0, -0.35, -0.25>
        }
    }

    // Cabine do trator
    #local kabina = union {
        difference {
            box {
              < -0.7, -1, -0.9>
              < 0.7, 1, 0.9>
              pigment {color Red}
            }
            
            union {
                // parede traseira inclinada
                box {
                  <-2.7, -1.3, -0.6>
                  < 2.7, 1.3, 0.6>
                  rotate <-10, 0, 0>
                  translate <0, 0, 1.5>
                  pigment {color Red}
                }
                // vidro dianteiro e traseiro
                box {
                  < -0.6, -0.3, -2>
                  < 0.6, 0.9, 2>
                  pigment {color Red}
                }
                // vidros laterais
                box {
                  < -1, -0.6, -0.8>
                  < 1, 0.9, 0.3>
                  pigment {color Red}
                }
            }
        }

        // adiciona a coluna com o volante
        object {
          to_cos_na_czym_stoi_kierownica
          scale <0.3, 0.3, 0.3>
          translate <0, 0, 0.15>
          rotate <-40,0, 0>
          translate <0, -0.1, -0.9>
        }

        // adiciona o assento
        object {
          siedzenie_traktora_oparcie
        }
    }

    // Faróis do trator
    #local swiatla_traktora = union {
        box {
          <-0.2, -0.2, -0.4>
          <0.2, 0.2, -0.4>
          pigment {color Yellow}
        }                
    }

    // Capô do trator
    #local maska = union {
       difference {
           box {
             <-0.7, -0.6, 1.25>
             <0.7, 0.6, -1.25>
             pigment {color Red}
           }
           // removendo a parte que invade a cabine
           box {
            <-0.8, -0.7, 0.8>
             <0.8, 0.7, 1.27>
             pigment {color Red}
           }
       }

       // adiciona a cabine sobre o capô
       object {
         kabina translate <0, 0.5, 1.65>
       }

       // adiciona os faróis
       object {
         swiatla_traktora
         translate <-0.4, -0.1, -0.9>
       }
       object {
         swiatla_traktora
         translate <0.4, -0.1, -0.9>
       }

       // adiciona as rodas dianteiras
       object {
         kolo rotate <_obr, 0, 0>
         translate <-0.95, -0.3, 2.25>
       }
       object {
         kolo rotate <_obr, 0, 0>
         translate <0.95, -0.3, 2.25>
       }

       // adiciona as rodas traseiras (menores)
       object {
         kolo
         scale <0.7, 0.7, 0.7>
         translate <-0.95, -0.6, -0.25>
       }
       object {
         kolo
         scale <0.7, 0.7, 0.7>
         translate <0.95, -0.6, -0.25>
       }
    }

    // finalmente, desenha todo o conjunto da máscara (parte frontal com cabine e rodas)
    object {maska}

#end


/*
  ****************************************************************************************
  ************************   MACRO DRZEWO   **********************************************
  ****************************************************************************************
*/

// Definição da macro 'drzewo' (árvore)
#macro drzewo()

        // Definição da copa da árvore — uma esfera verde com relevo (bumps)
        #local korona = sphere {
          <0,0,0> // centro da esfera
          0.4     // raio
          pigment {color Green}
          normal {
            bumps 1 // textura de relevo na superfície
            scale 0.1
          }
        }

        // Definição de um galho — cilindro + copa
        #local galaz = union {
                cylinder {
                  <0, -0.9, 0> // ponto inicial
                  <0, 0.9, 0>  // ponto final
                  0.1          // raio
                  pigment {color Brown}
                }
                // Adiciona a copa no topo do galho
                object {
                  korona
                  translate <0, 0.5, 0>
                } 
        }

        // Definição do tronco da árvore — cilindro + vários galhos conectados
        #local pien = union {
                cylinder {
                  <0, -1, 0>  // ponto inicial
                  <0, 1, 0>   // ponto final
                  0.4         // raio
                  pigment {color Brown}
                }

                // *** Extensões do tronco (galhos maiores) ***
                object {
                  galaz
                  scale <1.5, 1.5, 1.5>
                  translate <0, 1.5, 0>
                  rotate <15, 0, 20>
                  translate <-0.2, 0.2, 0>
                }
                object {
                  galaz
                  scale <2, 1.7, 2>
                  translate <0, 1.7, 0>
                  rotate <5, 0, -10>
                  translate <-0.2, 0.2, 0>
                }

                // *** Galhos menores ***
                object {
                  galaz
                  translate <0, 0.6, 0>
                  rotate <0, 0, 40>
                  translate <-0.2, 0, 0>
                }
                object {
                  galaz
                  translate <0, 0.8, 0>
                  rotate <0, 0, 40>
                  rotate <0, 90, 0>
                  translate <0, 0, -0.2>
                }
                object {
                  galaz
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  translate <-0.2, 0.2, 0>
                }
                object {
                  galaz
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  rotate <0, 40, 0>
                  translate <-0.2, 0.2, 0>
                }
        }

        // Exibe o tronco com os galhos
        object {
          pien
        }
#end


/*
  ****************************************************************************************
  ************************   MACRO BOHATER   *********************************************
  ****************************************************************************************
*/

// Definição da macro 'bohater' (herói/personagem)
#macro bohater()

        // Definição das cores principais do personagem
        #local Kolor_skory = Yellow;     // Cor da pele
        #local Kolor_koszuli = Blue;     // Cor da camisa
        #local Kolor_spodni = Green;     // Cor da calça

        // Definição de um dedo
        #local palec = union {
                cylinder {
                  <0,-0.03, 0>
                  <0, 0.03, 0>                  
                  0.015
                  pigment {color Kolor_skory}
                }
        }

        // Definição da mão
        #local dlon = union {
                // Palma da mão
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.3, 1, 1>
                  pigment {color Kolor_skory}
                }
                // Dedos — na ordem do polegar ao mindinho
                object {
                  palec
                  translate <0, -0.03, 0>
                  rotate <50, 0, 0>
                  translate <0, 0.01, -0.08>
                }
                object {
                  palec
                  translate <0, -0.08, -0.07>
                }
                object {
                  palec
                  translate <0, -0.1, -0.03>
                }
                object {
                  palec
                  translate <0, -0.09, 0.02>
                }
                object {
                  palec
                  translate <0, -0.07, 0.06>
                }
                // Adiciona a espingarda (strzelba)
                object {
                  strzelba()
                  scale <0.1, 0.1, 0.1>
                  rotate <90, 0, 0>
                  rotate <0, 180 , 0>
                  translate <0, -0.5, -0.05>
                }
        }

        // Definição do antebraço
        #local przedramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Kolor_koszuli}
                }
                // Adiciona a mão na ponta do antebraço
                object {
                  dlon
                  translate <0, -0.3, 0>
                }      
        }

        // Definição do braço
        #local ramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_koszuli}
                }
                // Conecta o antebraço ao braço
                object {
                  przedramie
                  translate <0, -0.2, 0>
                  rotate <120, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }

        // Definição da articulação do ombro
        #local staw_ramienny = union {
                sphere {
                  <0,0,0>
                  0.13
                  pigment {color Kolor_koszuli}
                }
                // Adiciona o braço (direito)
                object {
                  ramie
                  rotate <5,0,0>
                  translate <0, -0.2, 0>
                }
        }

        // Definição do olho
        #local oko = union {
                // Globo ocular
                sphere {
                  <0,0,0>
                  0.05
                  pigment {color White}
                }
                // Pupila
                sphere {
                  <0,0,0>
                  0.02
                  translate <0, 0, -0.04>
                  pigment {color Black}
                }
        }

        // Definição da cabeça
        #local glowa = union {
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Kolor_skory}
                }
                // Olho esquerdo
                object {
                  oko
                  translate <-0.07, 0, -0.16>
                }
                // Olho direito
                object {
                  oko
                  translate <0.07, 0, -0.16>
                }
        }

        // Definição do pescoço
        #local szyja = union {
                cylinder {
                  <0, -0.08, 0>
                  <0, 0.08, 0>
                  0.05
                  pigment {color Kolor_skory}
                }
                // Conecta a cabeça ao pescoço
                object {
                  glowa
                  translate <0, 0.25, 0>
                }
        }

        // Definição do capuz
        #local kaptury = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1.5, 1, 0.8>
                  pigment {color Kolor_koszuli}
                }
        }

        // Definição das costas
        #local plecy = union {
                sphere {
                  <0,0,0>
                  0.3
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}
                }
        }

        // Definição de metade do tórax
        #local polowa_klaty = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}
                }
        }

        // Definição do pé
        #local stopa = union {
                box {
                  <-0.1, -0.05, -0.15>
                  <0.1, 0.05, 0.15>
                  pigment {color Red}         
                }
        }

        // Definição da perna inferior (canela)
        #local podudzie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Red}
                }
                // Adiciona o pé na ponta
                object {
                  stopa
                  translate <0, -0.23, -0.08>
                }       
        }

        // Definição da coxa
        #local udo = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_spodni}
                }
                // Conecta a perna inferior à coxa
                object {
                  podudzie
                  translate <0, -0.2, 0>
                  rotate <-110, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }

        // Definição da pelve
        #local miednica = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <0, 0.85, 0.9>
                  pigment {color Kolor_spodni}
                }
                // Coxa esquerda
                object {
                  udo
                  translate <0, -0.2, 0>
                  rotate <110, 0, -5>
                  translate <-0.1, -0.05, 0>
                }
                // Coxa direita
                object {
                  udo
                  translate <0, -0.2, 0>
                  rotate <110, 0, 5>
                  translate <0.1, -0.05, 0>
                }
        }

        // Definição do tronco
        #local korpus = union {
                cylinder {
                  <0, -0.3, 0>
                  <0, 0.3, 0>
                  0.15
                  pigment {color Kolor_koszuli}
                }
                // Pescoço e cabeça
                object {
                  szyja
                  translate <0, 0.52, 0>
                }
                // Capuz
                object {
                  kaptury
                  translate <0, 0.35, 0.05>
                }
                // Costas
                object {
                  plecy
                  translate <0, 0.23, 0.1>
                }
                // Pelve
                object {
                  miednica
                  translate <0, -0.25, 0>
                }
                // Metade esquerda do tórax
                object {
                  polowa_klaty
                  translate <-0.07, 0.3, -0.1>
                }
                // Metade direita do tórax
                object {
                  polowa_klaty
                  translate <0.07, 0.3, -0.1>
                }
                // Braço direito
                object {
                  staw_ramienny
                  rotate <0, 0, -30>
                  translate <-0.3, 0.35, 0>
                }
                // Braço esquerdo
                object {
                  staw_ramienny
                  rotate <0, 0, 30>
                  translate <0.3, 0.35, 0>
                }
        }

        // Renderiza o personagem completo
        object {
          korpus
        }
#end


/*
  ****************************************************************************************
  *************************   FUNÇÃO PRINCIPAL   *****************************************
  ****************************************************************************************
*/

// Adiciona o objeto 'traktor' na cena com escala e posição específicas
object {
  traktor(0)                      // Chama a função 'traktor' com parâmetro 0
  scale <1.3, 1.3, 1.3>           // Aumenta o tamanho do trator
  translate <0, 1.7>              // Move o trator para cima na cena
}

// Define uma variável local 'i' baseada no tempo da animação (clock*2)
#local i = clock*2;

// Adiciona o personagem 'bohater' na cena
object {
  bohater()                       // Chama a macro 'bohater' para desenhar o personagem
  rotate <0, -90, 0>              // Rotaciona o personagem em -90° no eixo Y
  translate <0+i, 2.4-(i/2), 1.5> // Move o personagem pela cena de acordo com o tempo
}


// ******  CENÁRIO  ******

// Cria uma variável local para controlar o número de casas e árvores adicionadas
#local kolejne_domy = 0;

// Enquanto a variável for menor que 2, repete a adição de elementos no cenário
#while (kolejne_domy<2)
        object {
          dom(-10)                                // Chama a função 'dom' com parâmetro -10 (talvez posição ou estado)
          scale <10,10,10>                        // Aumenta o tamanho da casa
          rotate <0, -90, 0>                      // Rotaciona a casa em -90° no eixo Y
          translate <-100, 20, 50-(kolejne_domy*100)> // Posiciona a casa com espaçamento no eixo Z
        }
        object {
          drzewo()                                // Chama a função 'drzewo' para desenhar uma árvore
          scale <10,10,10>                        // Aumenta o tamanho da árvore
          translate <-100, 10, -(kolejne_domy*100)> // Posiciona a árvore com espaçamento no eixo Z
        }
        #local kolejne_domy = kolejne_domy+1;      // Incrementa a variável para a próxima iteração
#end
