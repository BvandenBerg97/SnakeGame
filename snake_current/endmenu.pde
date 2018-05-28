class EndMenu{
  PFont gamefont;
  
  EndMenu(){
    gamefont = createFont("fontGO.TTF",24);
  }
  
  void display(){
    
    //Text Information on start screen
    background(0);
    textFont(gamefont);
    textSize(50);
    fill(255);
    textAlign(CENTER);
    text("Game Over",width/2,235);
    textSize(23);
    text("Congratulations,",width/2,330);
    textSize(15);
    text("you played yourself",width/2,360);
    
    //Go to Game button
    if ((mouseX > 235)&&(mouseX < 565) && (mouseY > 440) && (mouseY < 475)) {
      fill(135,232,1);
    } else {
      fill(190,0,232);
    }
    
    rectMode(CENTER);
    rect(width/2,460,335,42);
    noStroke();
    textSize(15);
    fill(10);
    text("Retry?",width/2,467);
  }  
}
