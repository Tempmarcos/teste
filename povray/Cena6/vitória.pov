// Inclui arquivos de definição de formas, texturas, cores e madeiras
#include "shapes.inc"
#include "textures.inc"
#include "colors.inc"
#include "woods.inc"

// Definição da esfera celeste (céu)
sky_sphere {
  // Primeiro pigmento: gradiente vertical (eixo z)
  pigment {
    gradient z
    color_map {
      [0.5 color <0, 0.74609375, 0.99609375>] // Cor do céu azul claro
      [1.0 color MidnightBlue]                // Cor do céu azul escuro
    }
    scale 2   // Escala do gradiente
  }

  // Segundo pigmento: padrão bozo (manchas aleatórias tipo nuvens)
  pigment {
    bozo                              // Tipo de padrão: manchado/aleatório
    turbulence 0.9                    // Nível de distorção do padrão
    omega 0.7                         // Fator de detalhamento da turbulência
    color_map {
      [0.0 color rgb <0.85, 0.85, 0.85>]   // Cinza claro
      [0.1 color rgb <0.75, 0.75, 0.75>]   // Cinza um pouco mais escuro
      [0.5 color rgbt <1,1,1,1>]           // Branco totalmente transparente
      [1.0 color rgbt <1,1,1,1>]           // Branco totalmente transparente
    }
    scale <0.6, 0.3, 0.3>              // Escala do padrão bozo
  }
  rotate <0,90,0>                      // Rotaciona o céu em 90° no eixo Y
}

// Define um plano infinito no eixo Y (chão)
plane {
  y, 0
  pigment {color Green}                // Cor verde (gramado ou solo)
}

// Primeira fonte de luz
light_source {
  <30, 10, -45>                        // Posição da luz no espaço
  color White                          // Cor da luz branca
  area_light <30, 5, 0>, <0, 0, 30>, 3, 3  // Luz de área com dimensões e subdivisões
  adaptive 1                           // Nível de suavização das sombras
  jitter                               // Adiciona aleatoriedade para sombras mais naturais
}

// Segunda fonte de luz (luz do céu)
light_source {
  <10, 300, -500>                      // Posição bem acima, simulando iluminação geral
  color White                          // Cor da luz branca
}

// Define a câmera
camera {
  location <5, 2, 1>                   // Posição da câmera no espaço
  look_at <1, 1, 1.5>                  // Ponto para onde a câmera está apontando
}


/*
  ****************************************************************************************
  ****************************   MACRO CASA   ********************************************
  ****************************************************************************************
*/

#macro dom(obrot_y) // Macro que desenha uma casa, recebendo a rotação no eixo Y como parâmetro

    // Cor das paredes: amarelo açafrão
    #local kolor_scian = <0.99609375, 0.66796875, 0.34765625>;  

    // Estrutura principal da casa
    #local glowna_bryla = union {
        // Cilindro lateral (talvez torre ou pilar)
        cylinder {
            <-1.5, -2, 0>
            <-1.5, 1.8, 0>
            2
            pigment {color kolor_scian}
        }

        // Bloco central da casa
        box {
            <-1.5, -2, -2>
            <2, 1.8, 2>
            pigment {color kolor_scian}
        }

        // Telhado (parte superior)
        cylinder {
            <-1.5, 1.8, 0>
            <-1.5, 2, 0>
            2.2
            pigment {color rgb <0.5, 0, 0>}
        }

        // Bloco superior do telhado
        box {
            <-1.7, 1.8, -2.7>
            <2.2, 2, 2.7>
            pigment {color rgb <0.5, 0, 0>}
        }
    }

    // Definição dos espaços vazios (interior da casa)
    #local puste = union {
        // Interior do prédio
        cylinder {
            <-1.5, -1.9, 0>
            <-1.5, 1.7, 0>
            1.9
            //pigment {color Red}
        }
        box {
            <-1.5, -1.9, -1.9>
            <1.9, 1.7, 1.9>
            //pigment {color Green}
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

    // Varanda
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

        // Barras verticais do corrimão
        #local i=-0.82;
        #while (i<=0.82)
            cylinder {
                <i, 0.1, -0.6>
                <i, 0.5, -0.6>
                0.05
                pigment {color rgb <0.5, 0, 0>} // Cor ferrugem
            }
            #local i= i+0.3;
        #end
    }

    // Peitoril de janela
    #local parapet = union {
        box {
            <-0.55, -0.1, -0.15>
            <0.55, 0.1, 0.15>
            //pigment {color rgb <0.99609375, 0.95703125, 0.88671875>} // Cor perolada
            pigment {color rgb <0.5, 0, 0>}
        }
    }

    // Porta da frente
    #local drzwi = union {
        box {
            <-0.4, -0.8, -0.05>
            <0.4, 0.8, 0.05>
            pigment {color rgb <0.5, 0, 0>} // Cor ferrugem
        }
    }

    // Diferença entre a estrutura principal e os espaços vazios (forma o esqueleto da casa)
    #local szkielet_domu = difference {
        object {glowna_bryla}
        object {puste}
    }

    // União de todos os elementos da casa
    #local wszystko = union {
        object {szkielet_domu}
        object {balkon translate <1, 0.5, -2>}
        object {drzwi translate <1.37, -1.1, -2>}
        object {parapet translate <-0.5, 0.8, -2.2>}
        object {parapet translate <-0.5, -0.9, -2.2>}
    }

    // Exibe o objeto completo, com a rotação definida
    object {wszystko rotate <0, obrot_y, 0>}
#end


/*
  ****************************************************************************************
  ************************   MACRO ÁRVORE   **********************************************
  ****************************************************************************************
*/

#macro drzewo() // Macro que desenha uma árvore

    // Definição da copa (parte de cima da árvore)
    #local korona = sphere {
        <0,0,0>
        0.4
        pigment {color Green} // Cor verde para a copa
        normal {
            bumps 1 // Pequenos relevos na superfície
            scale 0.1
        }
    }

    // Definição de um galho (tronco fino com uma copa na ponta)
    #local galaz = union {
        cylinder {
            <0, -0.9, 0>
            <0, 0.9, 0>
            0.1
            pigment {color Brown} // Cor marrom para o galho
        }
        object {
            korona
            translate <0, 0.5, 0> // Posiciona a copa acima do galho
        }
    }

    // Definição do tronco principal e seus galhos
    #local pien = union {
        // Tronco principal
        cylinder {
            <0, -1, 0>
            <0, 1, 0>
            0.4
            pigment {color Brown} // Cor marrom para o tronco
        }

        // Extensões do tronco
        // (wydluzenia pnia = extensões do tronco)
        object {
            galaz
            scale <1.5, 1.5, 1.5> // Escala maior
            translate <0, 1.5, 0> // Move para cima
            rotate <15, 0, 20>    // Rotaciona para variar a posição
            translate <-0.2, 0.2, 0>
        }
        object {
            galaz
            scale <2, 1.7, 2>     // Escala ainda maior
            translate <0, 1.7, 0>
            rotate <5, 0, -10>
            translate <-0.2, 0.2, 0>
        }

        // Galhos menores
        // (mniejsze galezie = galhos menores)
        object {
            galaz
            translate <0, 0.6, 0>
            rotate <0, 0, 40>
            //rotate <0, 90, 0> // Comentado, caso queira rotacionar no futuro
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

    // Exibe a árvore completa
    object {
        pien
    }

#end


/*
  ****************************************************************************************
  ************************   MACRO ESPINGARDA   ******************************************
  ****************************************************************************************
*/

#macro strzelba() // Macro que desenha uma espingarda

    // Definindo a cor principal da espingarda
    #local kolor_strzelby = Grey;

    // Definição da coronha (rekojeść = empunhadura/coronha)
    #local rekojesc = union {
        cone {
            <0, 0, -2>, 0.5       // Base da coronha
            <0, 0,  2>, 0.3       // Ponta da coronha
            scale <0.8, 1, 1>     // Deixa o cone mais achatado nas laterais
            pigment {color Brown} // Cor marrom para a madeira
        }
    }

    // Definição da mira (celownik = mira)
    #local celownik = union {
        torus {
            0.3, 0.05             // Diâmetro externo 0.3, interno 0.05
            scale <1, 0.5, 1>     // Achatada no eixo Y
            pigment {color kolor_strzelby}
        }
        box {
            <-0.03, -0.07, -0.3>
            <0.03,  0.07,  0.3>
            pigment {color kolor_strzelby}
        }
        box {
            <-0.3, -0.07, -0.03>
            <0.3,  0.07,  0.03>
            pigment {color kolor_strzelby}
        }
    }

    // Definição do cano da espingarda (glownia = parte principal)
    #local glownia = union {
        
        // Apenas os tubos pelos quais os projéteis passam
        // (same te rurki przez ktore przechodza pociski)
        difference {
            union {
                // Cano esquerdo
                cylinder {
                    <-0.25, 0, -3>
                    <-0.25, 0,  3>
                    0.3
                    pigment {color kolor_strzelby}
                }
                // Cano direito
                cylinder {
                    <0.25, 0, -3>
                    <0.25, 0,  3>
                    0.3
                    pigment {color kolor_strzelby}
                }
            }
            union {
                // Parte oca do cano esquerdo
                cylinder {
                    <-0.25, 0, -2.9>
                    <-0.25, 0,  3.1>
                    0.2
                    pigment {color kolor_strzelby}
                }
                // Parte oca do cano direito
                cylinder {
                    <0.25, 0, -2.9>
                    <0.25, 0,  3.1>
                    0.2
                    pigment {color kolor_strzelby}
                }
            }
        }

        // Adiciona a mira na ponta da espingarda
        object {
            celownik
            rotate <90, 0, 0>      // Rotaciona para ficar na posição correta
            translate <0, 0.7, 3>  // Move a mira para o topo e frente
        }

        // Adiciona a coronha na parte de trás
        object {
            rekojesc
            translate <0, 0, -2>   // Move para trás
            rotate <-3, 0, 0>      // Inclina levemente
            translate <0, 0, -3>   // Move ainda mais para trás
        }
    }

    // Exibe a espingarda completa
    object {glownia}

#end


/*
  ****************************************************************************************
  ************************   MACRO TRAKTOR   *********************************************
  ****************************************************************************************
*/

#macro traktor(_obr)   // Definição da macro 'traktor' que recebe um parâmetro de rotação '_obr'

// Criação da roda
#local kolo = union {

    // *** pneu + furo para as rodas ***
    difference {
        torus {
            0.6, 0.4
            rotate <0, 0, 90>
            pigment {color rgb<0.3, 0.3, 0.3>}  // Cor cinza escuro
        }
        cylinder {
            <-0.45, 0, 0>
            <0.45, 0, 0>
            0.549
            pigment {color rgb <0.7, 0.7, 0.7>} // Cor cinza claro (parte da roda)
        }
    }

    #local r=0;

    // Criando os ressaltos do pneu (rodas com textura)
    #while (r<=360)
        // *** ressalto do pneu ***
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

        // *** cubo da roda (parte central) ***
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
                // espaços para parafusos das rodas
            } // fim do union
        }

        #local r = r + 40;
    #end  // fim do while

}  // fim do local 'kolo'

// Definição da direção (volante)
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

#local to_cos_na_czym_stoi_kierownica = union {
    cylinder {
        <0, 0, -0.6>
        <0, 0, 0.6>
        0.08
        pigment {color Grey}
    }
    object {
        kierownica
        rotate <0, 0, sin(clock*10)>  // animação de leve rotação do volante
        translate <0, 0, 0.65>
    }
}

// Banco do trator
#local siedzenie_traktora_siedzisko = union {
    box {
        < -0.5,  -0.05, -0.2>
        < 0.5, 0.05, 0.2>
        pigment {color Grey}
    }
}
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
            // para-brisa e vidro traseiro
            box {
                < -0.6, -0.3, -2>
                < 0.6, 0.9, 2>
                pigment {color Red}
            }
            // janelas laterais
            box {
                < -1, -0.6, -0.8>
                < 1, 0.9, 0.3>
                pigment {color Red}
            }
        }
    }

    // volante dentro da cabine
    object {
        to_cos_na_czym_stoi_kierownica
        scale <0.3, 0.3, 0.3>
        translate <0, 0, 0.15>
        rotate <-40,0, 0>
        translate <0, -0.1, -0.9>
    }

    // banco dentro da cabine
    object {
        siedzenie_traktora_oparcie
    }

}  // fim do local 'kabina'

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
        // Recorte para encaixe na cabine
        box {
            <-0.8, -0.7, 0.8>
            <0.8, 0.7, 1.27>
            pigment {color Red}
        }
    }

    // Inserindo a cabine sobre o capô
    object {
        kabina translate <0, 0.5, 1.65>
    }

    // Adicionando faróis
    object {
        swiatla_traktora
        translate <-0.4, -0.1, -0.9>
    }
    object {
        swiatla_traktora
        translate <0.4, -0.1, -0.9>
    }

    // Rodas dianteiras
    object {
        kolo rotate <_obr, 0, 0>
        translate <-0.95, -0.3, 2.25>
    }
    object {
        kolo rotate <_obr, 0, 0>
        translate <0.95, -0.3, 2.25>
    }

    // Rodas traseiras (um pouco menores)
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

// Exibe todo o trator
object {maska}

#end


/*
  ****************************************************************************************
  ************************   MACRO BOHATER   *********************************************
  ****************************************************************************************
*/

#macro bohater()
        // Definição das cores para a pele, camisa e calça
        #local Kolor_skory = Yellow;
        #local Kolor_koszuli = Blue;
        #local Kolor_spodni = Green;

        // Definição de um dedo (palec)
        #local palec = union {
                cylinder {
                  <0,-0.03, 0>
                  <0, 0.03, 0>
                  0.015
                  pigment {color Kolor_skory}
                }
        }

        // Definição da mão (dlon)
        #local dlon = union {
                // Palma da mão
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.3, 1, 1>
                  pigment {color Kolor_skory}
                }
                // Dedos na ordem do polegar ao mindinho
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
                // Adiciona uma espingarda na mão
                object {
                  strzelba()
                  scale <0.1, 0.1, 0.1>
                  rotate <90, 0, 0>
                  rotate <0, 180 , 0>
                  translate <0, -0.5, -0.05>
                }
        }

        // Antebraço (przedramie)
        #local przedramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Kolor_koszuli}
                }
                object {
                  dlon
                  translate <0, -0.3, 0>
                }      
        }

        // Braço (ramie)
        #local ramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_koszuli}
                }
                object {
                  przedramie
                  translate <0, -0.2, 0>
                  rotate <40, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }

        // Junta do ombro (staw_ramienny)
        #local staw_ramienny = union {
                sphere {
                  <0,0,0>
                  0.13
                  pigment {color Kolor_koszuli}
                }
                // Braço direito
                object {
                  ramie
                  rotate <5,0,0>
                  translate <0, -0.2, 0>
                }
        }

        // Definição do olho (oko)
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

        // Cabeça (glowa)
        #local glowa = union {
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Kolor_skory}
                }
                // Olhos
                object {
                  oko
                  translate <-0.07, 0, -0.16>
                }
                object {
                  oko
                  translate <0.07, 0, -0.16>
                }
        }

        // Pescoço (szyja)
        #local szyja = union {
                cylinder {
                  <0, -0.08, 0>
                  <0, 0.08, 0>
                  0.05
                  pigment {color Kolor_skory}
                }
                object {
                  glowa
                  translate <0, 0.25, 0>
                }
        }

        // Capuz (kaptury)
        #local kaptury = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1.5, 1, 0.8>
                  pigment {color Kolor_koszuli}
                }
        }

        // Costas (plecy)
        #local plecy = union {
                sphere {
                  <0,0,0>
                  0.3
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}
                }
        }

        // Metade do peito (polowa_klaty)
        #local polowa_klaty = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}
                }
        }

        // Pé (stopa)
        #local stopa = union {
                box {
                  <-0.1, -0.05, -0.15>
                  <0.1, 0.05, 0.15>
                  pigment {color Red}         
                }
        }

        // Canela (podudzie)
        #local podudzie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Red}
                }
                object {
                  stopa
                  translate <0, -0.23, -0.08>
                }       
        }

        // Coxa (udo)
        #local udo = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_spodni}
                }
                object {
                  podudzie
                  translate <0, -0.2, 0>
                  translate <0, -0.2, 0>
                }      
        }

        // Pelve (miednica)
        #local miednica = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <0, 0.85, 0.9>
                  pigment {color Kolor_spodni}
                }
                // Pernas
                object {
                  udo
                  translate <0, -0.2, 0>
                  translate <-0.1, -0.05, 0>
                }
                object {
                  udo
                  translate <0, -0.2, 0>
                  translate <0.1, -0.05, 0>
                }
        }

        // Tronco (korpus)
        #local korpus = union {
                cylinder {
                  <0, -0.3, 0>
                  <0, 0.3, 0>
                  0.15
                  pigment {color Kolor_koszuli} // <- TROCAR DEPOIS POR TEXTURA DE CAMISA XADREZ
                }
                // Pescoço girando com clock
                object {
                  szyja
                  rotate <0,-60*clock,0>
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
                // Metades do peito
                object {
                  polowa_klaty
                  translate <-0.07, 0.3, -0.1>
                }
                object {
                  polowa_klaty
                  translate <0.07, 0.3, -0.1>
                }
                // Braço direito
                object {
                  staw_ramienny
                  rotate <0+(clock*95), clock*(-15), 0>
                  translate <-0.3, 0.35, 0>
                }
                // Braço esquerdo
                object {
                  staw_ramienny
                  rotate <0, 0, 30>
                  translate <0.3, 0.35, 0>
                }
        }

        // Instancia o corpo do personagem
        object {
          korpus
        }
#end


/*
  ****************************************************************************************
  **************************   MACRO KROWA   *********************************************
  ****************************************************************************************
  -> Esta macro define a modelagem de uma vaca estilizada utilizando POV-Ray.
*/

#macro krowa()  // Definição da macro chamada "krowa" (vaca em polonês)

/* 
    Definição dos elementos da vaca — cada parte modelada com primitivos básicos e
    agrupada via union, podendo ser reutilizada.
*/

        // Olho (oko)
        #local oko = union {
                // Globo ocular branco
                sphere {
                  <0,0,0>, 0.1
                  pigment {color White}
                }
                // Pupila preta
                sphere {
                  <0,0,0>, 0.06
                  translate <0,0,-0.08>
                  pigment {color Black}
                }       
        }

        // Chifre (rog)
        #local rog = union {
                blob {
                threshold 0.01
                // Parte horizontal do chifre
                cylinder {
                  <-0.2,0,0>
                  <0.2,0,0>
                  0.1, 1
                  pigment {color White}
                }
                // Parte vertical do chifre
                cylinder {
                  <0,-0.2,0>
                  <0,0.2,0>
                  0.08, 1
                  translate <0.2,0.2,0>
                  pigment {color White}
                }
                }
        }

        // Focinho (pyszczek)
        #local pyszczek = union {
                // Parte cilíndrica do focinho
                cylinder {
                  <0,0,-0.3>
                  <0,0,0.3>
                  0.2
                  pigment {color rgb <0.9,0.8,0.8>}
                }
                // Parte esférica achatada do focinho
                sphere {
                  <0,0,-0.3>
                  0.22
                  scale <1,1,0.8>
                  pigment {color  rgb <0.9,0.8,0.8>}
                }
        }

        // Cabeça (glowa)
        #local glowa = union {
                // Cabeça com textura de imagem
                sphere {
                  <0,0,0>,0.4
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                // Dois olhos
                object { oko translate <-0.2,0.2,-0.35> }
                object { oko translate <0.2,0.2,-0.35> }
                // Focinho
                object { pyszczek translate <0,0,-0.3> }
                // Chifres
                object { rog translate <0.3,0.2,0> }
                object { rog rotate <0,180,0> translate <-0.3,0.2,0> }
        }

        // Pescoço (szyja)
        #local szyja = union {
                // Cilindro com textura
                cylinder {
                  <0,-0.2,0>
                  <0,0.2,0>
                  0.2
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                // Cabeça sobre o pescoço
                object { glowa translate <0,0.35,0> }
        }

        // Teta (wymie)
        #local wymie = union {
                // Cilindro rosado para cada teta
                cylinder {
                  <0,0,-0.2>
                  <0,0,0.2>
                  0.08
                  pigment {color  rgb <0.9,0.8,0.8>}
                } 
        }

        // Conjunto de tetinhas (wymiona)
        #local wymiona = union {
                // Parte esférica do úbere
                sphere {
                  <0,0,0>,0.4
                  pigment {color  rgb <0.9,0.8,0.8>}
                }
                // Quatro tetinhas dispostas
                object { wymie rotate <-5,10,0> translate <-0.15,0.15,-0.35> }
                object { wymie rotate <-5,10,0> translate <-0.15,-0.15,-0.35> }
                object { wymie rotate <-5,-10,0> translate <0.15,0.15,-0.35> }
                object { wymie rotate <-5,-10,0> translate <0.15,-0.15,-0.35> }
        }

        // Parte inferior da perna (lydka)
        #local lydka = union {
                // Canela com textura
                cylinder {
                  <0,-0.25,0>,<0,0.25,0>,0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                // Casco preto
                box {
                  <-0.1,-0.12,-0.1>,<0.1,0.12,0.1>
                  translate <0,-0.25,0>
                  pigment {color Black}
                }
        }

        // Joelho (kolano)
        #local kolano = union {
                sphere {
                  <0,0,0>, 0.11
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object { lydka translate <0,-0.25,0> rotate <-20,0,0> }
        }

        // Coxa (udo)
        #local udo = union {
                cone {
                  <0,0.3,0>, 0.3
                  <0,-0.3,0> 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object { kolano translate <0,-0.3,0> }
        }

        // Perna completa (noga)
        #local noga = union {
                // Esfera para a articulação superior
                sphere {
                  <0,0,0>, 0.3
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object { udo translate <0,-0.3,0> }
        }

        // Antebraço (przedramie)
        #local przedramie = union {
                cylinder{
                  <0,-0.2,0>, <0,0.2,0>, 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                box {
                  <-0.1,-0.12,-0.1>,<0.1,0.12,0.1>
                  translate <0,-0.25,0>
                  pigment{ color Black }
                }
        }

        // Cotovelo (lokiec)
        #local lokiec = union {
                sphere {
                  <0,0,0>, 0.12
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  przedramie
                  translate <0,-0.2,0>
                  rotate <45,0,0>
                }
        }

        // Braço (ramie)
        #local ramie = union {
                cylinder{
                  <0,-0.3,0>, <0,0.3,0>, 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object { lokiec translate <0,-0.3,0> }
        }

        // Corpo (korpus)
        #local korpus = union {
                // Tronco
                sphere {
                  <0,0,0>, 1
                  scale <0.5,1,0.7>
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                // Pescoço e cabeça
                object { szyja translate <0, 1 ,0> }
                // Úbere
                object { wymiona translate <0,-0.3,-0.5> }
                // Pernas traseiras (com leve animação)
                object { noga rotate <10+(-10*sin(clock*360)),0, 0> translate <0.22,-0.8,0> }
                object { noga rotate <0,0, 10+(-10*sin(clock*360))> translate <-0.22,-0.8,0> }
                // Braços dianteiros (com leve animação)
                object {
                  ramie
                  translate <0,-0.2,0>
                  rotate <0 ,0, 45+(45*sin(clock*360))>
                  rotate <0,-10,0>
                  rotate <0,0,30>
                  translate <0.3,0.8,0>
                }
                object {
                  ramie
                  translate <0,-0.2,0>
                  rotate <0,0, -45-(45*sin(clock*360))>
                  rotate <0,10,0>
                  rotate <0,0,-30>
                  translate <-0.3,0.8,0>
                }
        }

        // Renderiza o corpo completo
        object {korpus}

#end  // Fim da macro krowa


/*
  ****************************************************************************************
  *************************   FUNÇÃO PRINCIPAL   *****************************************
  ****************************************************************************************
*/

// Cria o trator na cena
object {
  traktor(0)
  scale <1.3, 1.3, 1.3>     // Aumenta o tamanho do trator em 30% em todos os eixos
  translate <0, 1.7>        // Move o trator para cima no eixo Y
}

// Cria o personagem (herói) na cena
object {
  bohater()
  rotate <0,-20,0>          // Rotaciona o personagem -20° em torno do eixo Y
  translate <2, 1.2, 1>     // Move o personagem para a posição desejada
}

// Cria a vaca na cena
object {
  krowa()
  scale <0.6,0.6,0.6>       // Reduz o tamanho da vaca para 60% do tamanho original
  rotate <0,-40,0>          // Rotaciona a vaca -40° em torno do eixo Y
  translate <2.2, 1.3+(0.2*sin(clock*10)), 2.5>  // Move a vaca para a posição desejada, com leve animação de sobe e desce usando seno
}


// ******  CENÁRIO  ******

// Cria duas casas na cena
#local kolejne_domy = 0;    // Inicializa a variável de controle para o laço

#while (kolejne_domy<2)     // Enquanto o número de casas for menor que 2
        object {
          dom(-10)                             // Chama a macro dom() com parâmetro -10
          scale <10,10,10>                     // Escala a casa 10 vezes maior
          rotate <0, -90, 0>                   // Rotaciona a casa -90° no eixo Y
          translate <-100, 20, 50-(kolejne_domy*100)>  // Posiciona a casa no cenário com espaçamento de 100 unidades no eixo Z
        }
        #local kolejne_domy = kolejne_domy+1;  // Incrementa o contador de casas
#end

/*
object {
  drzewo()                                     // Chama a macro para adicionar uma árvore
  scale <10,10,10>                             // Escala a árvore 10 vezes maior
  translate <-100, 10, -(kolejne_domy*100)>    // Posiciona a árvore
}
*/
