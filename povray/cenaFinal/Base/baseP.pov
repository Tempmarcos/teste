#include "shapes.inc"      // Inclusão de formas básicas do POV-Ray
#include "textures.inc"    // Inclusão de texturas básicas
#include "colors.inc"      // Inclusão das cores padrão
#include "woods.inc"       // Inclusão de texturas de madeira
#include "metals.inc"      // Inclusão de texturas metálicas
#include "baseI.inc"     // Inclusão de objetos personalizados (arquivo extra)

// Declaração de variável para deslocamento que varia com o tempo (clock)
#declare deslocamento = -clock*40;


// Céu esférico com gradiente e efeito de nuvens turbulentas
sky_sphere {
  pigment {
    gradient z   // Gradiente na direção z (vertical)
    color_map {
      [0.5 color <0, 0.74609375, 0.99609375>] // Azul claro no meio
      [1.0 color MidnightBlue]                 // Azul escuro no topo
    }
    scale 2   
  }
  pigment {
    bozo                // Efeito de nuvem tipo "bozo"
    turbulence 0.9      // Turbulência para nuvens realistas
    omega 0.7           // Frequência de turbulência
    color_map {
      [0.0 color rgb <0.85, 0.85, 0.85>]     // Cinza claro na base
      [0.1 color rgb <0.75, 0.75, 0.75>]     // Cinza um pouco mais escuro
      [0.5 color rgbt <1,1,1,1>]              // Branco translúcido no meio
      [1.0 color rgbt <1,1,1,1>]              // Branco translúcido no topo
    }
    scale <0.6, 0.3, 0.3>                     // Escala do efeito turbulento
  }
}


// Plano horizontal verde representando o chão
plane {
  y, 0             // Plano no eixo Y, na altura 0 (chão)
  pigment {color Green}  // Cor verde para o chão
}


// Fonte de luz principal, área de luz
light_source {
  <0, 15, -45>         // Posição da luz
  color White          // Cor da luz branca
  area_light <30, 0, 0>, <0, 0, 30>, 2, 2   // Luz de área para sombras suaves
  adaptive 1           // Ajuste adaptativo para qualidade
  jitter               // Aleatoriza a luz para suavizar sombras
}

// Segunda fonte de luz mais distante e intensa
light_source {
  <0, 300, -500>       // Luz distante para iluminação geral
  color White
}


// câmera posicionada do lado esquerdo
camera {
  location <-50, 7, 20>     // Posição da câmera
  look_at <-60, 7, 30>      // Direção que a câmera está olhando
}



// Macro para criar uma vaca
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
        
        // Úbere da vaca
        #local teta = union {
                cylinder {
                  <0,0,-0.2>
                  <0,0,0.2>
                  0.08
                  pigment {color  rgb <0.9,0.8,0.8>}   // Cor rosada clara
                } 
        }
        
        // Conjunto de úberes (quatro) posicionados e rotacionados
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


/*
  ****************************************************************************************
  *************************   FUNÇÃO PRINCIPAL   *****************************************
  ****************************************************************************************
*/

// Instancia e posiciona três objetos do tipo 'galinha' (galinha)
// Com deslocamento variável no eixo Z controlado pela variável 'deslocamento'

object {
        galinha()
        //translate <-60, 5, 30>   // Comentado, posição original fixa
        translate <-60, 5, 50 + deslocamento>  // Translada com deslocamento variável no eixo Z
}
object {
        galinha()
        //translate <-60, 5, 30>
        translate <-68, 5, 58 + deslocamento>
}
object {
        galinha()
        //translate <-60, 5, 30>
        translate <-64, 5, 66 + deslocamento>
}


// ******  CENÁRIO  ******


// Instancia e posiciona o objeto 'casa' (casa)
object {
  casa(-10)            // Chama a função 'casa' com parâmetro -10 (possível altura ou outra característica)
  scale <10, 10, 10>  // Escala o objeto 10 vezes em todos os eixos
  rotate <0, -90, 0>  // Rotaciona o objeto em Y para alinhamento correto
  translate <-100, 20, 50>  // Posiciona no espaço 3D
}

// Instancia e posiciona o objeto 'arvore' (árvore)
object {
  arvore()
  scale <10, 10, 10>
  rotate <0, 20, 0>
  translate <-90, 6, 110>
}

// Instancia e posiciona o objeto 'ancinho' (ancinho)
object {
  ancinho()
  scale <3, 3, 3>
  rotate <-90, 0, 0>    // Rotação em X
  rotate <0, -90, 0>    // Rotação em Y
  rotate <0, 0, 20>     // Rotação em Z
  translate <-73, 6, 35>
}

// Instancia e posiciona o objeto 'regador' (regador)
object {
  regador()
  scale <11, 11, 11>
  translate <-74, 1, 42>
}

// Instancia e posiciona o objeto 'vaca' (vaca)
object {
  vaca()
  scale <3, 3, 3>
  translate <-60, 6, 40 + deslocamento>  // Também com deslocamento variável no eixo Z
}
