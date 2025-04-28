// Armed Officer class
// Extends obstacle as its an obstacle Type
// Behaviour: Moves to side of road and fires projectiles/bullets

class Armed_Police extends Obstacle
{ 
  // Movement speed range
  float minSpeed = 1;
  float maxSpeed = 2;
  
  // Shooting mechanics
  float shotInterval = 2000;
  float lastShotTime = 0;
  float currentTime = 0; // current game time
  float minShotInterval = 1500; // Minimum time in milliseconds
  float maxShotInterval = 3000; // Maximum time in milliseconds
  
  // Animation states for the officer
  Animation Idle,Run,Shooting;
  
  Armed_Police(float y)
  {
    Determine_Pos("Officer", y, minSpeed, maxSpeed, false, 0);
    //Officer_Determine_Pos(y, 1,2);
    thisSprite.setPos(new PVector(x,y));  // Set position of sprite transfrom to Armed Officer position
    this.type = "Armed Police"; // Set obstacle type
    
    // Dimensions
    Width = 30;
    Height = 30;
    
    // Intialise animations
    Idle = new Animation(2,Armed_Idle,200,0,true,true);
    Run = new Animation(2,Armed_Run,200,0,true, true);
    Shooting = new Animation(1,Armed_Shooting,200,0,true, false);
    
    // Add animations to sprite
    thisSprite.addAnimation("Idle", Idle);
    thisSprite.addAnimation("Run", Run);
    thisSprite.addAnimation("Shooting", Shooting);
    
    // Update sprite state using current game time
    thisSprite.Update(clock.get_Time());
  }
  
  // Display armed officer
  void display()
  { 
    // Check if on screen
    if (playfield_Man.ob_IsOnScreen(this))
    {
    if (nearest_Curb == "L")
    {
      nearest_CurbX = playfield_Man.road.curbL.x-Width; // Offset by officer width
    } else
    {
      nearest_CurbX = playfield_Man.road.curbR.x+Width; // Offset by officer width
    }
    
    // Play running animation and move officer to the nearest curb
    thisSprite.PlayAnimation("Run");
    MoveToPosition(nearest_CurbX);
    } else
    {
      // If off screen set the animation to idle
      thisSprite.PlayAnimation("Idle");
    }
    
    // call parent class's display method
    super.display();
  }
  
  // Ensure to override parent Move()
  void Move()
  {
    
  }
  
  // Every frame checks and executes shooting behavior
  void LoopRun()
  {
    Shoot();
  }
  
  // Handles shooting behaviour
  void Shoot()
  {
    if (atPos) // check if officer is in position to shoot
    {
      float currentTime = clock.get_Time(); // Get current game time
      
      // Check if enough time has passed since the last shot
      if (currentTime >= lastShotTime+shotInterval)
      {
        thisSprite.PlayAnimation("Shooting"); // Trigger shooting animation
        SpawnBullet(); // Spwan new bullet
        lastShotTime = currentTime; // update the last shot time
        
        // Randomise next shot interval
        shotInterval = random(minShotInterval, maxShotInterval);
        
        // Adjust firing rate based on game difficulty
        adjustFiringRate();
      }
    }
    else
    {
      // If not in position continue running animation
      thisSprite.PlayAnimation("Run");
    }
  }
  
  // Creates a new Bullet/Projectile
  Projectile SpawnBullet()
  {
    PVector cur_pos = new PVector(x,y); // Current position of the officer
    return new Projectile(cur_pos, obx_speed); // Return a projectile object with current speed
  }
  
  // Adjust firing rate based on game difficulty
  // Updates the minimum and maximum shot intervals proportionally to the difficulty factor.
  void adjustFiringRate() 
  {
    float difficultyFactor = difficulty.getFactor(); // Retrieve the difficulty factor
    minShotInterval = 1500 / difficultyFactor; // Scale minimum interval
    maxShotInterval = 3000 / difficultyFactor; // Scale maximum interval
  }
  
}
