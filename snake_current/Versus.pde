class Versus{
  
  int[] xpos; //x position aisnake array pieces  
  int[] ypos; //y position aisnake array pieces
  color c; // enemy color
  int d;   //snake direction
  int len; // snake's current length 
  boolean alive;
  int x, y; // positions of versus snake's head
  int sspeed;

  Versus(int tempspeed){
    x = width/2;
    y = height/3;
    c = color(240,144,0); //(250,95,61)red or (67,181,30)green
    xpos = new int[150];
    ypos = new int[150];
    
    len = 2;
    d = 1;
    sspeed = tempspeed;
    move();
  
  }
  
  void move(){
    switch(d){
      case 0:
        x = x + sspeed;
        break;
      case 1:
        y = y + sspeed;
        break;      
      case 2:
        x = x - sspeed;
        break;      
      case 3:
        y = y - sspeed;
        break;
    }
  }
  
  
  void getnewY(){
    //check for which direction it should go on X, right or left?
    if(x > foodX) goLeft();
    if(x < foodX) goRight();
  }
  
  void getnewX(){
    //check for which direction it should go on Y, up or down?
    if(y > foodY) goUp();
    if(y < foodY) goDown();
  }
  
  void goLeft(){
    if(d!=0) d = 2;
  }
  
  void goDown(){
    if (d!=3) d = 1;
  }
  
  void goRight(){
    if(d!=2) d = 0;
  }
  
  void goUp(){
    if(d!=1) d = 3;
  }
  
  void goeat(){
    getnewX();
    getnewY();
    
  }
  
  /*
  
  void goeat(){ // direct self towards egg  
    println(foodX+ " " + foodY);
    if ((foodY < y-5 || foodY < y+5) && d!=1){ 
      d = 3; 
      println("up");
    } else if (foodX < x && d!=0){
      d = 2; 
      println("left");
    } else if ((foodY > y-5 || foodY > y+5) && d!=3){
      d = 1; 
      println("down");
    } else if (foodX > x && d!=2){
      d = 0; 
      println("right");
  }
    
  }*/
  
  void display(){
    // Here comes the part where the tail is created
    // Shift the values to the right
    for (int i = len-1; i > 0; i--) {
      xpos[i] = xpos[i-1];
      ypos[i] = ypos[i-1];
    }
    
    // Add the new values to the beginning of the array
    xpos[0] = x;
    ypos[0] = y;
    
    fill(c);  // determine color of enemy (67,181,30) dark green
    for (int i = 0; i < len; i ++) {
      rect(xpos[i], ypos[i], 20, 20,5);
    }
  }

  void increaseSize(){ // if increaseSize is called the size of the snake is increased
      len++;    
  }
}
