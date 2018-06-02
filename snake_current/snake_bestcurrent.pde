// Snake Game
// by Bram Peters
/* about: In this revamp of the classic game of snake with the arrowkey you control a snake
that gets bigger every time you pick up food. Try to get the highest score, but try to
not run in to yourself. Have fun!*/

/*TO DO: 
 - Player collision w/AI -- > lose life
 - Lives
 - Power ups
*/

import processing.sound.*;   // import sound for background music

Snake snake;                // declaring the classes
Versus versus;
Score myscore;

Menu gameMenu;              //declare start menu
EndMenu endMenu;            //declare end menu
ErrorMenu errorMenu;        //declare error menu

SoundFile eating;
SoundFile theme;

int x1;                      //wall coordinates
int x2;
int y1;
int y2;

int playerspeed;            //determine how fast player can move

float foodX;                  // position of food
float foodY;

int groundsize;

float distance;                // distance of food and snake head
float aidistance;              //distance food and ai

//game booleans for menu, starting game and then for game over screen and error screen
boolean menu, start, end, error;


void setup(){
  //GAME SETUP
  size(800,600);           // setting the window size to 600 by 400 pixels
  snake = new Snake();     // initiating the functions from their respective classes
  versus = new Versus ();   //create the ai overlord snake!
  
  myscore = new Score();
  
  gameMenu = new Menu();    //initiate menu
  endMenu = new EndMenu();  //initiate end menu
  errorMenu = new ErrorMenu(); // initiate error menu

  //SET BOOLEANS
  menu = true;              //menu is displayed at start
  start = false;
  end = false;
  error = false;

  frameRate(10);           /* capping the framerate to make the game not too hard and to retain the classic feel of Snake  */

  //FOOD STARTING POSITION
  foodX = rand(20,width/2);
  foodY = height/2;
  
  playerspeed = 15;
  
  groundsize = 300;
  
  //SOUND
  gameoverSound = new SoundFile(this, "gameover.wav");
  eating = new SoundFile(this, "eating.wav");
  SoundFile theme = new SoundFile(this, "theme2.wav");
  theme.loop();
}

void draw(){
  //DISPLAY MENUS//
  //Start menu
  if(menu == true || (snake.death = true)){    
    gameMenu.display();
  }
  //Game over menu
  if(end == true || (menu == false)) {
    endMenu.display();
  }
  //Error menu
  if(error == true ){
    errorMenu.display();
  }
  
  
  //START OF GAME//
  if(start == true){
      background(0);                     //black background color(128,0,156)
      snake.display();                   //calling all the functions from the classes
      snake.move();                      //displaying and moving the player model 
      
      versus.move();
      versus.goeat();
      versus.display();
      
      snake.death();                     //setting losing state
      versus.death();
      
      showfood(foodX,foodY);             //display food

      myscore.displayP1();               //displaying score
      myscore.displayAI();
      myscore.gameName();
  
      //EDGES
      x1 = 5;
      while( x1 <= width){          //top edge of playing ground
        fill(255);
        rect(x1,80,10,10,2);
        x1 = x1 + 10;
      }
      
      x2 = 5;
      while( x2 <= width){         // bottom edge
        fill(255);
        rect(x2,height-9,10,10,2);
        x2 = x2 + 10; 
      }
      
      y1 = 90;
      while( y1 <= height - 9){    //left edge
        fill(255);
        rect(5,y1,10,10,2);
        y1 = y1 + 10;
      }
      y2 = 90;
      while(y2 <=height - 9){      //right edge
        fill(255);
        rect(width-5,y2,10,10,2);
        y2 = y2 + 10;
      }
      
      //SNAKE EATING
      distance = dist(foodX,foodY,snake.snakeX,snake.snakeY);
      aidistance = dist(versus.x, versus.y, foodX, foodY);
      
      //if the head of the snake collides with food, reset food and increase size. Margin of 20 pixels
      if(distance < 15 ){ 
        foodreset();
        snake.increaseSize();
        eating.play();
      }
      
      //if ai snake gets food, reset food 
      //ADD PENALTY FOR PLAYER?
      if(aidistance < 10){ 
        foodreset();
        versus.increaseSize();
        println("ate");
        eating.play();
      }
   }
}

   //FOOD CREATION
void showfood(float tempx, float tempy){// display food
    fill(255);
    ellipseMode(CENTER);               // food is represented as an ellipse 
    ellipse(tempx,tempy, 10, 10);
}
  
void foodreset(){                      //reset function when food is eaten
    foodX = (rand(4,78)*10);           //food locations all multiples of 10 so that AI has easier time catching them
    foodY = (rand(12,57)*10);
}   

//MOVEMENT CONTROLS
void keyPressed() { //snake controls the speed and directions of the snake with arrow keys, the if statement checks the pos of snake so it can't move into itself                                             
  if(keyCode == UP) {  if(snake.ypos[1] != snake.ypos[0]-playerspeed){snake.speedY = -playerspeed; snake.speedX = 0;}}      //snake cant move into the first 10 pieces of the tail directly
  if(keyCode == DOWN) {  if(snake.ypos[1] != snake.ypos[0]+playerspeed){snake.speedY = playerspeed; snake.speedX = 0;}}
  if(keyCode == LEFT) { if(snake.xpos[1] != snake.xpos[0]-playerspeed){snake.speedX = -playerspeed; snake.speedY = 0;}}
  if(keyCode == RIGHT) { if(snake.xpos[1] != snake.xpos[0]+playerspeed){snake.speedX = playerspeed; snake.speedY = 0;}}
}

//MENU BUTTON CONTROLS 
void mousePressed() {
  //START BUTTON
  if ((menu == true) && (mouseX > 235) && (mouseX < 565) && (mouseY > 440) && (mouseY < 475)) {
    start = true;  
    menu = false;
  }
  //restart while game is playing
  if ((start == true) && (mouseButton == RIGHT)) { 
    menu = true;
    start = false;
    snake.snakeSize = 1;
  }
  //START NEW GAME BUTTON
  if ((end == true) && (mouseX > 235) && (mouseX < 565) && (mouseY > 440) && (mouseY < 475)) {
    start = true;  
    end = false;
  }
  //ERROR RESTART BUTTON
  if ((error == true) && (mouseX > 235) && (mouseX < 565) && (mouseY > 440) && (mouseY < 475)) {
    start = true;  
    error = false;
  }
}

//imitate pmobile rand numbers
int rand(int minimum, int maximum){
  return int(random(minimum, maximum));
}
int rand(int maximum){
  return int(random(maximum));
}
