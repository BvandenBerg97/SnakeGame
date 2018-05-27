class Snake {
  // data of the snake class
  int[] xpos; //x position snake array pieces  
  int[] ypos; // y position of snake array pieces
  
  int snakeX; // x position of snake head
  int snakeY; // y position of snake head
  int speedX; //speed snake moves on x axis
  int speedY; // speed snake moves on y axis 
  color c; // colour of snake 
  boolean death = false;
  
  int snakeSize;  // length of snake (how many 'blocks')
  
  
  int startX; //starting x position of snake
  int startY; //starting y position of snake 
  
  //constructor
  Snake(){
    
   startX = width/2;
   startY = height/2;
    
   snakeX = startX-5;
   snakeY = startY-5;
   xpos = new int [150]; // array that can hold 150 pieces 
   ypos = new int [150];
   speedX = 0;
   speedY = 0;
   c = color(135,232,1); // green colour for the snake model pale green(189,251,87) or neon light green(135,232,1)
   
   snakeSize = 1;        // snake starts at the size of 1 block
    }
    
   //functions
   //appearance of snake model
   void display(){
      rectMode(CENTER);
      fill(c);
      for(int i = 0; i < snakeSize; i ++) {
        rect(xpos[i], ypos[i], 20, 20,5);   //create the same rect at every point in the array
      }
    
      for(int i = snakeSize; i > 0; i--){  //positioning of tail pieces
        xpos[i] = xpos[i-1];
        ypos[i] = ypos[i-1];
      }
    } 
    
    void move(){
      snakeX += speedX;     
      snakeY += speedY;
      
      //Prohibit snake from touching walls
      if((snakeX > width-13)||(snakeX < 35)){
        snake.death();
        speedX = 0;
      }  
      
      if ((snakeY > height - 20)||(snakeY < 115)){
        snake.death();
        speedY = 0;
      }
  
  xpos[0] = snakeX;
  ypos[0] = snakeY;
  
  }
  void increaseSize(){ // if increaseSize is called the size of the snake is increased
      snakeSize++;    
  }
  void death(){
    
    for(int i = 1; i < snakeSize; i++){            // when the snake hits it's own body the game resets.
       if(snakeX == xpos[i] && snakeY== ypos[i]){   // set size back to 1 when the head hits the body
         snakeSize = 1;
         death = true;
      }
    }   
  }
}
