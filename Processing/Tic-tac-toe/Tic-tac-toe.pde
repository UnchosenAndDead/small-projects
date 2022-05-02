import javax.swing.JOptionPane;
char[][] grid = {{' ', ' ', ' '}, {' ', ' ', ' '}, {' ', ' ', ' '}};
PFont f;
char won=' ';
boolean xTurn=true;
boolean game=true;
char lost=' ';

void drawGrid(){
  rect(100, 100, 300, 300);
  line(200, 100, 200, 400);
  line(300, 100, 300, 400);
  line(100, 200, 400, 200);
  line(100, 300, 400, 300);
  textAlign(LEFT);
  for(int x=1; x<4; x++){
    for(int y=1; y<4; y++){
      fill(random(235), random(235), random(235));
      text(grid[x-1][y-1],100*x, 100*(y+1));      
    }
  }
  fill(255);
}

void mouseClicked(){
  int x=mouseX/100;
  int y=mouseY/100;
  if(x>0&&x<4&&y>0&&y<4){
    if(grid[x-1][y-1]==' '){
      if(xTurn){
        grid[x-1][y-1] = 'X';
        xTurn=false;
      }else{
        grid[x-1][y-1] = 'O';
        xTurn=true;
      }
    }
  }
}

boolean checkWin(){
  boolean temp = false;
  for(int i=0; i<3; i++){
    if((grid[i][0]==grid[i][1]&&grid[i][0]==grid[i][2]&&grid[i][0]=='X')||(grid[0][i]==grid[1][i]&&grid[0][i]==grid[2][i]&&grid[0][i]=='X')){
      temp = true;
      won='X';
      lost='O';
    }
    if((grid[i][0]==grid[i][1]&&grid[i][0]==grid[i][2]&&grid[i][0]=='O')||(grid[0][i]==grid[1][i]&&grid[0][i]==grid[2][i]&&grid[0][i]=='O')){
      temp = true;
      won='O';
      lost='X';
    }
  }
  if((grid[0][0]==grid[1][1]&&grid[0][0]==grid[2][2]&&grid[0][0]=='X')||(grid[2][0]==grid[1][1]&&grid[2][0]==grid[0][2]&&grid[2][0]=='X')){
    temp = true;
    won='X';
    lost='O';
  }
  if((grid[0][0]==grid[1][1]&&grid[0][0]==grid[2][2]&&grid[0][0]=='O')||(grid[2][0]==grid[1][1]&&grid[2][0]==grid[0][2]&&grid[2][0]=='O')){
    temp = true;
    won='O';
    lost='X';
  }
  boolean tempt2=false;
  for(int k=0; k<3; k++){
    for(int g=0; g<3; g++){
      if(grid[k][g]==' '){
        tempt2=true;
      }
    }
  }
  if(!tempt2&&won==' '){
    temp=true;
  }
  return temp;
}

void setup(){
  size(500,500);
  background(0,0,0);
  f = createFont("Arial",130,false); 
}

void draw(){
  if(game){
    frameRate(4);
    background(0,0,0);
    textFont(f);
    drawGrid();
    if(checkWin()){
      if(won!=' '){
        JOptionPane.showMessageDialog(null,won + " won. "+ lost+ " is actually retarded lmao");
      }else{
        JOptionPane.showMessageDialog(null,"you both suck equally");
      }
      game=false;
    }
  }
}
