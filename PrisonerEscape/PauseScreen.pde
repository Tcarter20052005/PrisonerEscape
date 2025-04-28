// Pause screen class
// Extends screen class as is ui
class PauseScreen extends Screen
{ 
  // Required screen elements
  Text title;
  Button Resume, Exit;
  
  PauseScreen()
  {
    
    color textcol = color(0, 0, 0);
    
    // required text
    title = new Text("Pause", width/2, 45, "Montserrat-ExtraBold.ttf", 18, CENTER, textcol);
    
    // Button y positions
    float ResumeButtonY = (height/2) - 40;
    float ExitButtonY = (height/2) + 40;
    
    // Buttons
    Resume = new Button(width/2, ResumeButtonY, 2,37.5, "Resume"); 
    Exit = new Button(width/2, ExitButtonY, 2,37.5, "Exit"); 
  }
  
  // Display Screen
  void Display()
  {
    title.display();
    Resume.display();
    Exit.display();
  }
  
  void Background()
  {
    
  }
  
  void ButtonCheck() // To Be called on Mouse Press
  {
    if (Resume.IfOver(mouseX,mouseY))
    {
      clock.Pause();
      gamemode = gameMode.PLAYING;
    }
    else if (Exit.IfOver(mouseX,mouseY))
    {
      gamemode = gameMode.START;
    }
  }
  
  void Input() // To be called on key press
  {
    
  }
}
