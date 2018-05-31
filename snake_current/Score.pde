class Score{// a class to control the Score representation

  int scoreTextSize;
  int gameTextSize;
  PFont gamefont;
  color c;
  int score = 0;
  
  Score(){                       // class constructor
    scoreTextSize = 14;          // setting text size to 24 to display score
    gamefont = createFont("fontGO.TTF",24);
    c = versus.c;
    
  }
    void displayP1(){            // function that displays the score
      fill(135,232,1);           //determine color of player score
      textAlign(CORNER);
      textSize(scoreTextSize);
      text("Score "+ ((snake.snakeSize*100)-100),29,45); // display the score as 100* the food player eats
    }
    
    void displayAI(){            // function that displays the score
      fill(c);                   //color of player score
      textAlign(CORNER);
      textSize(scoreTextSize);
      text("Score "+ ((versus.len*100)-100),605,45); // display the score as 100* the food player eats
    }
    
    void gameName(){            // function that displays game name  
      fill(128,0,156);                // make the text colour light grey
      textAlign(CORNER);  
      textFont(gamefont);
      text("Snake",width/2 - 157,45);    //display the text under eachother to improve visibility
      text("Game",width/2 + 32,45);
      fill(255);                   // blue(66,109,199) or purple(128,0,156)
      textFont(gamefont);
      text("Snake",width/2 - 156,46);    //display the text under eachother to improve visibility
      text("Game",width/2 + 33,46);
    }

}
