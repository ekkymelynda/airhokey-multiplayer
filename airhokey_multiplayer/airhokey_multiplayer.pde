import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

float velP2;
float posP2_X;
float posPILOTA_X=width/2;
float posPILOTA_Y=height/2;
float transpP=255;
float transpPRAND;
float velX;
float velY;
float velX2;
float velY2;
float contadorRand;
float n=0;
float transp=255;
float c1;
float c2;
float c3;
float c4=255;
int P1SCORE=0;
int P2SCORE=0;
float mida=20;
color c=color(100);
boolean stop=false;
boolean gameStart= true;

AudioPlayer wins;
Minim minim;
 
void setup() {
  size(600, 700);
  
  //NILAI AWAL
  
  velX=7;
  velY=9;
  velX2=9;
  velY2=9;
  contadorRand=0;
  posPILOTA_X=width/2;
  posPILOTA_Y=height/2;
  noCursor();
  
  minim = new Minim(this);
  wins = minim.loadFile("SuaraTepukTangan.wav", 2048);
}
 
 
void draw() {
 
  fill(c1, c4, c3, 30);
  noStroke();
  rect(0, 0, width, height);
  
  //LAPANGAN PERTANDINGAN
  
  stroke(c4, transp);
  strokeWeight(8);
  line(0, height/2, width, height/2);
  fill(c4);
  ellipse(width/2, height/2, 20, 20);
  noFill();
  ellipse(width/2, height/2, 100, 100);
  //porteries
  ellipse(width/2, height, 200, 200);
  ellipse(width/2, 0, 200, 200);
  
  if (stop==false) {
    textAlign(CENTER, CENTER);
    textSize(40);
    text("CLICK TO PLAY", width/2, height/2+100);
    textAlign(CENTER, CENTER);
    fill(0, 0, 255);
    text("P1 LEFT / RIGHT", width/2, height/2-270); 
    fill(255, 0, 0);
    text("P2 ARROWS", width/2, height/2+270);
  }
  
  if (mousePressed && gameStart==true) {
    stop=true;
    gameStart=false;
  }
 
  if (stop==true) {
    
    //bola
 
    posPILOTA_X=posPILOTA_X+velX;
    posPILOTA_Y=posPILOTA_Y+velY;
 
    fill(255, 255, 255, transpP); //warna putih
    //fill(c);
    noStroke();
    ellipse(posPILOTA_X, posPILOTA_Y, 10, 10);  //ukuran bola
    //ellipse(posPILOTA_X, posPILOTA_Y, mida, mida);
 
    if (posPILOTA_X >= width) {
      velX = -velX;
      posPILOTA_X = width;
    }
 
    if (posPILOTA_Y >= height) {
      velY = -velY;
      posPILOTA_Y = height;
    }
 
    if (posPILOTA_X <= 0) {
      velX = -velX;
      posPILOTA_X = 0;
    }
 
    if (posPILOTA_Y <= 0) {
      velY = -velY;
      posPILOTA_Y = 0;
    }
 
    //P1 (BERGERAK DENGAN MOUSE)
    
    fill(255, c2, c3, transp);
    rect(mouseX-50, height/2+300, 100, 20);
 
 
    //P2 (TANDA PANAH)
    
    velP2=20; //velocitat de moviment del P2
 
    if (keyPressed && keyCode  == LEFT) {
      posP2_X = posP2_X-velP2;
      if (posP2_X<0) {
        posP2_X=0;
      }
    }
    
    if (keyPressed && keyCode  == RIGHT) {
      posP2_X = posP2_X+velP2;
      if (posP2_X>width) {
        posP2_X=width;
      }
    }
    
    fill(c1, c2, 255, 255);
    rect(posP2_X-50, height/2-300, 100, -20);
    
    //REBOTE P1
    
    if ((posPILOTA_X > mouseX-50) && (posPILOTA_X <mouseX+50)) {
      if (posPILOTA_Y>height/2+300 && posPILOTA_Y<height/2+310) {
        velY = -(velY);
        contadorRand=contadorRand+1;
      }
    }
 
    //REBOTE P2
 
    if ((posPILOTA_X > posP2_X-50) && (posPILOTA_X < posP2_X+50)) {
      if (posPILOTA_Y < height/2-300 && posPILOTA_Y > height/2-310) {
        velY=-velY;
        contadorRand=contadorRand+1;
      }
    }
 
    //FINAL WAFE
 
    if (contadorRand >= 10) {
 
      transp=random(0, 100);
      c1=random(0, 255);
      c2=random(0, 255);
      c3=random(0, 255);
      c4=0;
      transpPRAND=random(0, 1);
      textSize(60);
      textAlign(CENTER, CENTER);
      fill(255, 0, 0, random(0, 255));
      text("FINAL WAVE", width/2, height/2);
      
      if (transpPRAND > 0.90) {
        transpP=255;
      } else {
        transpP=0;
      }
    }
 
    if ( contadorRand >= 15) {
      contadorRand=0;
      transp=255;
      transpP=255;
      c1=0;
      c2=0;
      c3=0;
      c4=255;
    }
 
    //RATING
    
    textAlign(CENTER, CENTER);
    textSize(20);
    fill(0, 0, 255);
    text("score="+P1SCORE, 530, height/2-70);
    text("PLAYER 1", width/2-230, height/2-70);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text("score="+P2SCORE, 530, height/2+70); 
    text("PLAYER 2", width/2-230, height/2+70);
 
    if ( posPILOTA_X >= width/2-100 && posPILOTA_X <= width/2+100) {
      if (posPILOTA_Y>=height) {
        P1SCORE=P1SCORE+1;
      }
    }
    
    if ( posPILOTA_X >= width/2-100 && posPILOTA_X <= width/2+100) {
      if (posPILOTA_Y<=0) {
        P2SCORE=P2SCORE+1;
      }
    }
  }
  
  if (P1SCORE>=10) {
    stop=false;
    if (stop==false) {
      textAlign(CENTER, CENTER);
      fill(0, 0, 255, 255);
      textSize(70);
      wins.play();
      text("P1 WINS!", width/2, height/2);
    }
  }
  
  if (P2SCORE>=10) {
    stop=false;
    if (stop==false) {
      textAlign(CENTER, CENTER);
      fill(255, 0, 0, 255);
      textSize(70);
      wins.play();
      text("P2 WINS!", width/2, height/2);
    }
  }
}

void mouseClicked() {
  stop=true;
  P1SCORE=0;
  P2SCORE=0;
}

void stop()
{
  wins.close();
  minim.stop();
  super.stop();
}
