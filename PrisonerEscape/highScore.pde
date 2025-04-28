// High score class

// Used to save and load high score for display on start screen
// Score is the highest time achoeved by player

class highScore
{
  
  String file_name = "highScore.txt"; // Name of file highscore is saved to
  
  float currentHighScore; // Current highscore
  
  Clock scoreDisClock; // Clock object that score can be loaded into to be displayed
  
  highScore()
  {
    // Instialise display clock
    scoreDisClock = new Clock();
    //scoreDisClock.UpdateDisplayVals(float NewTime)
    
    // Load in Hgh score 
    Load();
  }
  
  // Loads in highScore from file
  void Load()
  {
    String[] lines = null;
    
    lines = loadStrings(file_name);
    
    if (lines != null && lines.length > 0) // if info in file
    {
      currentHighScore = float(lines[0]);
    }
    else  
    {
      currentHighScore = 0;
    }
    
    DisplayVals(); // Update display
  }
  
  // Save highscore
  void Save(float score)
  {
    if (score > currentHighScore) // if new score better than current
    {
      String[] lines = { str(score) };
      currentHighScore = score;
      saveStrings("highScore.txt", lines); // Save to file
      println("OVERRIDE");
    }
    
    //Load(); // Load in new score
    
    DisplayVals(); // Update display
  }
  
  // update display vals
  void DisplayVals()
  {
    scoreDisClock.UpdateDisplayVals(currentHighScore);
  }
}
