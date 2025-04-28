// Splash screen class

// Splash screen extends screen as is a ui screen
class SplashScreen extends Screen
{
  // Road and text objects
  Road road1;
  Text title, info;
  
  SplashScreen()
  {
    color textcol = color(0, 0, 0);
    
    // Create require UI screen elements
    road1 = new Road();
    title = new Text("Welcome To Prisoner Escape", width/2, 45, "Montserrat-ExtraBold.ttf", 18, CENTER, textcol);
    info = new Text("Welcome to Prisoner Escape!! \n You are the prisoner who has just escaped \n prison and is on the run. Although this escape \n wont be easy, the police are onto you! \n\n Dodge the police and \noutsmart their tactics and stay one step ahead. \nHow far will you get!! \n\n PRESS SPACE TO CONTINUE", width/2, height/2, "Montserrat-Regular.ttf", 12.3, CENTER, textcol );
    
  }
  
  // Display all ui surfaces
  void Display()
  {
    Background();
    title.display();
    info.display();
  }
  
  void Background()
  {
    road1.display(); // Display background
  }
  
  void ButtonCheck() // Handle button click interactions
  {
  }
  
  void Input() // To be called on key press
  {
    if (key == ' ') {
      gamemode = gameMode.START;  // Transition to start game mode when space is pressed
      println("Starting game...");
    }
  }
}
