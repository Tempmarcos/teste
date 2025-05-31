/*
  ****************************************************************************************
  **************************   MACRO GALINHA   ********************************************
  ****************************************************************************************
*/

#macro kurka()
        // Definição das cores usadas na galinha
        #local kolor_pior = <0.56640625 , 0.3203125 , 0.1796875>; // cor castanha dourada (plumas)
        #local kolor_dzioba = <0.99609375, 0.8359375, 0.30078125>; // cor do bico
        #local kolor_glowy = <0.80078125 , 0.333984375 , 0>;      // cor da cabeça
        
        #local oko = union {  // construção do olho
                sphere {
                  <0,0,0>
                  0.2
                  finish {
                    ambient 0.9  // quanto da luz recebida será refletida
                  }
                  pigment {color Red} // cor vermelha da parte do olho (glóbulo)
                }
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.5, 1, 1>
                  translate <0, 0, -0.15>
                  pigment {color Black} // pupila preta
                }
        }
        
        
        #local glowa = union {  // construção da cabeça
                // crânio
                sphere {
                  <0,0,0>
                  0.8
                  pigment {color kolor_glowy} // cor da cabeça
                }
                // bico
                box {
                  <-0.3, -0.15, -0.5>
                  <0.3, 0.15, 0.5>
                  translate <0, -0.2, -0.55>
                  pigment {color rgb kolor_dzioba} // cor do bico
                }
                // crista
                sphere {
                  <0, 0, 0>
                  0.6
                  scale <0.3, 1, 1>
                  translate <0, 0.8, 0>
                  pigment {color Red} // cor vermelha da crista
                }
                // olho direito
                object {
                  oko
                  translate <-0.4, 0.2, -0.6>
                }
                // olho esquerdo
                object {
                  oko
                  translate <0.4, 0.2, -0.6>
                }
                rotate <-90,0,0>  // rotação da cabeça
        }
        
        #local szyja = union {  // construção do pescoço
                  cone {
                    <0 , -0.75, 0>, 0.8
                    <0 , 0.75, 0>, 0.25
                    pigment {color rgb kolor_glowy}  // cor avermelhada
                  }
                  object {
                    glowa
                    rotate <90, 0, 0>
                    translate <0, 1.1, 0>
                  }
        }


        #local stopa = union {  // construção do pé
                box {
                  <-0.5, -0.1, -0.6>
                  <0.5, 0.1, 0.6>
                  pigment {color rgb kolor_dzioba} // cor do bico (amarelado)
                }
        }
        
        
        #local lydka = union {  // construção da canela da perna
                 cylinder {
                   <0, -0.6, 0>
                   <0, 0.6, 0>
                   0.2
                   pigment {color rgb kolor_dzioba} // cor do bico (amarelado)
                 }
                 
                 object {
                   stopa
                   rotate <-30, 0, 0>
                   translate <0, -0.65, -0.4>
                 }
        }
        
        
        
        #local udo = union {  // construção da coxa
                  cone {
                    <0 , -0.75, 0>, 0.25
                    <0 , 0.75, 0>, 0.8
                    pigment {color rgb kolor_pior} // cor castanha das penas
                  }
                  object {
                    lydka
                    translate <0, -1.3, 0>
                  }
        }
        
        
        #local skrzydlo = union {  // construção da asa
                sphere {
                  <0,0,0>
                  2
                  scale <1, 0.5, 0.2>
                  pigment {color rgb kolor_pior} // cor castanha das penas
                }
                object{
                  siekiera()  // objeto "machado" (não definido aqui, pode ser outra macro)
                  translate <0,0,-0.1>
                }
        }
        
        #local kolec = union {  // espinho no corpo
                cone {
                  <0, 0, -1.5>, 0.4
                  <0, 0, 1.5>, 0
                  pigment {color Red} // cor vermelha do espinho
                }
        }
        
        #local korpus = union {  // construção do corpo
                lathe {
                  cubic_spline
                  6
                  <0, -2>, <1.1, -1.5>, <1.7, -0.5>, <1, 1>, <0.5, 1.7>, <0.4, 2>
                  pigment {color rgb kolor_pior} // cor castanha das penas
                }
                
                object {
                  kolec
                  scale <0.8, 0.8, 0.8>
                  translate <0, 0, 1.5>
                  rotate <-20, 0, 0>
                  translate <0, 1, -0.2>
                }
                  
                object {
                  szyja
                  translate <0, 1.95, 0>
                }
        
                object {
                  udo
                  rotate <0, 0, -5>
                  translate <-0.7, -1.5, 0>
                }
                object {
                  udo
                  rotate <0, 0, 5>
                  translate <0.7, -1.5, 0>
                }
                // asa direita
                object {
                  skrzydlo
                  translate <-1, 0, 0>
                  rotate <0, 50*sin(clock*180), 0>     // MOVIMENTO DAS ASAS
                  //rotate <0, 60*sin(mod(clock*120, 270)), 0>     // MOVIMENTO DAS ASAS (alternativa)
                  translate <-2.5, 0.7, 0>
                }
                // asa esquerda
                object {
                  skrzydlo
                  translate <1, 0, 0>
                  rotate <0, -50*sin(clock*180), 0>     // MOVIMENTO DAS ASAS
                  //rotate <0, -60*sin(mod(clock*120, 270)), 0>     // MOVIMENTO DAS ASAS (alternativa)
                  translate <2.5, 0.7, 0>
                }  
        }
        
        
        object {korpus}  // exibe o corpo da galinha
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


/*
  ****************************************************************************************
  ************************   MACRO TRATOR   **********************************************
  ****************************************************************************************
*/

#macro traktor(_obr)
        #local kolo = union {

        // *** pneu + recorto cilindro para a roda ***
                difference {
                        torus {
                          0.6, 0.4
                          rotate <0, 0, 90>
                          pigment {color rgb<0.3, 0.3, 0.3>} // cor cinza escuro para o pneu
                        }
                        cylinder {
                          <-0.45, 0, 0>
                          <0.45, 0, 0>
                          0.549
                          pigment {color rgb <0.7, 0.7, 0.7>} // cor cinza claro para a roda (aro)
                        }
                }
                
                #local r=0;
        
                #while (r<=360)
                // *** pneu detalhado ***
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
                    
                // *** aro da roda ***
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
                                    // entradas para desparafusar os aros
                            } // fim do union
                    }
                    
                        #local r = r + 40;
                #end  // fim do while
        
        }  // fim do local 'kolo'
        
        
        // 2 elementos do volante
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
                  //rotate <0, 0, 90>
                  pigment {color Grey}
                }
                object {
                  kierownica
                  rotate <0, 0, sin(clock*10)>  // faz o volante girar (animação)
                  translate <0, 0, 0.65>
                }
        }
        
        
        // assento do trator
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
        // cabine do trator
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
                                // vidros laterais
                                // ATENÇÃO! É preciso fazer a porta!
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
        
        #local swiatla_traktora = union {
                box {
                  <-0.2, -0.2, -0.4>
                  <0.2, 0.2, -0.4>
                  pigment {color Yellow} // faróis amarelos
                }                
        }
        #local maska = union {
           difference {
                   box {
                     <-0.7, -0.6, 1.25>
                     <0.7, 0.6, -1.25>
                     /*<-0.3, -0.8, -0.5>
                     <0.3, 0.4, -2>*/
                     //translate <0, 0.2, 1.25>   // <- move tudo para baixo por esse valor
                     pigment {color Red}
                   }
                   // recorta o pedaço que invade a cabine
                   box {
                    <-0.8, -0.7, 0.8>
                     <0.8, 0.7, 1.27>
                     pigment {color Red}
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
  ************************   MACRO espingarda   ********************************************
  ****************************************************************************************
*/

#macro strzelba()
        #local kolor_strzelby = Grey; // Cor da espingarda (cinza)
        
        // Definição do punho da arma (rekojesc)
        #local rekojesc = union {
                cone {
                  <0, 0, -2>, 0.5         // Posição e raio da base maior do cone
                  <0, 0, 2>, 0.3          // Posição e raio da base menor do cone
                  scale <0.8, 1, 1>       // Escala para deformar o cone no eixo X
                  pigment {color Brown}   // Cor marrom (madeira)
                }        
        }
        
        // Definição da mira (celownik)
        #local celownik = union {
                torus {
                  0.3, 0.05               // Raio maior e menor do toro (anel)
                  scale <1, 0.5, 1>       // Escala para achatá-lo no eixo Y
                  pigment {color kolor_strzelby} // Cor da espingarda
                }
                box {
                  <-0.03, -0.07, -0.3>    // Caixa pequena para estrutura vertical da mira
                  <0.03, 0.07, 0.3>
                  pigment {color kolor_strzelby}
                }
                box {
                  <-0.3, -0.07, -0.03>    // Caixa pequena para estrutura horizontal da mira
                  <0.3, 0.07, 0.03>
                  pigment {color kolor_strzelby}
                }
        }
        
        // Definição do cano principal da espingarda (glownia)
        #local glownia = union {
                // Mesmos tubos por onde passam os projéteis
                difference {
                        union {
                                cylinder {
                                  <-0.25, 0, -3>       // Cilindro do lado esquerdo do cano
                                  <-0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                                cylinder {
                                  <0.25, 0, -3>        // Cilindro do lado direito do cano
                                  <0.25, 0, 3>
                                  0.3
                                  pigment {color kolor_strzelby}
                                }
                        }
                        union {
                                cylinder {
                                  <-0.25, 0, -2.9>    // Cilindro menor que será subtraído para formar o cano oco (esquerda)
                                  <-0.25, 0, 3.1>
                                  0.2
                                  pigment {color kolor_strzelby}
                                }
                                cylinder {
                                  <0.25, 0, -2.9>     // Cilindro menor que será subtraído para formar o cano oco (direita)
                                  <0.25, 0, 3.1>
                                  0.2
                                  pigment {color kolor_strzelby}
                                }    
                        }
                }
                
                // Posiciona a mira na arma
                object {
                  celownik
                  rotate <90, 0, 0>
                  translate <0, 0.7, 3>
                }
                
                // Posiciona o punho da arma
                object {
                  rekojesc
                  translate <0,0,-2>
                  rotate <-3, 0, 0>
                  translate <0, 0, -3>
                }
        }
        
        // Desenha o cano da arma
        object {glownia}
#end


/*
  ****************************************************************************************
  ************************   MACRO ÁRVORE   **********************************************
  ****************************************************************************************
*/

#macro drzewo()
        // Coroa da árvore - uma esfera verde com textura irregular
        #local korona = sphere {
          <0,0,0>
          0.4
          pigment {color Green}  // pigmento verde
          normal {
            bumps 1               // textura com relevo (bumps)
            scale 0.1             // escala da textura
          }
        }

        // Galho da árvore - cilindro marrom com uma coroa no topo
        #local galaz = union {
                cylinder {
                  <0, -0.9, 0>
                  <0, 0.9, 0>
                  0.1
                  pigment {color Brown} // pigmento marrom (cor de madeira)
                }
                object {
                  korona                // adiciona a coroa ao topo do galho
                  translate <0, 0.7, 0> // posiciona a coroa acima do cilindro
                } 
        }

        // Tronco da árvore com ramificações maiores e menores
        #local pien = union {
                cylinder {
                  <0, -1, 0>
                  <0, 1, 0>
                  0.4
                  pigment {color Brown} // pigmento marrom do tronco
                }
                // Extensões do tronco - galhos maiores
                object {
                  galaz
                  scale <1.5, 1.5, 1.5> // aumenta o tamanho do galho
                  translate <0, 1.5, 0> // posiciona mais acima no tronco
                  rotate <15, 0, 20>    // rotaciona o galho
                  translate <-0.2, 0.2, 0> // pequeno ajuste na posição
                }
                object {
                  galaz
                  scale <2, 1.7, 2>     // galho maior e mais largo
                  translate <0, 1.7, 0>
                  rotate <5, 0, -10>
                  translate <-0.2, 0.2, 0>
                }
                // Galhos menores
                object {
                  galaz
                  translate <0, 0.6, 0>
                  rotate <0, 0, 40>
                  //rotate <0, 90, 0>     // comentado: possível rotação adicional
                  translate <-0.2, 0, 0>
                }
                object {
                  galaz
                  translate <0, 0.8, 0>
                  rotate <0, 0, 40>
                  rotate <0, 90, 0>      // rotação em Y para orientação lateral
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

        // Desenha o tronco com seus galhos
        object {
          pien
        }
#end



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


// ###########################################################################


// Macro regador
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


// ###############################################################


// Macro machado
#macro siekiera()
        // Lâmina do machado - caixa com textura cromada polida e duas esferas marrons para suavizar bordas
        #local ostrze = difference {
                box{
                  <0.005,0.1,0.2>
                  <-0.005,-0.1,-0.2>
                  texture{Polished_Chrome}      
                }
                union {
                        sphere {
                           <0,0,0>, 0.2
                           scale <1,1,1.7> 
                           translate <0,0.26,0.1>
                           pigment {DMFWood1} // pigmento marrom madeira
                        }
                        sphere {
                           <0,0,0>, 0.2
                           scale <1,1,1.7> 
                           translate <0,-0.26,0.1>
                           pigment {DMFWood1} // pigmento marrom madeira
                        }                
                }
        }
        // Cabo do machado - cilindro marrom com a lâmina posicionada e escalada
        #local trzon = union {
                cylinder {
                  <0,0.4,0>
                  <0,-0.4,0>
                  0.05
                  pigment {DMFWood1}
                }
                object {
                  ostrze
                  translate <0,0,-0.2>
                  scale <1.4,1.4,1.4>
                  translate <0,0.3,0>
                }
        }
        // Desenha o machado completo, ampliado em escala maior
        object {
          trzon
          scale <5,6,5>
        }
#end


/*
  ****************************************************************************************
  ************************   MACRO BOHATER   *********************************************
  ****************************************************************************************
*/

/*
  MACRO BOHATER (HERÓI)
  Esta macro cria um modelo 3D de um personagem com várias partes do corpo, 
  usando diferentes formas básicas e cores para representar pele, roupas e acessórios.
*/

#macro bohater()
        #local Kolor_skory = Yellow;       // Cor da pele
        #local Kolor_koszuli = Blue;       // Cor da camisa
        #local Kolor_spodni = Green;       // Cor da calça

        #local palec = union {              // Criação do dedo (polegar, indicador, etc.)
                cylinder {
                  <0,-0.03, 0>
                  <0, 0.03, 0>                  
                  0.015
                  pigment {color Kolor_skory}  // Cor da pele aplicada ao dedo
                }
        }

        #local dlon = union {               // Criação da palma da mão (mão)
                // palma da mão
                sphere {
                  <0,0,0>
                  0.1
                  scale <0.3, 1, 1>
                  pigment {color Kolor_skory}  // Cor da pele aplicada à palma
                }
                // dedos na ordem do polegar ao mindinho
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
                object {
                  strzelba()                  // Adiciona uma espingarda (macro externa)
                  scale <0.1, 0.1, 0.1>
                  rotate <90, 0, 0>
                  rotate <0, 180 , 0>
                  translate <0, -0.5, -0.05>
                }
        }

        #local przedramie = union {         // Antebraço
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Kolor_koszuli}   // Cor da camisa aplicada no antebraço
                }
                object {
                  dlon
                  translate <0, -0.3, 0>
                }      
        }

        #local ramie = union {               // Braço
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_koszuli}  // Cor da camisa aplicada no braço
                }
                object {
                  przedramie
                  translate <0, -0.2, 0>
                  rotate <120, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }

        #local staw_ramienny = union {       // Articulação do ombro
                sphere {
                  <0,0,0>
                  0.13
                  pigment {color Kolor_koszuli}  // Cor da camisa aplicada na articulação
                }
                object { // braço direito
                  ramie
                  //rotate <5*sin(clock*10), 0, 0>  // Comentado: possível animação do braço
                  rotate <30, 0, 0>
                  translate <0, -0.2, -0.1>
                }
        }

        #local oko = union {                 // Olho
                // globo ocular
                sphere {
                  <0,0,0>
                  0.05
                  pigment {color White}         // Cor branca do globo ocular
                }
                // pupila
                sphere {
                  <0,0,0>
                  0.02
                  translate <0, 0, -0.04>
                  pigment {color Black}         // Cor preta da pupila
                }
        }

        #local glowa = union {               // Cabeça
                sphere {
                  <0,0,0>
                  0.2
                  pigment {color Kolor_skory}  // Cor da pele aplicada à cabeça
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

        #local szyja = union {               // Pescoço
                cylinder {
                  <0, -0.08, 0>
                  <0, 0.08, 0>
                  0.05
                  pigment {color Kolor_skory}  // Cor da pele aplicada ao pescoço
                }
                object {
                  glowa
                  translate <0, 0.25, 0>
                }
        }

        #local kaptury = union {             // Capuz (ou parte superior da camisa)
                sphere {
                  <0,0,0>
                  0.2
                  scale <1.5, 1, 0.8>
                  pigment {color Kolor_koszuli}  // Cor da camisa aplicada ao capuz
                }
        }

        #local plecy = union {               // Costas
                sphere {
                  <0,0,0>
                  0.3
                  scale <1, 0.8, 0.4>
                  pigment {color Kolor_koszuli}  // Cor da camisa aplicada às costas
                }
        }

        #local polowa_klaty = union {        // Metade do peito (torso)
                sphere {
                  <0,0,0>
                  0.2
                  scale <1, 0.8, 0.4>
                  //pigment {checker pigment {color <0, 0.72, 0.8>} pigment {White}}  // Comentado: padrão quadriculado
                  pigment {color Kolor_koszuli}   // Cor da camisa aplicada no peito
                }
        }

        #local stopa = union {               // Pé
                box {
                  <-0.1, -0.05, -0.15>
                  <0.1, 0.05, 0.15>
                  pigment {color Red}          // Cor vermelha para o pé
                }
        }

        #local podudzie = union {            // Canela
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.1
                  pigment {color Red}          // Cor vermelha para a canela
                }
                object {
                  stopa
                  translate <0, -0.23, -0.08>
                }       
        }

        #local udo = union {                 // Coxa
                cylinder {
                  <0, -0.2, 0>
                  <0, 0.2, 0>
                  0.07
                  pigment {color Kolor_spodni}  // Cor da calça aplicada na coxa
                }
                object {
                  podudzie
                  translate <0, -0.2, 0>
                  rotate <-110, 0, 0>
                  translate <0, -0.2, 0>
                }      
        }

        #local miednica = union {            // Quadril
                sphere {
                  <0,0,0>
                  0.2
                  scale <0, 0.85, 0.9>
                  pigment {color Kolor_spodni}   // Cor da calça aplicada no quadril
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

        #local korpus = union {              // Tronco
                cylinder {
                  <0, -0.3, 0>
                  <0, 0.3, 0>
                  0.15
                  pigment {color Kolor_koszuli}  // Cor da camisa aplicada ao tronco
                }
                object {
                  szyja
                  //rotate <0, (((50*clock)<50) ? (50 * clock) : (50)) , 0>  // Comentado: possível animação de rotação do pescoço
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
                object { // braço direito
                  staw_ramienny
                  rotate <0, 0, -30>
                  translate <-0.3, 0.35, 0>
                }
                object {                      // braço esquerdo
                  staw_ramienny
                  rotate <0, 0, 30>
                  translate <0.3, 0.35, 0>
                }
        }

        object {
          korpus                          // Desenha o corpo completo do personagem
        }
#end
