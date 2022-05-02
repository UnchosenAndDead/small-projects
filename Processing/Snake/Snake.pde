import javax.swing.JOptionPane;
class Tile{
  int x, y;
  boolean s, a;
  Tile(int nx, int ny){
    x=nx;
    y=ny;
    s=false;
    a=false;
  }
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  boolean getS(){
    return s;
  }
  boolean getA(){
    return a;
  }
  void changeS(){
    s=!s;
  }
  void changeA(){
    a=!a;
  }  
}

Tile[][] grid = new Tile[20][20];
Tile[] snek = new Tile[390];
int size=2;
char dir = 's';
boolean app=false;
boolean game=true;

void setup(){
  size(200, 200);
  frameRate(20
  );
  
  for(int i=0; i<20; i++){
    for(int j=0; j<20; j++){
      grid[i][j]=new Tile(i, j);
    }
  }  
  snek[0]=grid[0][0];
  snek[0].changeS();
  snek[1]=grid[1][0];
  snek[1].changeS();
  snek[2]=grid[2][0];
  snek[2].changeS();
}

void draw(){
  if(game){
  background(0);  
  for(int i=0; i<20; i++){
    for(int j=0; j<20; j++){
      if(grid[i][j].getS()){
        fill(random(30,255),random(30,255),random(30,255));
        rect(i*10, j*10, 10, 10);
      }
      if(grid[i][j].getA()){
        fill(255, 0, 0);
        rect(i*10, j*10, 10, 10);
      }
    }
  }
  fill(0);
  move();
  if(!app){
    spawnApple();
    app=true;
  }
  delay(100);
  }
}

void move(){
  if(dir=='w'){
    int newY=snek[0].getY()-1;
    snek[size].changeS();
    if(newY==-1){
      newY=19;
    }
    if(grid[snek[0].getX()][newY].getA()){
      eat('w');
    }else{
      if(grid[snek[0].getX()][newY].getS()){
      loss();
    }
    for(int i=size; i>0; i--){
      snek[i]=snek[i-1];
    }
    snek[0]=grid[snek[0].getX()][newY];
    snek[0].changeS();      
  }
  }
  if(dir=='s'){
    int newY=snek[0].getY()+1;
    snek[size].changeS();
    if(newY==20){
      newY=0;
    }
    if(grid[snek[0].getX()][newY].getA()){
      eat('s');
    }else{
      if(grid[snek[0].getX()][newY].getS()){
      loss();
    }
    for(int i=size; i>0; i--){
      snek[i]=snek[i-1];
    }
    snek[0]=grid[snek[0].getX()][newY];
    snek[0].changeS();
  }
  }
  if(dir=='d'){
    int newX=snek[0].getX()+1;
    snek[size].changeS();
    if(newX==20){
      newX=0;
    }
    if(grid[newX][snek[0].getY()].getA()){
      eat('d');
    }else{
      if(grid[newX][snek[0].getY()].getS()){
      loss();
    }
    for(int i=size; i>0; i--){
      snek[i]=snek[i-1];
    }
    snek[0]=grid[newX][snek[0].getY()];
    snek[0].changeS();
    }
  }
  if(dir=='a'){
    int newX=snek[0].getX()-1;
    snek[size].changeS();
    if(newX==-1){
      newX=19;
    }
    if(grid[newX][snek[0].getY()].getA()){
      eat('a');
    }else{
       if(grid[newX][snek[0].getY()].getS()){
      loss();
    }
    for(int i=size; i>0; i--){
      snek[i]=snek[i-1];
    }
    snek[0]=grid[newX][snek[0].getY()];
    snek[0].changeS();
    }
  }
}

void keyPressed(){
  if(key=='w'){
    if(dir=='a'^dir=='d'){
      dir='w';
    }
  }
  if(key=='s'){
    if(dir=='a'^dir=='d'){
      dir='s';
    }
  }
  if(key=='a'){
    if(dir=='s'^dir=='w'){
      dir='a';
    }
  }
  if(key=='d'){
    if(dir=='w'^dir=='s'){
      dir='d';
    }
  }
}

void spawnApple(){
  boolean temp = true;
  while(temp){
    int x=(int)random(20);
    int y=(int)random(20);
    if(!grid[x][y].getS()){
      grid [x][y].changeA();
      temp=false;
    }
  }
}

void eat(char m){
  
  for(int i=size; i>=0; i--){
    snek[i+1]=snek[i];
  }
  size++;
  if(m=='w'){
    int newY=snek[0].getY()-1;
    if(newY==-1){
      newY=19;
    }
    snek[0]=grid[snek[0].getX()][newY];
    snek[0].changeS();
    snek[size].changeS();
    grid[snek[0].getX()][snek[0].getY()].changeA();
    app=false;
  }
  if(m=='s'){
    int newY=snek[0].getY()+1;
    if(newY==20){
      newY=0;
    }
    snek[0]=grid[snek[0].getX()][newY];
    snek[0].changeS();
    snek[size].changeS();
    grid[snek[0].getX()][snek[0].getY()].changeA();
    app=false;
  }
  if(m=='a'){
    int newX=snek[0].getX()-1;
    if(newX==-1){
      newX=19;
    }
    snek[0]=grid[newX][snek[0].getY()];
    snek[0].changeS();
    snek[size].changeS();
    grid[snek[0].getX()][snek[0].getY()].changeA();
    app=false;
  }
  if(m=='d'){
    int newX=snek[0].getX()+1;
    if(newX==20){
      newX=0;
    }
    snek[0]=grid[newX][snek[0].getY()];
    snek[0].changeS();
    snek[size].changeS();
    grid[snek[0].getX()][snek[0].getY()].changeA();
    app=false;
  }  
}

void loss(){
  JOptionPane.showMessageDialog(null,"ha u succ");
  game=false;
}
