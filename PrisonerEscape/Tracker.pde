// Tracker class
// Tracks object to trackto object with time that can be inflenced by game difficulty
class Tracker
{
  Obstacle Tracker; // The obstacle being tracked
  Collidable trackTo; // The object that is being tracked
  
  float track_Time = 0; // Timer in milliseconds
  boolean Influenced_Timer; // Determines whether the timer is influenced by factors
  
  boolean tracking = false; // Boolean to track if the object is being tracked
  float time_Start = 0; // Start time for tracking
  float time_End = 0; // End time for tracking
  
  float radius = 50; // Default radius for sensing
  
  boolean running = false; // Boolean to check if the tracker is running
  boolean attacking = false; // Boolean to check if the tracker is attacking
  
  boolean lookUp = false; // Boolean for looking up
  boolean lookDown = false; // Boolean for looking down
  boolean lookLeft = false; // Boolean for looking left
  boolean lookRight = false; // Boolean for looking right

  
  // Constructor for the tracker with default radius
  Tracker(Obstacle Tracker, Collidable trackTo) 
  {
    this.Tracker = Tracker;
    this.trackTo = trackTo; 
    // Uses default radius
  }
  
  // Constructor for the tracker with an optional timer
  Tracker(Obstacle Tracker, Collidable trackTo, float track_Time) 
  {
    this(Tracker, trackTo);
    this.track_Time = track_Time; 
    // Uses default radius
  }
  
  // Constructor with timer and a specified radius
  Tracker(Obstacle Tracker, Collidable trackTo, float track_Time , int radius) 
  {
    this(Tracker, trackTo, track_Time);
    this.radius = radius;
  }
  
  // Constructor without a timer but with a specified radius
  Tracker(Obstacle Tracker, Collidable trackTo, int radius) 
  {
    this(Tracker, trackTo);
    this.radius = radius;
  }
  
  // Constructor with an influenced timer and a specified radius
  Tracker(Obstacle Tracker, Collidable trackTo, float track_Time, int radius, boolean Influenced_Timer) 
  {
    this(Tracker, trackTo, radius);
    if (Influenced_Timer == false) {
        throw new IllegalArgumentException("Incorrect constructor used.");
    }
    this.track_Time = InfluenceTimer(track_Time);;
  }
  
  // Constructor with timer and possible influenced timer, with a default radius
  Tracker(Obstacle Tracker, Collidable trackTo, int track_Time, boolean Influenced_Timer) 
  {
    this(Tracker, trackTo);
    if (Influenced_Timer == false) {
        throw new IllegalArgumentException("Incorrect constructor used.");
    }
    this.track_Time = InfluenceTimer(track_Time);
  }
  
  // Display function for tracking logic, to be called in the display function of the tracker obstacle
  void Track_Display() 
  {
    if (SenseObject()) // Check if the object to track is sensed
    {
      FollowTracked(); // Follow the tracked object if it's sensed
    } else 
    {
      boolean k9Check = Tracker instanceof K9; // Check if the tracker is a K9 unit
      boolean carCheck = Tracker instanceof Police_Car; // Check if the tracker is a police car
      if (k9Check || carCheck)
      {
        Tracker.obx_speed = 0; // Stop movement if it's a K9 or police car
      }
      else
      {
        Tracker.oby_speed = 0; // Stop movement for other types of tracker
      }
      
      Tracker.nostandardMove = false; // Allow standard movement again
    }
  }
  
  // Function to sense the tracked object within the tracking radius
  Boolean SenseObject()
  {
    PVector tracked_pos = trackTo.getPos(); // Get the position of the object to track
    PVector tracker_pos = Tracker.getPos(); // Get the position of the tracker
    
    // Define sensor boundaries using the radius
    float sensor_Top = tracker_pos.y - radius;
    float sensor_Bottom = tracker_pos.y + radius;
    float sensor_Left = tracker_pos.x - radius;
    float sensor_Right = tracker_pos.x + radius;
    
    // Draw sensor bounds for debugging/visualisation
    line(sensor_Left, sensor_Top, sensor_Right, sensor_Top);
    line(sensor_Right, sensor_Top, sensor_Right, sensor_Bottom);
    line(sensor_Right, sensor_Bottom, sensor_Left, sensor_Bottom);
    line(sensor_Left, sensor_Top, sensor_Left, sensor_Bottom);
    
    // Check if the object being tracked is within the sensor bounds
    if (tracked_pos.y >= sensor_Top && tracked_pos.y <= sensor_Bottom)
    {
      if (tracked_pos.x >= sensor_Left && tracked_pos.x <= sensor_Right)
      {
        return true; // Object is sensed within the radius
      }
    }
    
    return false; // Object is not sensed within the radius
  }
  
  // Function to follow the tracked object based on the movement logic
  void FollowTracked()
  {
    if (!tracking) // Start tracking if it's not already tracking
    {
      if (track_Time != 0 && time_Start == 0) 
      {
        time_Start = clock.get_Time(); // Start the timer
        time_End = time_Start + track_Time; // Set the end time based on the timer
      }
      tracking = true;
    }
    
    // Stop tracking if the time has elapsed
    if (track_Time > 0 && clock.get_Time() >= time_End)
    {
      attacking = false;
      running = false;
      tracking = false; 
      return;
    }
    
    Tracker.nostandardMove = true; // Disable standard movement
    
    // Following logic based on the tracked object's position
    PVector trackto_pos = trackTo.getPos(); // Get the position of the object to track
    
    // Ensure the tracker moves according to its speed
    if (Tracker.obx_speed == 0)
    {
      Tracker.obx_speed = Tracker.oby_speed;
    }
    else
    {
      Tracker.oby_speed = Tracker.obx_speed;
    }
    
    float distance = dist(trackto_pos.x, trackto_pos.y, Tracker.x, Tracker.y); // Calculate the distance to the tracked object
    
    if (distance <= radius)
    {
      attacking = true; // Start attacking when within radius
      running = false; // Stop running
    }
    else
    {
      attacking = false; // Stop attacking if outside the radius
      running = true; // Continue running
    }
    
    // Movement logic: adjust position based on the tracked object's position
    float player_x = trackto_pos.x;
    float player_y = trackto_pos.y;
    
    float abs_speed_x = Math.abs(Tracker.obx_speed);
    float abs_speed_y = Math.abs(Tracker.oby_speed);

    // Determine direction and adjust position accordingly
    if (Tracker.x > player_x + 20) {
        Tracker.x -= abs_speed_x / difficulty.getFactor(); // Move left
        lookLeft = true;
        lookRight = false;
    } else if (Tracker.x < player_x - 20) {
        Tracker.x += abs_speed_x / difficulty.getFactor(); // Move right
        lookLeft = false;
        lookRight = true;
    }

    if (Tracker.y > player_y + 20) {
        Tracker.y -= abs_speed_y / difficulty.getFactor(); // Move up  
        lookUp = true;
        lookDown = false;
    } else if (Tracker.y < player_y - 20) {
        Tracker.y += abs_speed_y / difficulty.getFactor(); // Move down
        lookUp = false;
        lookDown = true;
    }
  }
  
  // Function to influence the timer based on external factors like difficulty
  float InfluenceTimer(float BaseTimer)
  {
    float influenced = BaseTimer * difficulty.getFactor(); // Adjust timer based on difficulty
    return influenced;
  }
}
