// PlayDisplay screen class
// Extends the Screen class as it represents the user interface (UI) for the play screen
class PlayDisplay extends Screen
{
  Text Time, Dif; // Text objects for displaying the time and difficulty
  
  color textcol = color(0, 0, 0); // Text colour set to black
  color displayBox = color(210, 180, 140); // Colour for the display box

  // Constructor for PlayDisplay class
  PlayDisplay()
  {
    // Empty constructor, can be used for initialisation if needed in the future
  }
  
  // Display method to show the UI elements on the screen
  void Display()
  {
    String Timetxt = clock.minutes + ":" + clock.seconds; // Format the time as minutes:seconds
    
    // If hours are greater than 1, include the hour in the format
    if (Float.valueOf(clock.hours) > 1)
    {
      Timetxt = clock.hours + ":" + Timetxt; // Include hours in the time string
    }
    
    // Create a Text object to display the formatted time at the centre of the screen
    Time = new Text(Timetxt, width/2, height-15, "Montserrat-Regular.ttf", 12.3, CENTER, textcol);
    
    Background(); // Draw the background (display box)
    Time.display(); // Display the formatted time on the screen
  }
  
  // Background method to draw a display box for the time
  void Background()
  {
    rectMode(CENTER); // Set the rectangle mode to centre
    fill(displayBox); // Set the fill colour to the display box colour
    rect(width/2, height-15, width-2, 30); // Draw the rectangle with specified dimensions
  }
  
  // ButtonCheck method to be called on mouse press
  void ButtonCheck() 
  {
    // To be implemented: This function will handle mouse press events
  }
  
  // Input method to be called on key press
  void Input() 
  {
    // To be implemented: This function will handle key press events
  }
}
