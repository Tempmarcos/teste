#include "shapes.inc"    // Inclui formas geométricas básicas
#include "textures.inc"  // Inclui texturas básicas
#include "colors.inc"    // Inclui cores padrão
#include "woods.inc"     // Inclui texturas de madeira


// Esfera do céu (sky_sphere) com gradiente e textura de nuvem
sky_sphere {
  pigment {
    gradient z   // Gradiente na direção do eixo z (vertical)
    color_map {
      [0.5 color <0, 0.74609375, 0.99609375>]  // Cor azul clara no meio do gradiente
      [1.0 color MidnightBlue]                   // Cor azul escuro no topo
    }
    scale 2   // Escala do gradiente
  }
  pigment {
    bozo            // Textura do tipo Bozo para nuvens
    turbulence 0.9  // Turbulência para deformar a textura (aparência natural)
    omega 0.7       // Parâmetro que controla a direção do efeito Bozo
    color_map {
      [0.0 color rgb <0.85, 0.85, 0.85>]   // Cor cinza claro no início da textura
      [0.1 color rgb <0.75, 0.75, 0.75>]   // Cor cinza um pouco mais escuro
      [0.5 color rgbt <1,1,1,1>]            // Branco totalmente opaco (transparência 1)
      [1.0 color rgbt <1,1,1,1>]            // Branco totalmente opaco no fim
    }
    scale <0.6, 0.3, 0.3>   // Escala da textura Bozo nas direções x, y e z
  }
  //rotate <0,90,0>  // (Comentado) Rotaciona a esfera do céu (não ativado)
}


// Plano horizontal (chão) no nível y=0 com pigmento verde
plane {
  y, 0
  pigment {color Green}  // Cor verde
}


// Fonte de luz principal com área e jitter para suavizar sombras
light_source {
  <30, 10, -45>      // Posição da luz
  color White        // Cor branca da luz
  area_light <30, 5, 0>, <0, 0, 30>, 4, 4   // Luz de área (tamanho e subdivisões)
  adaptive 1         // Ajuste adaptativo para melhor qualidade
  jitter             // Movimento aleatório para suavizar sombras
}

// Fonte de luz distante, tipo sol
light_source {
  <10, 300, -500>   // Posição da luz
  color White       // Cor branca
}


// Configuração da câmera
camera {
  location <3, 2, -1>   // Posição da câmera
  look_at <1, 1, 1.5>   // Ponto para onde a câmera está olhando
}

/*
  ****************************************************************************************
  ************************   MACRO ESPINGARDA   *****************************************
  ****************************************************************************************
*/

#macro strzelba()
        #local kolor_strzelby = Grey;  // Cor da espingarda (cinza)
        
        // Guarda-mão da espingarda (parte para segurar)
        #local rekojesc = union {
                cone {
                  <0, 0, -2>, 0.5          // Base do cone na posição <0,0,-2> com raio 0.5
                  <0, 0, 2>, 0.3           // Topo do cone na posição <0,0,2> com raio 0.3
                  scale <0.8, 1, 1>        // Escala do cone (achatado no eixo x)
                  pigment {color Brown}    // Cor marrom (madeira)
                }        
        }

        // Mira da espingarda
        #local celownik = union {
                torus {
                  0.3, 0.05               // Torus com raio maior 0.3 e raio menor 0.05
                  scale <1, 0.5, 1>       // Escala achatada no eixo y
                  pigment {color kolor_strzelby} // Cor da espingarda (cinza)
                }
                box {
                  <-0.03, -0.07, -0.3>    // Caixa fina, provavelmente parte da mira
                  <0.03, 0.07, 0.3>
                  pigment {color kolor_strzelby}
                }
                box {
                  <-0.3, -0.07, -0.03>    // Outra caixa, formando a mira
                  <0.3, 0.07, 0.03>
                  pigment {color kolor_strzelby}
                }
        }

        // Cano principal da espingarda
        #local glownia = union {
                // os mesmos tubos por onde passam os projéteis
                difference {
                        union {
                                cylinder {
                                  <-0.25, 0, -3>        // Cilindro esquerdo do cano
                                  <-0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                                cylinder {
                                  <0.25, 0, -3>         // Cilindro direito do cano
                                  <0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                        }
                        union {
                                cylinder {
                                  <-0.25, 0, -2.9>      // Tubos internos para formar o buraco do cano
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
                // Mira posicionada na parte superior do cano
                object {
                  celownik
                  rotate <90, 0, 0>
                  translate <0, 0.7, 3>
                }
                // Guarda-mão posicionado na parte inferior do cano
                object {
                  rekojesc
                  translate <0,0,-2>
                  rotate <-3, 0, 0>
                  translate <0, 0, -3>
                }
        }

        // Exibe o objeto principal da espingarda (cano + mira + guarda-mão)
        object {glownia}
#end


/*
  ****************************************************************************************
  ************************   MACRO TRATOR   **********************************************
  ****************************************************************************************
*/

#macro traktor(_obr)
        #local kolo = union {

        // *** pneu + recorto o cilindro para a roda (aro) ***
                difference {
                        torus {
                          0.6, 0.4
                          rotate <0, 0, 90>
                          pigment {color rgb<0.3, 0.3, 0.3>}  // cor cinza escuro (pneu)
                        }
                        cylinder {
                          <-0.45, 0, 0>
                          <0.45, 0, 0>
                          0.549
                          pigment {color rgb <0.7, 0.7, 0.7>} // cor cinza claro (aro)
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
                                      pigment {color rgb<0.3, 0.3, 0.3>} // cinza escuro
                                    }
                                    cylinder {
                                      <-1,0,0>, <1,0,0>, 0.6
                                    }
                            } // fim do difference
                            torus {
                                0.7, 0.43
                                rotate <0, 0, 90>
                                pigment {color rgb<0.3, 0.3, 0.3>} // cinza escuro
                            }
                    }
                    
                // *** aro ***
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
                                    // entradas para desparafusar o aro (lugares para os parafusos)
                            } // fim do union
                    }
                    
                        #local r = r + 40;
                #end  // fim do while
        
        }  // fim do local 'kolo' (roda)
        
        
        // 2 elementos do volante
        #local kierownica = union {
                torus {
                  0.5, 0.1
                  pigment {color Grey}  // cinza
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
                  //rotate <0, 0, 90>
                  pigment {color Grey}
                }
                object {
                  kierownica
                  rotate <0, 0, sin(clock*10)>  // volante girando suavemente
                  translate <0, 0, 0.65>
                }
        }
        
        
        // banco do trator (assento)
        #local siedzenie_traktora_siedzisko = union {
                box {
                  < -0.5,  -0.05, -0.2>
                  < 0.5, 0.05, 0.2>
                  pigment {color Grey}
                }
        }
        // encosto do banco do trator
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
        
        // cabine do trator
        #local kabina = union {
                // eixo atrás (comentado)
                /*cylinder {
                  < 0.8, -4, 0.8>
                  < 0.8, 4, 0.8>
                  0.1
                  translate <0, 0, 0.1>
                  pigment {color Yellow}
                }*/
                difference {
                        box {
                          < -0.7, -1, -0.9>
                          < 0.7, 1, 0.9>
                          pigment {color Red} // cabine vermelha
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
                                // vidro frontal e traseiro
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
        
        // faróis do trator
        #local swiatla_traktora = union {
                box {
                  <-0.2, -0.2, -0.4>
                  <0.2, 0.2, -0.4>
                  pigment {color Yellow} // amarelo (farol)
                }                
        }
        
        // capô do trator
        #local maska = union {
           difference {
                   box {
                     <-0.7, -0.6, 1.25>
                     <0.7, 0.6, -1.25>
                     pigment {color Red}
                   }
                   // recorto a parte que entra na cabine
                   box {
                    <-0.8, -0.7, 0.8>
                     <0.8, 0.7, 1.27>
                     pigment {color Red}
                   }
           }
           
           // adiciona objetos à máscara (cabine, faróis, rodas)
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
           
           // rodas dianteiras com rotação conforme _obr (input da macro)
           object {
             kolo rotate <_obr, 0, 0>
             translate <-0.95, -0.3, 2.25>
           }
           
           object {
             kolo rotate <_obr, 0, 0>
             translate <0.95, -0.3, 2.25>
           }
           
           // rodas traseiras menores e escaladas
           object {kolo
             scale <0.7, 0.7, 0.7>
             translate <-0.95, -0.6, -0.25>
           }
           object {kolo
             scale <0.7, 0.7, 0.7>
             translate <0.95, -0.6, -0.25>
           }
        }
        
        
        //object {kolo} // roda simples (comentado)
        object {maska} // exibe o capô (com os elementos)
#end

/*
  ****************************************************************************************
  ************************   MACRO BOHATER (HERÓI)   **************************************
  ****************************************************************************************
*/

#macro bohater()
        #local Kolor_skory = Yellow;       // Cor da pele (Amarelo)
        #local Kolor_koszuli = Blue;       // Cor da camisa (Azul)
        #local Kolor_spodni = Green;       // Cor da calça (Verde)
        
        /*#local palec_paliczek2 = union {
                cylinder {
                  <0,-0.02, 0>
                  <0, 0.02, 0>                  
                  0.014
                  pigment {color Kolor_skory}
                }
        }*/ 
        // Definição do dedo (palec) com cilindro representando o dedo principal
        #local palec = union {
                cylinder {
                  <0,-0.03, 0>
                  <0, 0.03, 0>                  
                  0.015
                  pigment {color Kolor_skory}  // Cor da pele
                }
                /*object {
                  palec_paliczek2
                  translate <0, -0.05, 0>
                }*/
        }
        
        // Definição da mão (dlon) com uma esfera representando a palma e os dedos posicionados
        #local dlon = union {
                // Palma da mão
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.3, 1, 1>               // Escala alongada para formar a palma
                  pigment {color Kolor_skory}    // Cor da pele
                }
                // Dedos do polegar até o dedo mínimo
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
                // Adiciona uma espingarda (strzelba) na mão, com escala, rotação e posicionamento
                object {
                  strzelba()
                  scale <0.1, 0.1, 0.1>
                  rotate <90, 0, 0>
                  rotate <0, 180 , 0>
                  translate <0, -0.5, -0.05>
                }
        }
        
        // Definição do antebraço (przedramie) como um cilindro com a mão posicionada na ponta
        #local przedramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
                object {
                  dlon
                  translate <0, -0.3, 0>
                }      
        }
        
        // Definição do braço (ramie) como um cilindro com o antebraço posicionado
        #local ramie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
                object {
                  przedramie
                  translate <0, -0.2, 0>
                  //rotate <40, 0, 0>            // Rotação comentada
                  translate <0, -0.2, 0>
                }      
        }
        
        // Definição da articulação do ombro (staw_ramienny) com o braço direito rotacionado
        #local staw_ramienny = union {
                sphere {
                  <0,0,0>
                  0.13
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
                object { // braço direito
                  ramie
                  rotate <5,0,0> //rotate <5*sin(clock*10), 0, 0> // pequena rotação dinâmica comentada
                  translate <0, -0.2, 0>
                }
        }
        
        // Definição do olho com globo ocular branco e pupila preta deslocada para frente
        #local oko = union {
                // Globo ocular (esfera branca)
                sphere {
                  <0,0,0>
                  0.05
                  pigment {color White}  // Branco
                }
                // Pupila (esfera preta)
                sphere {
                  <0,0,0>
                  0.02
                  translate <0, 0, -0.04>  // Pequeno deslocamento para frente
                  pigment {color Black}  // Preto
                }
        }
        
        // Definição da cabeça (glowa) como uma esfera da cor da pele com dois olhos posicionados
        #local glowa = union {
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Kolor_skory}  // Cor da pele
                }
                object {
                  oko
                  translate <-0.07, 0, -0.16>  // Olho esquerdo
                }
                object {
                  oko
                  translate <0.07, 0, -0.16>   // Olho direito
                }
        }
        
        // Definição do pescoço (szyja) como um cilindro da cor da pele com a cabeça em cima
        #local szyja = union {
                cylinder {
                  <0, -0.08, 0>
                  <0, 0.08, 0>
                  0.05
                  pigment {color Kolor_skory}  // Cor da pele
                }
                object {
                  glowa
                  translate <0, 0.25, 0>        // Posiciona a cabeça acima do pescoço
                }
        }
        
        // Definição do capuz (kaptury) como uma esfera alongada na cor da camisa
        #local kaptury = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1.5, 1, 0.8>
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
        }
        
        // Definição das costas (plecy) como uma esfera achatada na cor da camisa
        #local plecy = union {
                sphere {
                  <0,0,0>
                  0.3
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
        }
        
        // Definição da metade do tórax (polowa_klaty) como esfera achatada e com cor da camisa
        #local polowa_klaty = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <1, 0.8, 0.4>
                  //pigment {checker pigment {color <0, 0.72, 0.8>} pigment {White}} // textura quadriculada comentada
                  pigment {color Kolor_koszuli}  // Cor da camisa
                }
        }
        
        // Definição do pé (stopa) como uma caixa vermelha
        #local stopa = union {
                box {
                  <-0.1, -0.05, -0.15>
                  <0.1, 0.05, 0.15>
                  pigment {color Red}         
                }
        }
        
        // Definição da perna inferior (podudzie) como cilindro vermelho com pé posicionado
        #local podudzie = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Red}  // Vermelho
                }
                object {
                  stopa
                  translate <0, -0.23, -0.08>
                }       
        }
        
        // Definição da coxa (udo) como cilindro verde com perna inferior posicionada
        #local udo = union {
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_spodni}  // Cor da calça
                }
                object {
                  podudzie
                  translate <0, -0.2, 0>
                  //rotate <-110, 0, 0>  // Rotação comentada
                  translate <0, -0.2, 0>
                }      
        }
        
        // Definição da pelve (miednica) como uma esfera achatada verde com as duas coxas posicionadas
        #local miednica = union {
                sphere {
                  <0,0,0>
                  0.2
                  scale <0, 0.85, 0.9>
                  pigment {color Kolor_spodni}  // Cor da calça
                }
                object {
                  udo
                  translate <0, -0.2, 0>
                  //rotate <110, 0, -5>   // Rotação comentada
                  translate <-0.1, -0.05, 0>
                }
                object {
                  udo
                  translate <0, -0.2, 0>
                  //rotate <110, 0, 5>    // Rotação comentada
                  translate <0.1, -0.05, 0>
                }
        }
        
        // Definição do torso (korpus) com cilindro da cor da camisa e objetos anexados (pescoço, capuz, costas, pelve, tórax e braços)
        #local korpus = union {
                cylinder {
                  <0, -0.3, 0>
                  <0, 0.3, 0>
                  0.15
                  pigment {color Kolor_koszuli} // <- Substituir depois por textura quadriculada da camisa
                }
                object {
                  szyja
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
                
                object {
                  miednica
                  translate <0, -0.25, 0>
                }
                
                object {
                  polowa_klaty
                  translate <-0.07, 0.3, -0.1>
                }
                object {
                  polowa_klaty
                  translate <0.07, 0.3, -0.1>
                }
                object { // braço direito com rotação dinâmica (clock é variável de tempo)
                  staw_ramienny
                  rotate <0+(clock*95), clock*(-15), 0>
                  translate <-0.3, 0.35, 0>
                }
                object {
                  staw_ramienny
                  rotate <0, 0, 30>
                  //rotate <clock*40,0,0>    // Rotação comentada
                  translate <0.3, 0.35, 0>
                }
        }
        
        object {
          korpus  // Renderiza o corpo completo
        }
#end


/*
  ****************************************************************************************
  *************************   FUNÇÃO PRINCIPAL   ******************************************
  ****************************************************************************************
*/

// Cria o objeto 'trator' com parâmetro 0, aplica escala e translação para posicionar na cena
object {
  traktor(0)             // Função que gera o modelo do trator (parâmetro 0)
  scale <1.3, 1.3, 1.3>  // Escala o trator em 1.3x nas três dimensões
  translate <0, 1.7>     // Move o trator para cima no eixo Y em 1.7 unidades
}

// Cria o objeto 'herói', aplica rotação e translação para posicionar na cena
object {
  bohater()              // Função que gera o modelo do herói
  rotate <0, -20, 0>     // Rotaciona o herói -20 graus no eixo Y (para virar um pouco à esquerda)
  translate <2, 1.2, 1>  // Move o herói para a posição (x=2, y=1.2, z=1)
}
