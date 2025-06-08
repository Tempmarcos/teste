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

/*
  ****************************************************************************************
  ************************   MACRO ÁRVORE   **********************************************
  ****************************************************************************************
*/

#macro arvore()
        // Coroa da árvore - uma esfera verde com textura irregular
        #local coroa = sphere {
          <0,0,0>
          0.4
          pigment {color Green}  // pigmento verde
          normal {
            bumps 1               // textura com relevo (bumps)
            scale 0.1             // escala da textura
          }
        }

        // Galho da árvore - cilindro marrom com uma coroa no topo
        #local galho = union {
                cylinder {
                  <0, -0.9, 0>
                  <0, 0.9, 0>
                  0.1
                  pigment {color Brown} // pigmento marrom (cor de madeira)
                }
                object {
                  coroa                // adiciona a coroa ao topo do galho
                  translate <0, 0.7, 0> // posiciona a coroa acima do cilindro
                } 
        }

        // Tronco da árvore com ramificações maiores e menores
        #local tronco = union {
                cylinder {
                  <0, -1, 0>
                  <0, 1, 0>
                  0.4
                  pigment {color Brown} // pigmento marrom do tronco
                }
                // Extensões do tronco - galhos maiores
                object {
                  galho
                  scale <1.5, 1.5, 1.5> // aumenta o tamanho do galho
                  translate <0, 1.5, 0> // posiciona mais acima no tronco
                  rotate <15, 0, 20>    // rotaciona o galho
                  translate <-0.2, 0.2, 0> // pequeno ajuste na posição
                }
                object {
                  galho
                  scale <2, 1.7, 2>     // galho maior e mais largo
                  translate <0, 1.7, 0>
                  rotate <5, 0, -10>
                  translate <-0.2, 0.2, 0>
                }
                // Galhos menores
                object {
                  galho
                  translate <0, 0.6, 0>
                  rotate <0, 0, 40>
                  //rotate <0, 90, 0>     // comentado: possível rotação adicional
                  translate <-0.2, 0, 0>
                }
                object {
                  galho
                  translate <0, 0.8, 0>
                  rotate <0, 0, 40>
                  rotate <0, 90, 0>      // rotação em Y para orientação lateral
                  translate <0, 0, -0.2>
                }
                object {
                  galho
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  translate <-0.2, 0.2, 0>
                }
                object {
                  galho
                  translate <0, 0.9, 0>
                  rotate <0, 0, -40>
                  rotate <0, 40, 0>
                  translate <-0.2, 0.2, 0>
                }
        }

        // Desenha o tronco com seus galhos
        object {
          tronco
        }
#end


/*
  ****************************************************************************************
  ************************   MACRO ANCINHO   *********************************************
  ****************************************************************************************
*/
#macro ancinho()
        // Dente do ancinho - forma cônica cinza
        #local dente = cone {
          <0, -0.1, 0>, 0.04
          <0, 0.1, 0>, 0
          pigment {color Grey}
        }
        // Extensão do dente - cilindro cinza com o dente no topo
        #local extensaoDente = union {
          cylinder {
            <0,0.2,0>
            <0,-0.2,0>
             0.04
            pigment{color Grey}
          }
          object {
              dente
              translate <0, 0.3, 0>
          }
        }
        // Barra transversal do ancinho, contendo vários dentes espaçados
        #local barra = union {
          box {
            <1, 0.101, 0.08>
            <-1, -0.101, -0.08>
            pigment {color Grey}
          }
          
          #local i=-1;
          #local distancia=0.25; // distância entre dentes
          #while ((i+distancia)<=(1+distancia))
                object {
                        extensaoDente
                        translate <0+i , 0.2, 0>
                }
                #local i = i+distancia;       
          #end
        }
        // Suporte do cabo - cilindro branco (madeira branca)
        #local suporte = cylinder {
                <0,0,0.4>, <0,0,-0.4>, 0.06  
                pigment {White_Wood}
        }
        // Cabo do ancinho - cilindro longo com dois suportes laterais e a barra transversal no topo
        #local cabo = union {
          cylinder {
            <0,0,2>
            <0,0,-2>
            0.1
            pigment {White_Wood}
          }
          object {
                suporte         
                translate <0,0,-0.3>
                rotate <0, -120, 0>
                translate <0.1,0,1.6>
          }
          object {
                suporte         
                translate <0,0,0.3>
                rotate <0, -60, 0>
                translate <-0.1,0,1.6>
          }
          object {
                barra
                translate <0,0,2>
          }
        }
        
        // Desenha o ancinho completo (cabo com suportes e barra transversal com dentes)
        object {cabo}
#end


/*
  ****************************************************************************************
  ************************   MACRO REGADOR   *********************************************
  ****************************************************************************************
*/
#macro regador()
        // Funil do regador - forma cônica verde com uma pequena área interna subtraída (diference)
        #local funil = difference {
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
        #local corpo = union {
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
                  funil
                  translate <0,0.08,0>
                  rotate <50, 0,0>
                  translate <0,0,0.05> 
                }
        }
        // Desenha o regador completo
        object {corpo}
#end

/*
  ****************************************************************************************
  ************************   MACRO MACHADO   *********************************************
  ****************************************************************************************
*/
#macro machado()
        // Lâmina do machado - caixa com textura cromada polida e duas esferas marrons para suavizar bordas
        #local lamina = difference {
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
        #local cabo = union {
                cylinder {
                  <0,0.4,0>
                  <0,-0.4,0>
                  0.05
                  pigment {DMFWood1}
                }
                object {
                  lamina
                  translate <0,0,-0.2>
                  scale <1.4,1.4,1.4>
                  translate <0,0.3,0>
                }
        }
        // Desenha o machado completo, ampliado em escala maior
        object {
          cabo
          scale <5,6,5>
        }
#end

/*
  ****************************************************************************************
  ************************   MACRO VACA   ************************************************
  ****************************************************************************************
*/
#macro vaca()
        // Olho da vaca
        #local olho = union {
                sphere {
                  <0,0,0>, 0.1
                  pigment {color White}      // Esclera branca
                }
                sphere {
                  <0,0,0>, 0.06
                  translate <0,0,-0.08>
                  pigment {color Black}      // Pupila preta
                }       
        }
        
        // Chifre da vaca
        #local chifre = union {
                blob {
                threshold 0.01
                cylinder {
                  <-0.2,0,0>
                  <0.2,0,0>
                  0.1, 1
                  pigment {color White}      // Cor branca para chifre
                }
                cylinder {
                  <0,-0.2,0>
                  <0,0.2,0>
                  0.08, 1
                  translate <0.2,0.2,0>
                  pigment {color White}
                }
                }
        }
        
        // Focinho da vaca
        #local focinho = union {
                cylinder {
                  <0,0,-0.3>
                  <0,0,0.3>
                  0.2
                  pigment {color rgb <0.9,0.8,0.8>}    // Cor rosada clara
                }
                sphere {
                  <0,0,-0.3>
                  0.22
                  scale <1,1,0.8>
                  pigment {color  rgb <0.9,0.8,0.8>}
                }
        }
        
        // Cabeça da vaca com textura de imagem
        #local cabeca = union {
                sphere {
                  <0,0,0>,0.4
                  texture { pigment{image_map { png "lata_krowy.png"}}}   // Textura da vaca
                }
                object {
                  olho
                  translate <-0.2,0.2,-0.35>   // Olho esquerdo
                }
                object {
                  olho
                  translate <0.2,0.2,-0.35>    // Olho direito
                }
                object {
                  focinho
                  translate <0,0,-0.3>          // Focinho
                }
                object {
                  chifre
                  translate <0.3,0.2,0>         // Chifre direito
                }
                object {
                  chifre
                  rotate <0,180,0>
                  translate <-0.3,0.2,0>        // Chifre esquerdo
                }
        }
        
        // Pescoço da vaca com textura da imagem
        #local pescoco = union {
                cylinder {
                  <0,-0.2,0>
                  <0,0.2,0>
                  0.2
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  cabeca
                  translate <0,0.35,0>
                }
        }
        
        // teta da vaca
        #local teta = union {
                cylinder {
                  <0,0,-0.2>
                  <0,0,0.2>
                  0.08
                  pigment {color  rgb <0.9,0.8,0.8>}   // Cor rosada clara
                } 
        }
        
        // Conjunto de tetas (quatro) posicionadas e rotacionadas
        #local mamas = union {
                sphere {
                  <0,0,0>,0.4
                  pigment {color  rgb <0.9,0.8,0.8>}
                }
                object {
                  teta
                  rotate <-5,10,0>
                  translate <-0.15,0.15,-0.35>
                }                     
                object {
                  teta
                  rotate <-5,10,0>
                  translate <-0.15,-0.15,-0.35>
                }
                object {
                  teta
                  rotate <-5,-10,0>
                  translate <0.15,0.15,-0.35>
                }
                object {
                  teta
                  rotate <-5,-10,0>
                  translate <0.15,-0.15,-0.35>
                }
        }
        
        // Parte inferior da perna (canela) com textura da imagem
        #local canela = union {
                cylinder {
                  <0,-0.25,0>,<0,0.25,0>,0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                box {
                  <-0.1,-0.12,-0.1>,<0.1,0.12,0.1>
                  translate <0,-0.25,0>
                  pigment {color Black}       // Detalhe preto na canela
                }
        }
        
        // Joelho da vaca com textura
        #local joelho = union {
                sphere {
                  <0,0,0>, 0.11
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  canela
                  translate <0,-0.25,0>
                  rotate <-20,0,0>
                }
        }
        
        // Coxa da vaca
        #local coxa = union {
                cone {
                  <0,0.3,0>, 0.3
                  <0,-0.3,0> 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  joelho
                  translate <0,-0.3,0>
                }
        }
        
        // Perna completa
        #local perna = union {
                sphere {
                  <0,0,0>, 0.3
                  texture { pigment{image_map { png "lata_krowy.png"}}}                 
                }
                object {
                  coxa
                  translate <0,-0.3,0>
                }
        }
        
        // Antebraço da vaca
        #local antebraco = union {
                cylinder{
                  <0,-0.2,0>, <0,0.2,0>, 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                box {
                  <-0.1,-0.12,-0.1>,<0.1,0.12,0.1>
                  translate <0,-0.25,0>
                  pigment {color Black}     // Detalhe preto no antebraço
                }
        }
        
        // Cotovelo da vaca
        #local cotovelo = union {
                sphere {
                  <0,0,0>, 0.12
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  antebraco
                  translate <0,-0.2,0>
                  rotate <45,0,0>
                }
        }
        
        // Braço da vaca
        #local braco = union {
                cylinder{
                  <0,-0.3,0>, <0,0.3,0>, 0.1
                  texture { pigment{image_map { png "lata_krowy.png"}}}
                }
                object {
                  cotovelo
                  translate <0,-0.3,0>
                }
        }
        
        // Corpo da vaca com todos os membros posicionados
        #local corpo = union {
                sphere {
                  <0,0,0>, 1
                  scale <0.5,1,0.7>
                  texture { pigment{image_map { png "lata_krowy.png"}}}    // Corpo texturizado
                }
                object {
                  pescoco
                  translate <0, 1 ,0>
                }
                object {
                  mamas
                  translate <0,-0.3,-0.5>
                }
                object {
                  perna
                  rotate <45*sin(clock*360),0,0>   // Movimento da perna sincronizado com o tempo
                  translate <0.22,-0.8,0>
                }
                object {
                  perna
                  rotate <-45*sin(clock*360),0,0>
                  translate <-0.22,-0.8,0>
                }
                object {
                  braco
                  translate <0,-0.2,0>
                  rotate <-45*sin(clock*360),0,0>
                  rotate <0,-10,0>
                  rotate <0,0,30>
                  translate <0.3,0.8,0>
                }
                object {
                  braco
                  translate <0,-0.2,0>
                  rotate <45*sin(clock*360),0,0>
                  rotate <0,10,0>
                  rotate <0,0,-30>
                  translate <-0.3,0.8,0>
                }
        }
        
        object {corpo}    // Desenha a vaca completa
    
#end
