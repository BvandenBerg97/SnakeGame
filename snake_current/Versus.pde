class Versus{
  
  int[] xpos; //x position aisnake array pieces  
  int[] ypos; //y position aisnake array pieces
  color c;     // enemy color
  int d;       //snake direction
  int len;     // snake's current length 
  boolean alive, dead, tooclose;
  int x, y;    // positions of versus snake's head
  int futx, futy; //anticipated positions of snake's head
  int sspeed;
  int previousMove = -1;

  Versus(){
    x = width/2;          //Snake starting position
    y = height/3;
    c = color(191,1,232); //(250,95,61)red or (67,181,30)green or purple 128,0,156 or orange (240,144,0)
    xpos = new int[150];
    ypos = new int[150];
    
    len = 2;              // ALWAYS NEEDS TO BE 2 BECAUSE OTHERWISE IT GETS THE WEIRDEST BUGS
    d = 1;
    move();
    dead = false;
    tooclose = false;
    sspeed = 10;
  
  }
  
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
    
    //creating snake eyes
    fill(255);
    arc(x+4,y,6,6, radians(-45), PI, CHORD);
    arc(x-5,y,6,6, 0, PI+QUARTER_PI, CHORD);
    fill(255,0,0);
    ellipse(x+4,y+1,3,3);
    ellipse(x-5,y+1,3,3);

    
    //Prohibit snake from touching walls
    if((x > width+25)||(x < -25)){
      versus.death();
      sspeed = 0;
      x = width/2; //reset snake starting position NOT WORKING          
    }  
    
    if ((y > height + 35)||(y < 0)){
      versus.death();
      sspeed = 0;
      y = height/3; //reset snake starting position NOT WORKING 
    }
  }
  
  /*boolean crash(int d){ // WORK IN PROGRESS, DISREGARD FOR NOW
      switch(d){
        case 0: 
          futx = x + sspeed ;
          futy = y + 10;
        case 1:
          futx = x - 5;
          futy = y + sspeed;
        case 2:
          futx = x - sspeed;
          futy = y + 10;
        case 3:
          futx = x - 5;
          futy = y - sspeed;
      } 
      //println("FUT  "+ futx + " . "+ futy);
      //println(len);
      //println(d);
      for(int i = 1; i < len; i ++){
        //println("BODY   "+xpos[i] + " . "+ ypos[i]);
     
        if(xpos[i] == futx && ypos[i] == futy){
          //println("im gonna crash");
          return true;
        }
      }
      println("============");
     return false;
  }*/
  
  void move(){    //AI snake movement
    tooclose = false;
    difficulty();
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
        break;}
        
    for (int i = 0; i < snake.snakeSize; i ++) {   // print when AI gets too close to player, probably not best way to do stuff though
      if (dist(x,y,snake.xpos[i],snake.ypos[i]) < 10){
        tooclose = true;
        println("too close");
      } 
    }
  }
  
  void goLeft(){
    d = 2;
    //crash(d);
  }
  void goDown(){
    d = 1;
    //crash(d);
  }
  void goRight(){
    d = 0;
    //crash(d);
  }
  void goUp(){
    d = 3;
    //crash(d);
  }
  
  int getnewX(){
    println(previousMove);
    //check for which direction it should go on X, right or left?
    if(x > foodX + 5){ 
        if(previousMove != 0){ // As long as you're not moving in the opposite direction, go this way
          goLeft();
          previousMove = 2;
        } else {
          goUp();
          previousMove = 3;
        }
      return 2;}
      
    if(x < foodX - 5){ 
      if(previousMove != 2){ // As long as you're not moving in the opposite direction, go this way
          goRight();
          previousMove = 0;
        } else {
          goUp();
          previousMove = 3;
        }
      return 0;}
      
     return -1; 
  }
  
  int getnewY(){
    //check for which direction it should go on Y, up or down?
    if(y > foodY + 5){ 
      if(previousMove != 1){ // As long as you're not moving in the opposite direction, go this way
          goUp();
          previousMove = 3;
        } else {
          goLeft();
          previousMove = 2;
        }
      return 3; // return that you're going right
    }
      
    if(y < foodY - 5){ 
      if(previousMove !=3){ // As long as you're not moving in the opposite direction, go this way
        goDown();
        previousMove = 1;
      } else {
          goLeft();
          previousMove = 2;
        return 1; // return that you're going left
        }
    }
    return -1; // in case neither are satisfied
  }

  void goeat(){
    int newx = getnewX();
    if(newx == -1){
      getnewY();
    }
  }

  void increaseSize(){ // if increaseSize is called the size of the snake is increased
      len++;    
  }
  
  void difficulty(){ // change speed of snake depending on player performance
    if (len <= snake.snakeSize){
      sspeed = 15;
    } else {
      sspeed = 10;
    }
  }
  
  void death(){
    for(int i = 1; i < len; i++){            // when the snake hits it's own body the game resets.
       if(x == xpos[i]  && y== ypos[i]){   // set size back to 1 when the head hits the body
         len = 2;
         snake.snakeSize = 1;
         dead = true;
         error = true;
         end = false;
         start = false;  
      }
    }  
  }
}
