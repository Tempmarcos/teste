#include "shapes.inc"     // Inclui formas básicas pré-definidas (esferas, cilindros, etc.)
#include "textures.inc"   // Inclui texturas pré-definidas
#include "colors.inc"     // Inclui cores pré-definidas
#include "woods.inc"      // Inclui texturas de madeira pré-definidas


#declare przemieszczenie = -clock*80;   // Declara variável de deslocamento, que muda com o tempo (clock) para animação

// Céu esférico com gradiente de cor e pigmento turbulento para simular nuvens
sky_sphere {
  pigment {
    gradient z                       // Gradiente na direção z (vertical)
    color_map {
      [0.5 color <0, 0.74609375, 0.99609375>]  // Cor clara na metade inferior (azul claro)
      [1.0 color MidnightBlue]                   // Cor azul escuro no topo
    }
    scale 2                          // Escala do gradiente para ampliar o efeito   
  }
  pigment {
    bozo                            // Pigmento de nuvens turbulentas
    turbulence 0.9                  // Intensidade da turbulência
    omega 0.7                      // Frequência da turbulência
    color_map {
      [0.0 color rgb <0.85, 0.85, 0.85>]       // Cor cinza claro na base das nuvens
      [0.1 color rgb <0.75, 0.75, 0.75>]       // Cor cinza médio
      [0.5 color rgbt <1,1,1,1>]                // Cor branca totalmente opaca (transparência no final)
    }
    scale <0.6, 0.3, 0.3>           // Escala do pigmento turbulento para formar nuvens achatadas
  }
}

// Plano horizontal representando o chão, pintado de verde
plane {
  y, 0                    // Plano no eixo y=0 (chão)
  pigment {color Green}   // Cor verde
}

// Iluminação do plano
/*
light_source {
  <0, 90, -100>           // Luz posicionada alta e atrás
  color White             // Cor branca da luz (alternativa comentada: tom amarelado)
}
light_source {
  <100, 10, 0>            // Luz lateral à direita
  color White 
}
*/

// Luz principal com área de luz para sombras suaves
light_source {
  <0, 15, -45>            // Posição da fonte de luz (à frente e acima)
  color White             // Cor branca da luz
  area_light <30, 0, 0>, <0, 0, 30>, 5, 5   // Luz de área com tamanho 30x30 unidades, subdividida em 5x5 amostras para suavização
  adaptive 1              // Ajuste adaptativo para eficiência no cálculo da luz
  jitter                  // Adiciona variação aleatória para suavizar sombras
}
// Luz geral de preenchimento bem distante para iluminação ambiente
light_source {
  <0, 300, -500>          // Luz distante bem alta e afastada
  color White
}

// Câmera posicionada de frente, com deslocamento animado para acompanhar o movimento
camera {
  location <0.6, 1.2, 0.9  + przemieszczenie>   // Posição da câmera com deslocamento variável para animação
  look_at <0, 1.2, 1.4  + przemieszczenie>      // Ponto que a câmera observa (também se move junto)
}

/* Câmeras alternativas comentadas para diferentes vistas:

// Câmera de trás
camera {
  location <0, 0.2, 2>
  look_at <0, 0.2, 0>
}

// Câmera de cima
camera {
  location <0, 20, 0>
  look_at <0, 0.2, 0>
}

// Câmera de baixo
camera {
  location <0, -30, 0>
  look_at <0, -5, 0>
}

// Câmera lateral esquerda
camera {
  location <8, 1.5, 0>
  look_at <0, 0, 0>
}

// Câmera lateral direita
camera {
  location <-2, 0.2, 0>
  look_at <0, 0.2, 0>
}
*/

/*
  ****************************************************************************************
  ****************************   MACRO CASA (DOM)   **************************************
  ****************************************************************************************
*/

#macro dom(obrot_y)   // Macro para construir uma casa, com rotação em torno do eixo Y

    // cor das paredes: amarelo açafrão
    #local kolor_scian = <0.99609375, 0.66796875, 0.34765625>;

    // forma principal da casa, união de cilindro e caixa
    #local glowna_bryla = union {
        // cilindro vertical (parede arredondada)
        cylinder {
            <-1.5, -2, 0>     // ponto inicial
            <-1.5, 1.8, 0>    // ponto final
            2                  // raio
            pigment {color kolor_scian}  // cor das paredes
        }
        // caixa principal da casa
        box {
            <-1.5, -2, -2>    // canto inferior traseiro
            <2, 1.8, 2>       // canto superior frontal
            pigment {color kolor_scian}
        } 

        // telhado - cilindro pequeno vertical
        cylinder {
            <-1.5, 1.8, 0>
            <-1.5, 2, 0>
            2.2
            pigment {color rgb <0.5, 0, 0>}   // cor vermelho escuro
        }
        // telhado - caixa fina
        box {
            <-1.7, 1.8, -2.7>
            <2.2, 2, 2.7>
            pigment {color rgb <0.5, 0, 0>}
        }
    }

    // espaço vazio dentro da casa para criar a estrutura oca
    #local puste = union {
        // interior da casa - cilindro menor (vazio)
        cylinder {
            <-1.5, -1.9, 0>
            <-1.5, 1.7, 0>
            1.9
            // pigment {color Red}  // comentado: poderia pintar o vazio de vermelho para debug
        }
        // interior da casa - caixa menor (vazio)
        box {
            <-1.5, -1.9, -1.9>
            <1.9, 1.7, 1.9>
            // pigment {color Green}  // comentado: verde para debug do vazio
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

    // sacada
    #local balkon = union{
        box {
            <-0.9, -0.1, -0.7>
            <0.9, 0.1, 0.7>
            pigment {color rgb kolor_scian}
        }
        // corrimão superior (cilindro fino)
        cylinder {
            <-0.9, 0.5, -0.6>
            <0.9, 0.5, -0.6>
            0.06
            pigment {color Brown}   // cor marrom
        }
        // corrimão verticales (varões)
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

    // parapeito da janela
    #local parapet = union {
        box {
            <-0.55, -0.1, -0.15>
            <0.55, 0.1, 0.15>
            // pigment {color rgb <0.99609375, 0.95703125, 0.88671875>}  // cor pérola (comentada)
            pigment {color rgb <0.5, 0, 0>}  // cor ferrugem
        }
    }

    // porta (detalhe)
    #local drzwi = union {
        box {
            <-0.4, -0.8, -0.05>
            <0.4, 0.8, 0.05>
            pigment {color rgb <0.5, 0, 0>} // cor ferrugem
        }
    }

    // esqueleto da casa: forma principal menos o espaço vazio
    #local szkielet_domu = difference {
        #object {glowna_bryla}   // parte sólida
        #object {puste}          // espaço vazio interno
    }

    // tudo junto: esqueleto + sacada + porta + parapeitos
    #local wszystko = union {
        object {szkielet_domu}
        object {balkon translate <1, 0.5, -2>}      // sacada posicionada na frente
        object {drzwi translate <1.37, -1.1, -2>}   // porta posicionada
        object {parapet translate <-0.5, 0.8, -2.2>}  // parapeito superior
        object {parapet translate <-0.5, -0.9, -2.2>} // parapeito inferior
    }

    // aplica rotação no eixo Y, conforme parâmetro da macro
    object {wszystko rotate <0,  obrot_y, 0>}
#end

/*
  ****************************************************************************************
  ************************   MACRO TRATOR   *********************************************
  ****************************************************************************************
*/

#macro traktor(_obr)
        #local kolo = union {

        // *** pneu + recorte do cilindro para a roda ***       
                difference {
                        torus {
                          0.6, 0.4
                          rotate <0, 0, 90>
                          pigment {color rgb<0.3, 0.3, 0.3>} // cor cinza escuro para pneu
                        }
                        cylinder {
                          <-0.45, 0, 0>
                          <0.45, 0, 0>
                          0.549
                          pigment {color rgb <0.7, 0.7, 0.7>} // cor cinza claro para a roda
                        }
                }
                
                #local r=0;
        
                #while (r<=360)
                // *** pneu ***
                    intersection {
                            difference {
                                    box {
                                      <-0.4, -0.05, -1.1>
                                      <0.4, 0.05, 1.1>
                                      rotate <r, 0, 0>
                                      pigment {color rgb<0.3, 0.3, 0.3>} // cor cinza escuro
                                    }
                                    cylinder {
                                      <-1,0,0>, <1,0,0>, 0.6
                                    }
                            } // fim do difference
                            torus {
                                0.7, 0.43
                                rotate <0, 0, 90>
                                pigment {color rgb<0.3, 0.3, 0.3>} // cor cinza escuro
                            }
                    }
                    
                // *** rodas (aro) ***
                    difference {
                            cylinder {
                              <-0.4, 0, 0>
                              <0.4, 0, 0>
                              0.55
                              pigment {color rgb <0.7, 0.7, 0.7>} // cinza claro
                            }
                            union {
                                    cylinder {
                                      <-0.5, 0, 0>
                                      <-0.3, 0, 0>
                                      0.4
                                      pigment {color rgb <0.7, 0.7, 0.7>} // cinza claro
                                    }
                                    cylinder {
                                      <0.5, 0, 0>
                                      <0.3, 0, 0>
                                      0.4
                                      pigment {color rgb <0.7, 0.7, 0.7>} // cinza claro
                                    }
                                    // entradas para desapertar as rodas (parafusos)
                            } // fim do union
                    }
                    
                        #local r = r + 40;
                #end  // fim do while
        
        }  // fim do local 'kolo'
        
        
        // 2 elementos do volante
        #local kierownica = union {
                torus {
                  0.5, 0.1
                  pigment {color Grey} // cor cinza
                  scale <1, 0.5, 1>
                  rotate <90, 0, 0>
                }
                
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Grey} // cor cinza
                  scale <1, 1, 0.25>
                }
                
                box {
                  <-0.5, -0.1, -0.04>
                  <0.5, 0.1, 0.04>
                  pigment {color Grey} // cor cinza
                }
                box {
                  <-0.5, -0.1, -0.04>
                  <0.5, 0.1, 0.04>
                  rotate <0, 0, 90>
                  pigment {color Grey} // cor cinza
                }
        }
        #local to_cos_na_czym_stoi_kierownica = union {
                cylinder {
                  <0, 0, -0.6>
                  <0, 0, 0.6>
                  0.08
                  //rotate <0, 0, 90>
                  pigment {color Grey} // cor cinza
                }
                object {
                  kierownica
                  rotate <0, 0, sin(clock*10)> // rotação animada do volante
                  translate <0, 0, 0.65>
                }
        }
        
        
        // assento do trator
        #local siedzenie_traktora_siedzisko = union {
                box {
                  < -0.5,  -0.05, -0.2>
                  < 0.5, 0.05, 0.2>
                  pigment {color Grey} // cor cinza
                }
        }
        #local siedzenie_traktora_oparcie = union {
                box {
                  < -0.5, -0.5, -0.1>
                  < 0.5, 0.5, 0.1>
                  pigment {color Grey} // cor cinza
                }
                object {
                  siedzenie_traktora_siedzisko
                  translate <0, -0.35, -0.25>
                }
        }
        // cabine do trator
        #local kabina = union {
                difference {
                        box {
                          < -0.7, -1, -0.9>
                          < 0.7, 1, 0.9>
                          pigment {color Red} // cor vermelha
                        }
                        
                        union {
                                // parede traseira inclinada
                                box {
                                  <-2.7, -1.3, -0.6>
                                  < 2.7, 1.3, 0.6>
                                  rotate <-10, 0, 0>
                                  translate <0, 0, 1.5>
                                  pigment {color Red} // cor vermelha
                                }
                                // vidro frontal e traseiro
                                box {
                                  < -0.6, -0.3, -2>
                                  < 0.6, 0.9, 2>
                                  pigment {color Red} // cor vermelha
                                }
                                // vidros laterais
                                // ATENÇÃO! Precisa fazer portas!
                                box {
                                  < -1, -0.6, -0.8>
                                  < 1, 0.9, 0.3>
                                  pigment {color Red} // cor vermelha
                                }
                        }
                }
                
                object {
                  to_cos_na_czym_stoi_kierownica
                  scale <0.3, 0.3, 0.3>
                  translate <0, 0, 0.15>
                  rotate <-40,0, 0>
                  translate <0, -0.1, -0.9>
                }

                object {
                  siedzenie_traktora_oparcie
                }
                
        }  // fim do local 'kabina'
        
        #local swiatla_traktora = union {
                box {
                  <-0.2, -0.2, -0.4>
                  <0.2, 0.2, -0.4>
                  pigment {color Yellow} // cor amarela (farol)
                }                
        }
        #local maska = union {
           difference {
                   box {
                     <-0.7, -0.6, 1.25>
                     <0.7, 0.6, -1.25>
                     /*<-0.3, -0.8, -0.5>
                     <0.3, 0.4, -2>*/
                     //translate <0, 0.2, 1.25>   // <- move tudo para baixo desta distância
                     pigment {color Red} // cor vermelha (capô)
                   }
                   // recorte da parte que entra na cabine
                   box {
                    <-0.8, -0.7, 0.8>
                     <0.8, 0.7, 1.27>
                     pigment {color Red} // cor vermelha
                   }
           }
           /*object {kabina translate <0, 0.3, 0.4>}
           object {kolo translate <-0.3, -0.5, 1>}
           object {kolo
             scale <0.7, 0.7, 0.7>
             translate <-0.3, -0.8, -1.5>
           }*/
           
           object {
             kabina translate <0, 0.5, 1.65>
           }
           object {
             swiatla_traktora
             translate <-0.4, -0.1, -0.9>
           }
           object {
             swiatla_traktora
             translate <0.4, -0.1, -0.9>
           }
           
           // rodas dianteiras
           object {
             kolo rotate <_obr, 0, 0>
             translate <-0.95, -0.3, 2.25>
           }
           
           object {
             kolo rotate <_obr, 0, 0>
             translate <0.95, -0.3, 2.25>
           }
           
           // rodas traseiras
           object {kolo
             scale <0.7, 0.7, 0.7>
              rotate <_obr, 0, 0> 
             translate <-0.95, -0.6, -0.25>
           }
           object {kolo
             scale <0.7, 0.7, 0.7>
              rotate <_obr, 0, 0> 
             translate <0.95, -0.6, -0.25>
           }
        }
        
        
        //object {kolo}
        object {maska}

#end


/*
  ****************************************************************************************
  ************************   MACRO ÁRVORE   **********************************************
  ****************************************************************************************
*/
#macro drzewo()
        // Definição da copa da árvore como uma esfera verde
        #local korona = sphere {
          <0,0,0>
          0.4
          pigment {color Green}  // cor verde
        }
        
        // Definição de um galho, que é um cilindro marrom com a copa no topo
        #local galaz = union {
                cylinder {
                  <0, -0.9, 0>
                  <0, 0.9, 0>
                  0.1
                  pigment {color Brown}  // cor marrom
                }
                object {
                  korona
                  translate <0, 0.7, 0>  // posiciona a copa no topo do galho
                } 
        }
        
        // Definição do tronco da árvore com galhos e ramificações
        #local pien = union {
                cylinder {
                  <0, -1, 0>
                  <0, 1, 0>
                  0.4
                  pigment {color Brown}  // tronco marrom
                }
                
                // Extensões do tronco (galhos maiores)
                object {
                  galaz
                  scale <1.5, 1.5, 1.5>  // escala o galho maior
                  translate <0, 1.5, 0>  // posiciona acima do tronco
                  rotate <15, 0, 20>     // rotaciona o galho
                  translate <-0.2, 0.2, 0>  // ajuste de posição
                }
                object {
                  galaz
                  scale <2, 1.7, 2>      // escala outro galho maior
                  translate <0, 1.7, 0>
                  rotate <5, 0, -10>
                  translate <-0.2, 0.2, 0>
                }
                
                // Galhos menores (ramificações)
                object {
                  galaz
                  translate <0, 0.6, 0>
                  rotate <0, 0, 40>
                  //rotate <0, 90, 0>    // comentado, não aplicado
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
        
        // Desenha o tronco com todos os galhos
        object {
          pien
        }
#end


/*
  ****************************************************************************************
  ************************   MACRO PERSONAGEM   ******************************************
  ****************************************************************************************
*/

#macro bohater()
        // Definindo cores usadas para a pele, camisa e calças
        #local Kolor_skory = Yellow;      // cor da pele: amarelo
        #local Kolor_koszuli = Blue;      // cor da camisa: azul
        #local Kolor_spodni = Green;      // cor das calças: verde
        
        // Definição do dedo como um pequeno cilindro da cor da pele
        #local palec = union {
                cylinder {
                  <0,-0.03, 0>
                  <0, 0.03, 0>                  
                  0.015
                  pigment {color Kolor_skory}
                }
        }
        
        // Definição da mão como uma combinação da palma e dedos
        #local dlon = union {
                // palma da mão
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.3, 1, 1>
                  pigment {color Kolor_skory}
                }
                // dedos, em ordem do polegar ao mínimo
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
        }
        
        // Definição do antebraço: cilindro azul com a mão na ponta
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
        
        // Definição do braço: cilindro azul mais fino, com o antebraço ligado
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
                  rotate <120, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }
        
        // Definição da articulação do ombro: esfera azul que conecta o braço
        #local staw_ramienny = union {
                sphere {
                  <0,0,0>
                  0.13
                  pigment {color Kolor_koszuli}
                }
                object { // braço direito
                  ramie
                  rotate <5*sin(clock*10), 0, 0>  // animação do movimento do braço
                  translate <0, -0.2, 0>
                }
        }
        
        // Definição do olho: esfera branca com uma pupila preta
        #local oko = union {
                // globo ocular
                sphere {
                  <0,0,0>
                  0.05
                  pigment {color White}
                }
                // pupila
                sphere {
                  <0,0,0>
                  0.02
                  translate <0, 0, -0.04>
                  pigment {color Black}
                }
        }
        
        // Definição da cabeça: esfera da cor da pele com dois olhos
        #local glowa = union {
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Kolor_skory}
                }
                object {
                  oko
                  translate <-0.07, 0, -0.16>
                }
                object {
                  oko
                  translate <0.07, 0, -0.16>
                }
        }
        
        // Definição do pescoço: cilindro da cor da pele com a cabeça em cima
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
        
        // Definição do capuz (ou parte superior das costas): esfera azul achatada
        #local kaptury = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1.5, 1, 0.8>
                  pigment {color Kolor_koszuli}
                }
        }
        
        // Definição das costas: esfera azul achatada em outra dimensão
        #local plecy = union {
                sphere {
                  <0,0,0>
                  0.3
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}
                }
        }
        
        // Definição da metade do peito: esfera azul achatada
        #local polowa_klaty = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1, 0.8, 0.4>
                  //pigment {checker pigment {color <0, 0.72, 0.8>} pigment {White}}  // padrão xadrez comentado
                  pigment {color Kolor_koszuli}
                }
        }
        
        /*
          DESATIVANDO AS PARTES INFERIORES DO CORPO POIS NÃO ESTÃO PRESENTES NESTA CENA
          
          #local stopa = union {
                  box {
                    <-0.1, -0.05, -0.15>
                    <0.1, 0.05, 0.15>
                    pigment {color Red}         
                  }
          }
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
                    rotate <-110, 0, 0>
                    translate <0, -0.2, 0>
                  }      
          }
          #local miednica = union {
                  sphere {
                    <0,0,0>
                    0.2
                    scale <0, 0.85, 0.9>
                    pigment {color Kolor_spodni}
                  }
                  object {
                    udo
                    translate <0, -0.2, 0>
                    rotate <110, 0, -5>
                    translate <-0.1, -0.05, 0>
                  }
                  object {
                    udo
                    translate <0, -0.2, 0>
                    rotate <110, 0, 5>
                    translate <0.1, -0.05, 0>
                  }  
          }
        */
        
        // Definição do torso: cilindro azul com o pescoço, capuz, costas, peito e braços anexados
        #local korpus = union {
                cylinder {
                  <0, -0.3, 0>
                  <0, 0.3, 0>
                  0.15
                  pigment {color Kolor_koszuli} // <- TROCAR DEPOIS PARA TEXTURA DE CAMISA XADREZADA
                }
                object {
                  szyja
                  rotate <0, (((50*clock)<50) ? (50 * clock) : (50)) , 0>  // gira o pescoço conforme o tempo (clock)
                  translate <0, 0.52, 0>
                }
                object {
                  kaptury
                  translate <0, 0.35, 0.05>
                }
                object {
                  plecy
                  translate <0, 0.23, 0.1>
                }
                
                /* object {
                  miednica
                  translate <0, -0.25, 0>
                } */
                
                object {
                  polowa_klaty
                  translate <-0.07, 0.3, -0.1>
                }
                object {
                  polowa_klaty
                  translate <0.07, 0.3, -0.1>
                }
                object { // braço direito
                  staw_ramienny
                  rotate <0, 0, -30>
                  translate <-0.3, 0.35, 0>
                }
                object {
                  staw_ramienny
                  rotate <0, 0, 30>
                  translate <0.3, 0.35, 0>
                }
        }
        
        // Desenha o corpo completo do personagem
        object {
          korpus
        }
#end

/*
  ****************************************************************************************
  *************************   FUNÇÃO PRINCIPAL   ******************************************
  ****************************************************************************************
*/

// Desenha o objeto "trator" girando conforme o tempo (clock), com escala e posição ajustadas
object {
  traktor(360*clock)           // gira o trator 360 graus multiplicado pelo clock (animação contínua)
  scale <1.3, 1.3, 1.3>       // aumenta o tamanho do trator
  translate <0, 0, przemieszczenie>  // move o trator no eixo Z conforme a variável 'przemieszczenie' (deslocamento)
}

// Desenha o personagem (função macro bohater) com deslocamento vertical e no eixo Z
object {
  bohater()
  translate <0, 0.6, 1.8 + przemieszczenie>  // posiciona o personagem acima do solo e movendo junto com o trator
}

// ******  CENÁRIO  ******

#local kolejne_domy = 0;  // contador para casas

// Enquanto houver menos que 3 casas desenhadas, cria casas e árvores posicionadas no cenário
#while (kolejne_domy<3)
        object {
          dom(-10)                           // chama a função 'dom' (casa) com parâmetro -10
          scale <10,10,10>                  // escala a casa
          rotate <0, -90, 0>                // rotaciona a casa para virar na direção desejada
          translate <-100, 20, 50-(kolejne_domy*100)>  // posiciona as casas espaçadas no eixo Z
        }
        object {
          drzewo()                          // chama a função 'drzewo' (árvore)
          scale <10,10,10>                  // escala a árvore
          rotate <0, 20, 0>                 // rotaciona levemente a árvore
          translate <-100, 10, -(kolejne_domy*100)>   // posiciona as árvores alinhadas com as casas
        }
        #local kolejne_domy = kolejne_domy+1;  // incrementa o contador para a próxima casa e árvore
#end
