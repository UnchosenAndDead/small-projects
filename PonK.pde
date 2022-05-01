int ballR=10;
int ballX=250;
int ballY=250;
int ballVX=3;
int ballVY=0;

boolean up1, up2, down1, down2;

int st1X=10;
int st2X=480;
int st1Y=200;
int st2Y=200;
int stW=10;
int stH=100;

void reset(){
  ballX=250;
  ballY=250;
}

void moveBall(){
  ballX+=ballVX;
  ballY+=ballVY;
  if(ballY<=0||ballY>=height){
    ballVY*=-1;
  }
  if(ballX<=st1X+stW&&ballY>=st1Y&&ballY<=st1Y+stH){
    ballVX*=-1;
    if(ballVY<=0&&up1){
      ballVX-=1;
      ballVY-=1;
    }
    if(ballVY<=0&&down1){
      ballVX+=1;
      ballVY+=1;
    }
    if(ballVY>=0&&up1){
      ballVX+=1;
      ballVY-=1;
    }
    if(ballVY>=0&&down1){
      ballVX-=1;
      ballVY+=1;
    }
  }
  if(ballX>=st2X&&ballY>=st2Y&&ballY<=st2Y+stH){
    ballVX*=-1;
  }
}

void drawStick(){
  rect(st1X, st1Y, stW, stH);
  if(st1Y>=0&&st1Y+stH<=height){
    if(keyPressed){
      if(key=='w'){
        st1Y-=5;
        up1=true;
      }
      if(key=='s'){
        st1Y+=5;
        down1=true;
      }
    }
  } else{
    if(st1Y<0){
      st1Y+=1;
    }
    if(st1Y+stH>height){
      st1Y-=1;
    }
  }
  
  rect(st2X, st2Y, stW, stH);
  
  if(st2Y>=0&&st2Y+stH<=height){
    if(st2Y+stH-2<ballY){
    st2Y+=5;
    down2=true;
  }
  if(st2Y+2>ballY){
    st2Y-=5;
    up2=true;
  }
  } else{
    if(st2Y<0){
      st2Y+=1;
    }
    if(st2Y+stH>height){
      st2Y-=1;
    }
  }
}

void setup(){
  size(500,500);
  background(0,0,0);
  
}

void draw(){
  frameRate(60);
  background(0,0,0);
  drawStick();
  moveBall();
  ellipse(ballX, ballY, ballR, ballR);
  up1=false;
  up2=false;
  down1=false;
  down2=false;
  if(ballX<0||ballX>width){
    reset();
  }
}
