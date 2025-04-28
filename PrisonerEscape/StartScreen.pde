// Start screen class
// Extends screen class as is ui
class StartScreen extends Screen
{
  // Required display objects
  Road road2;
  Text title, highscore_Txt;
  Button Start, Exit;
  color textcol = color(0, 0, 0);
  
  StartScreen()
  {
    
    // Initialise background
    road2 = new Road();
    title = new Text("Prisoner Escape", width/2, 45, "Montserrat-ExtraBold.ttf", 18, CENTER, textcol);
    
    // Determine y positions of buttons
    float StartButtonY = (height/2) - 40;
    float ExitButtonY = (height/2) + 40;
    
    // Create buttons
    Start = new Button(width/2, StartButtonY, 2,37.5, "Start"); 
    Exit = new Button(width/2, ExitButtonY, 2,37.5, "Exit"); 
  }
  
  // Display screen
  void Display()
  {
    // Display high score
    String highscoretxt =  highscore.scoreDisClock.minutes + ":" + highscore.scoreDisClock.seconds; // Format the time as minutes:seconds
    
    // If hours are greater than 1, include the hour in the format
    if (Float.valueOf(highscore.scoreDisClock.hours) > 1)
    {
      highscoretxt = highscore.scoreDisClock.hours + ":" + highscoretxt; // Include hours in the time string
    }
    
    // Create a Text object to display the formatted time at the centre of the screen
    highscore.Load();
    highscore_Txt = new Text("Highest Score: " + highscoretxt, width/2, height/2, "Montserrat-Regular.ttf", 12.3, CENTER, textcol);
    
    Background();
    title.display();
    highscore_Txt.display();
    Start.display();
    Exit.display();
  }
  
  // Display background
  void Background()
  {
    road2.display();
  }
  
  void ButtonCheck() // To Be called on Mouse Press
  {
    if (Start.IfOver(mouseX,mouseY))
    {
      // Reset game managers
      PlayLoad();
      
      // Set state playing
      gamemode = gameMode.PLAYING;
    }
    else if (Exit.IfOver(mouseX,mouseY))
    {
      exit(); // exit program
    }
  }
  
  void Input() // To be called on key press
  {
    
  }
}
