
int x_Movement = 0; // current movement of the x axis compared to normal
int screen_offset = 0; // Offset of screen on the x axis compared to origin

// Each Key State
boolean leftPressed = false;
boolean rightPressed = false;
boolean upPressed = false;
boolean downPressed = false;

float speedY = 1.5; // Movement speed of background and objects

// Player class
// Represents player controlled character "Prisoner" in the game

// Extends screenObject as it is to be displayed and reachable on screen
// Implements Collidable interface so collision can happen with it.

class Player extends screenObject implements Collidable{
  String tag  = "Player"; // Tag player object
  
  float Width = 30; // Width of Player
  float Height = 30; // Height of Player
  
  int playerx = 0; // Current x coordinate of Player
  int playery = 0; // Current y coordinate of Player
    
  int speedX = 6; // Speed of player on x axis
  
  // Directional info
  int x_Direction = 0; // -1 = looking left. 1 = looking right
  int y_Direction = 0; // -1 = looking down. 1 = looking up
  
  // Player speed values
  float walkSpeed = 1.5;
  float sprintSpeed = 3;
  
  // Restrictions on what direction player can move
  boolean canMoveLeft = true;
  boolean canMoveRight = true;
  
  Sprite thisSprite; // Sprite object for management of player animation processes
  
  
  
  // Declare Animation Objects for the various animations
  Animation Up,Left,Right;
  
  Player()
  {
     x_Movement = 0; // current movement of the x axis compared to normal
     screen_offset = 0; // Offset of screen on the x axis compared to origin
    collide.Add_Collidable(this); // Make object collidable
    
    // Set the player to grid centre and store coordinates
    PVector pos = playfield_Man.GridPos(4,4);
    playerx = (int)pos.x;
    playery = (int)pos.y;
    
    thisSprite = new Sprite(); // Intialise player sprite
    thisSprite.setPos(new PVector(playerx,playery)); // set position of sprite transfrom to player position
    
    // Animations
    Up = new Animation(3,Prisoner_IMG,200,0,true,true);
    Left = new Animation(3,Prisoner_IMG,200,315,true,true); // Look left rotated 45 left
    Right = new Animation(3,Prisoner_IMG,200,45,true,true); // Look right rotated 45 left
    
    // Add animation to player sprite
    thisSprite.addAnimation("Up", Up);
    thisSprite.addAnimation("Left", Left);
    thisSprite.addAnimation("Right", Right);
  }
  
  // Required by screen object
  void Move()
  {
  }
  
  // Handles Player input logic
  void OnKeyPressed()
  {
    // Dependent on key pressed and whether action is allowed set pressed vale to true and play relevant animation
    if (keyCode == LEFT && canMoveLeft)
    {
      leftPressed = true;
      thisSprite.PlayAnimation("Left");
    }
    else if (keyCode == RIGHT && canMoveRight)
    {
      rightPressed = true;
      thisSprite.PlayAnimation("Right");
    }
    else if (keyCode == UP)
    {
      upPressed = true;
      thisSprite.PlayAnimation("Up");
    }
    else if (keyCode == DOWN)
    {
      downPressed = true;
    }
    else if (key == 'p' || key == 'P') // Pause game
    {
      clock.Pause(); // Pauses game clock
      gamemode = gameMode.PAUSE; // set game state to pause
    }
    
    UpdateMovement(); // Update directional info stored based on most recent key press
  }
  
  // Handles player input key release logic
  void onKeyReleased()
  {
    // Dependent on key released set state to false. and directional info relevant to action
    if (keyCode == LEFT)
    {
      leftPressed = false;
    }
    else if (keyCode == RIGHT)
    {
      rightPressed = false;
    }
    else if (keyCode == UP)
    {
      upPressed = false;
      y_Direction = 0;
    }
    else if (keyCode == DOWN)
    {
      downPressed = false;
    }
    thisSprite.PlayAnimation("Up"); // Default animation to looking up
    UpdateMovement(); // Update directional info stored based on most recent key press
    x_Direction = 0; // Stop sprint
  }
  
  // Updates directional info based on keystate
  void UpdateMovement()
  {
    if (leftPressed && rightPressed)
    {
      x_Direction = 0; // No x direction
    } 
    else if (leftPressed)
    {
      x_Direction = 1; // Moving left
    }
    else if (rightPressed)
    {
      x_Direction = -1; // Moving right
    }
    
    if (upPressed && downPressed)
    {
      y_Direction = 0; // No y direction
    }
    else if (upPressed)
    {
      y_Direction = 1; // Sprinting
    }
    else if (downPressed)
    {
      y_Direction = -1; // Slow down
    }
    
    // If x direction is not 0 apply movement else reset to no movement on x axis
    if (x_Direction == 1) {
      if (canMoveLeft) // able to move left
      {
        x_Movement = speedX; // set movement on x axis to player x speed
        screen_offset += speedX; // off set screen relevant to speedx
        playfield_Man.Move(); // Update loction of all objects on screen
      }
      // Reset move restrictions
      canMoveLeft = true;
      canMoveRight = true;    
    }
    else if (x_Direction == -1) {
      if (canMoveRight) // able to move right
      {
        x_Movement = -speedX; // set movement on x axis to player x speed
        screen_offset -= speedX; // off set screen relevant to speedx
        playfield_Man.Move(); // Update loction of all objects on screen
      }
      // Reset move restrictions
      canMoveLeft = true;
      canMoveRight = true;
    }
    else {
      x_Movement = 0; // Reset x movement to none
    }
    
    // If x direction is not 0 apply movement else reset to walk speed
    if (y_Direction == 1)
    {
      speedY = sprintSpeed; // set screen speed to sprint value thus player sprint
    }
    else if (y_Direction == -1) {
      speedY = 0.5; // slow down screen thus player
    }
    else {
      speedY = walkSpeed; // Reset to walk speed
    }
  }
  
  // Display Player
  void display()
  {
    // First player appearance
    //fill(243,125,61);
    //rect(playerx, playery, playersize,playersize);
    
    // Update sprite animations and display. Gather current position into a vector
    thisSprite.Update(clock.get_Time());
    PVector currentPos = new PVector(playerx,playery);
    thisSprite.Display(currentPos,Width,Height);
    
  }
  
  // When player collides with object
  void collidesWith(Collidable other) 
  {
     
     
     // Deal damage to player if Obstacle
     if (other.getTag() == "Obstacle")
     {
       
       gamemode = gameMode.DEATH;
       
     }
    
    // If object is curbs set movement restrictions
    if (other.getTag() == "L_Curb")
    {
      canMoveLeft = false;
    }
    else if (other.getTag() == "R_Curb")
    {
      canMoveRight = false;
    }
  }
  
  // On collision exit
  void collisionExit(Collidable other)
  {
    // If object collided is either curb the reset move restrictions
    if (other.getTag() == "L_Curb")
    {
      canMoveLeft = true;
    }
    else if (other.getTag() == "R_Curb")
    {
      canMoveRight = true;
    }
  }
  
  // Collidable required methods returning corresponding values
  String getTag()
  {
    return this.tag;
  }
  
  String getType()
  {
    return null;
  }
  
  PVector getPos()
  {
    return new PVector(playerx, playery);
  }
  
  float getWidth()
  {
    return Width;
  }
  
  float getHeight()
  {
    return Height;
  }
  
}
