// Clock Class: Object to handle game time

class Clock
{
  // Time Holders
  private float program_Time; // Time the Sketch has been running for
  private float currentTime = 0; // Current game time
  private float time_Dif = 0; // Difference between current game time and program time
  
  // Time recorded when game paused
  private float pausedTime;
  
  // Tracks whether game is paused
  private boolean Pause = false; 
  
  // Holds display values of clock
  String hours;
  String minutes;
  String seconds;
  
  Clock()
  {
    program_Time = millis(); // sets program time 
    
    Reset(); // Ensures game time is 0
  }
  
  // Runs every frame to update the clock time unless paused
  void Run() 
  {
    if (!Pause)
    {
      currentTime = millis() - time_Dif; // Updates game time adjusted for program run time
      pausedTime = currentTime; // Store the current time as a refernce for pause
      UpdateDisplayVals(); // Keep display values current
    }
    else
    {
      currentTime = pausedTime; // Keep current time constant during pause
    }
    
    
  }
  
  // Return current game time
  float get_Time()
  {
    return currentTime;
  }
  
  // Update display values of clock
  void UpdateDisplayVals()
  {
    float remainingMillis = currentTime;
    
    // Calculate hours
    float hourscal = currentTime / (1000 * 60 * 60);
    hours = String.format("%02d", (int) hourscal); // Format for clean display
    remainingMillis = currentTime % (1000 * 60 * 60);
    
    // Calculate minutes
    float mincal = remainingMillis / (1000 * 60);
    minutes = String.format("%02d", (int) mincal);
    remainingMillis = remainingMillis % (1000 * 60);
    
    // Calculate seconds
    float seccal = remainingMillis / 1000;
    seconds = String.format("%02d", (int) seccal);
  }
  
  // Update display values of clock used for score load and display
  void UpdateDisplayVals(float NewTime)
  {
    float remainingMillis = NewTime;
    
    // Calculate hours
    float hourscal = NewTime / (1000 * 60 * 60);
    hours = String.format("%02d", (int) hourscal); // Format for clean display
    remainingMillis = NewTime % (1000 * 60 * 60);
    
    // Calculate minutes
    float mincal = remainingMillis / (1000 * 60);
    minutes = String.format("%02d", (int) mincal);
    remainingMillis = remainingMillis % (1000 * 60);
    
    // Calculate seconds
    float seccal = remainingMillis / 1000;
    seconds = String.format("%02d", (int) seccal);
  }
  
  // Pauses clock
  void Pause()
  {
    Pause = !Pause;
    
    // Debug message to tell when clock is paused
    //if (Pause)
    //{
    //  println("Paused at " + get_Time());
      
    //}
    //else
    //{
    //  println("UnPaused at " + get_Time());
    //}
    
  }
  
  // Returns current pause state
  boolean isPause()
  {
    return Pause;
  }
  
  // Sets time difference hence reseting game time
  void Reset()
  {
    if (program_Time != 0)
    {
      time_Dif = millis();
    }
  }
}
