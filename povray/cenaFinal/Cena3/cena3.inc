/*
  ****************************************************************************************
  ****************************   MACRO CASA   *********************************************
  ****************************************************************************************
*/

#macro casa(eixo_y)
        // Definição da cor das paredes (amarelo açafrão)
        #local cor_parede = <0.99609375, 0.66796875, 0.34765625>;  

        // Corpo principal da casa - combinação de cilindro e caixa
        #local corpo_principal = union {
        // dimensões aproximadas 7.4 x 4 x 5.4
                  cylinder {
                    <-1.5, -2, 0>
                    <-1.5, 1.8, 0>
                    2
                    pigment {color cor_parede}  // cor das paredes
                  }
                  box {
                    <-1.5, -2, -2>
                    <2, 1.8, 2>
                    pigment {color cor_parede}  // cor das paredes
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
        #local vazio = union {
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
        #local varanda = union{
                box {
                  <-0.9, -0.1, -0.7>
                  <0.9, 0.1, 0.7>
                  pigment {color rgb cor_parede}  // cor da varanda (mesma que paredes)
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

        // Peitoril da janela
        #local peitoril = union {
          box {
            <-0.55, -0.1, -0.15>
            <0.55, 0.1, 0.15>
            //pigment {color rgb <0.99609375, 0.95703125, 0.88671875>} // cor perolada (comentada)
            pigment {color rgb <0.5, 0, 0>}  // cor vermelho escuro
          }
        }
        
        
        // Porta da casa
        #local porta = union {
                box {
                  <-0.4, -0.8, -0.05>
                  <0.4, 0.8, 0.05>
                  pigment {color rgb <0.5, 0, 0>} // cor ferrugem (vermelho escuro)
                }
        }
        
        // Estrutura da casa (corpo menos interior)
        #local estrutura_casa = difference {
                        #object {corpo_principal}
                        #object {vazio}
        }
        
        // Combinação de todos os componentes para formar a casa completa
        #local casa_completa = union {
                object {estrutura_casa}
                object {varanda
                        translate <1, 0.5, -2>}
                object {porta
                        translate <1.37, -1.1, -2>}
                object {peitoril
                        translate <-0.5, 0.8, -2.2>}
                object {peitoril
                        translate <-0.5, -0.9, -2.2>}
       }
       // Exibe a casa com rotação em torno do eixo Y (vertical)
       object {casa_completa rotate <0,  eixo_y, 0>}
#end