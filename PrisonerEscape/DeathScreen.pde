// Death screen class
// Extends screen class as is ui
class DeathScreen extends Screen
{
  
  // Screen elements
  Text title, Time;
  Button Menu;
  
  
  color textcol = color(0, 0, 0);

  DeathScreen()
  {
    // Intilise required text
    float halfScreen = height/2;
    title = new Text("Death", width/2, 45, "Montserrat-ExtraBold.ttf", 18, CENTER, textcol);
    Time = new Text("", width/2, halfScreen-40, "Montserrat-Regular.ttf", 12.3, CENTER, textcol );
    
    // Intilise required buttons
    Menu = new Button(width/2, halfScreen+40, 2,37.5, "Menu"); 
  }
  
  // Display Screen
  void Display()
  {
    // Display current timein format
    String Timetxt = clock.minutes + ":" + clock.seconds;
    if(Float.valueOf(clock.hours) > 1)
    {
      Timetxt = clock.hours + ":" + Timetxt;
    }
    
    
    Time.value = Timetxt;
    
    title.display();
    Time.display();
    Menu.display();
  }
  
  void ButtonCheck()
  {
    if (Menu.IfOver(mouseX,mouseY))
    {
      highscore.Save(clock.get_Time()); // Save score
      // set state start
      gamemode = gameMode.START;
    }
  }
  
  void Background()
  {}
  
  void Input()
  {}
}
