// Obstacle Super Class
// Extending screenObject as they are objects to be displayed on screen
// Implementing Collidable to make all obstacle collidable

class Obstacle extends screenObject implements Collidable
{
  Sprite thisSprite; // Obstacle sprite object for management of animations
  Tracker tracker; // Tracker object for object tracking abilities and management
  
  // Default Obstacle type and tag
  String tag = "Obstacle";
  String type = "";
  
  // Dimension variables
  float Height,Width;
  
  // Position and X,Y speed variables
  float x,y,obx_speed,oby_speed;
  
  // Triggers whether Move() is applied to object
  boolean nostandardMove = false;
  
  // If move to position reaches position set
  boolean atPos = false ;
  
  // Nearest curb to object data
  String nearest_Curb;
  float nearest_CurbX;
  
  Obstacle()
  {  
    
    obstacle_Man.AddObstacle(this); // Queue Obstacle to be added to obstacle_OnScreen
    collide.Add_Collidable(this); // Make Obstacle collidable
    
    thisSprite = new Sprite(); // Initialise obstacle sprite
  }
  
  // Display Obstacle
  void display()
  {
    // Update sprite animations and display. Gather current position into a vector
    thisSprite.Update(clock.get_Time());
    PVector currentPos = new PVector(x,y);
    thisSprite.Display(currentPos,Width,Height);
    
    // If obstacle off screen then call death
    if (IsOffScreen())
    {
      Death();
    }
    
    ScreenMove(); // Apply standard screen movement
    
    if (!nostandardMove) // If standard movement allowed
    {
      XMove(); // Apply standard x movement
    }
    
  }
  
  // called once per frame to hold optional actions
  void LoopRun()
  {
    
  }
  
  // Standard screen movement on y axis
  void ScreenMove()
  {
    y += speedY;
  }
  
  // Standard x offset movement
  void Move()
  {
    x += x_Movement;
  }
  
  // Apply X movement manipulation
  void XMove()
  {
    if (playfield_Man.ob_IsOnScreen(this)) // If obstacle on screen
    {
      x += obx_speed; // Apply obstacle x movement speed
      
      if (this instanceof Police_Car) // if vertically movement Obstacle
      {
        y += -oby_speed; // Apply obstacle Y movement
      }
      else if (this instanceof K9) // if vertically movement Obstacle
      {
        y += oby_speed; // Apply obstacle Y movement
      }
      
    }
  }

  // Moves obstacle to position specified
  void MoveToPosition(float targetX)
  {
    nostandardMove = false; // Apply standard movement 

    
    // Adjust the speed based on movement along the x or y axis
    oby_speed = obx_speed;
    
    // Distance to target point is greater than obstacle x speed set position to target
    if ((Math.abs(this.x - targetX) <= Math.abs(obx_speed)) || (Math.abs(this.x + targetX) >= Math.abs(obx_speed)) ) 
    {
      this.x = targetX; 
      atPos = true;
      return;
    }
    
    // Move along the X-axis to target
    if (this.x != targetX && !nostandardMove)
    {
        if (this.x < targetX) 
        {
          this.x += Math.abs(obx_speed);  // Move right
        }
        else if (this.x > targetX) 
        {
          this.x -= Math.abs(obx_speed);  // Move left
        }    
    }  
  } 
  
  // Determines position and movement parameters based on type of obstacle
  void Determine_Pos(String type, float y, float minspeed, float maxspeed, boolean verticalMovement, float verticalBound)
  {
      // Randomly decides whether the object starts on the left or right of road
      float leftorRight = random(0, 2);
      //println(leftorRight);
  
      float ranPos; // Holds the random x-coordinate within range.
      PVector pos;
      
      // Determine position and movement based on which side the obstacle is on
      if (leftorRight > 1) // Right side
      {
        if (type.equals("Police Car"))
        {
          // For cars, use a random position within the right-side range (4.1 to 6.9).
          ranPos = random(4.1, 6.9);
          pos = playfield_Man.GridPos(ranPos, verticalBound); // Gather grid position coordinates based on ranpos value
        } 
        else
        {
          // Set random position based on whether obstacle is K9 or not
          // - K9: Random value within the range (4.1 to 6.9).
          // - Officer: Fixed x-coordinate at 9.
          ranPos = (type.equals("K9")) ? random(4.1, 6.9) : 9; 
          pos = playfield_Man.GridPos(ranPos, y); // Gather grid position coordinates based on ranpos value
        }
        
        // Set the obstacle's position and movement parameters for the right side.
        this.x = (int) pos.x;
        this.y = (int) pos.y;
        
        // Set speed random between range of minspeed and maxspeed
        this.obx_speed = verticalMovement ? 0 : random(-minspeed, -maxspeed); // 0 if vertical movement is true
        this.oby_speed = verticalMovement ? random(minspeed, maxspeed) : 0; // 0 if vertical movement is false
        
        this.nearest_Curb = "R"; // Right Curb
      } 
      else 
      {
        // Left side
        if (type.equals("Car")) 
        {
          // For cars, use a random position within the left-side range (1.1 to 3.9).
          ranPos = random(1.1, 3.9);
          pos = playfield_Man.GridPos(ranPos, verticalBound);
        } 
        else 
        {
          // Set random position based on whether obstacle is K9 or not
            // - K9: Random value within the range (1.1 to 3.9).
            // - Officer: Fixed x-coordinate at -1.
          ranPos = (type.equals("K9")) ? random(1.1, 3.9) : -1;
          pos = playfield_Man.GridPos(ranPos, y); // Gather grid position coordinates based on ranpos value
        }
        
        // Set the obstacle's position and movement parameters for the left side.
        this.x = (int) pos.x;
        this.y = (int) pos.y;
        
        // Set speed random between range of minspeed and maxspeed
        this.obx_speed = verticalMovement ? 0 : random(minspeed, maxspeed); // 0 if vertical movement is true
        this.oby_speed = verticalMovement ? random(minspeed, maxspeed) : 0; // 0 if vertical movement is false
        this.nearest_Curb = "L"; // Left Curb
      }
  }
  
  void collisionExit(Collidable other)
  {
    
  }
  
  void collidesWith(Collidable other) 
  {
  }
  
  // Collidable Required Methods and returns of relevant info
  String getTag()
  {
    return this.tag;
  }
  
  String getType()
  {
    return this.type;
  }
  
  PVector getPos()
  {
    return new PVector(x, y);
  }
  
  float getWidth()
  {
    return Width;
  }
  
  float getHeight()
  {
    return Height;
  }
  
  // Returns whether obstacle is classed off screen
  Boolean IsOffScreen()
  {
    if (this.y > height+1000 || this.x > 1000 || this.x < -1000)
    {
      return true;
    }
    return false;
  }
  
  // Kills obstacle by removing it from movement and display lists
  void Death()
  {
    obstacle_Man.RemoveObstacle(this);
    collide.Remove_Collidable(this);
  }
  
} //<>//
