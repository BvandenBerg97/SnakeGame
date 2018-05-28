class ErrorMenu{
  
  PFont gamefont;
  
  ErrorMenu(){
      gamefont = createFont("fontGO.TTF",24);
    
  }
  void display(){
    
    //Text Information on start screen
    background(0);
    textFont(gamefont);
    textSize(40);
    fill(255);
    textAlign(CENTER);
    text("Error, AI died!",width/2,235);
    
    textSize(20);
    text("I guess player", width/2,300);
    text("wins...", width/2,370);
    
    textSize(30);
    fill(135,232,1);
    text("technically", width/2,340);
    
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
    text("Another Chance?",width/2,467);
  }  
}
