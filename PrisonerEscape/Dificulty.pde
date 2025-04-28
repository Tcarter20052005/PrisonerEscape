final float base_multiplier = 1; // Base multiplier for difficulty adjustment
double difficulty_multiplier, diff_IncreaseRate, increaseInterval, elapsedTime;

class Difficulty
{
  final float base_multiplier = 1; // Base multiplier for difficulty
  final float max_mult = 1.9; // Maximum difficulty multiplier
  double dif_multiplier = base_multiplier; // Current difficulty multiplier
  float diff_IncreaseRate = 0.05; // Rate at which difficulty increases
  float increaseInterval = 5 * 1000; // Interval for increasing difficulty in milliseconds (5 seconds)
  float last_time = 0; // Last time when difficulty was increased
  
  // Function to play and update difficulty based on elapsed time
  void Play()
  {
    float ellapsed = clock.get_Time() - last_time; // Calculate the elapsed time since last difficulty increase
    
    // Check if the elapsed time has reached the interval for increasing difficulty
    if (ellapsed >= increaseInterval)
    {
      increase(); // Increase the difficulty multiplier
      last_time = clock.get_Time(); // Update the last time when difficulty was increased
    }
  }
  
  // Function to get the current difficulty multiplier factor
  float getFactor()
  {
    return (float)dif_multiplier; // Return the current difficulty multiplier as a float
  }
  
  // Function to increase the difficulty multiplier
  void increase()
  {
    dif_multiplier += diff_IncreaseRate; // Increase the difficulty by the specified rate
    if (dif_multiplier >= max_mult) // Cap the difficulty to the maximum multiplier
    {
      dif_multiplier = max_mult;
    }
  }
  
  // Function to reset the difficulty multiplier to the base value
  void reset()
  {
    dif_multiplier = base_multiplier; // Reset difficulty multiplier to the base value
  }
}
