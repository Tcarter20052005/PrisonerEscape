// K9 class
// Extends Obstacle and represents a K9 character (guard dog) with animations for idle, walking, and attacking.
// Behaviors: The K9 can walk in different directions, idle in place, or attack based on its tracking behavior.

class K9 extends Obstacle
{
  // Speed variables
  float minspeed = 2; // Minimum speed for K9
  float maxspeed = 2.2; // Maximum speed for K9
  
  // Animation for K9 in different states and directions
  Animation Idle_Up, Idle_Down, Idle_Left, Idle_Right;
  Animation Walk_Up, Walk_Down, Walk_Left, Walk_Right;
  Animation Attack_Up, Attack_Down, Attack_Left, Attack_Right;
  
  
  
  // Constructor to initialize the K9's position, animations, and behavior
  K9(float y)
  {
    // Set initial position using the Determine_Pos method (this might relate to the playfield grid)
    Determine_Pos("K9", y, minspeed, maxspeed, true, 0);
    thisSprite.isDirectional = true; // Allow the sprite to be directional (facing different directions)
    
    // Set initial position of the sprite (coordinates: x, y)
    thisSprite.setPos(new PVector(x, y));
    this.type = "K9"; // Set the type to "K9"
    Width = 40; // Set width of the K9 sprite
    Height = 40; // Set height of the K9 sprite
    
    // Initialize animations for idle, walk, and attack states in each direction
    Idle_Up = new Animation(1, K9_Idle_Up, 300, 0, true, true, "Idle");
    Idle_Down = new Animation(1, K9_Idle_Down, 300, 0, true, true, "Idle");
    Idle_Left = new Animation(1, K9_Idle_Left, 300, 0, true, true, "Idle");
    Idle_Right = new Animation(1, K9_Idle_Right, 300, 0, true, true, "Idle");
    
    Walk_Up = new Animation(1, K9_Walk_Up, 250, 0, true, true, "Walk");
    Walk_Down = new Animation(1, K9_Walk_Down, 250, 0, true, true, "Walk");
    Walk_Left = new Animation(1, K9_Walk_Left, 250, 0, true, true, "Walk");
    Walk_Right = new Animation(1, K9_Walk_Right, 250, 0, true, true, "Walk");
    
    Attack_Up = new Animation(1, K9_Attack_Up, 150, 0, true, true, "Attack");
    Attack_Down = new Animation(1, K9_Attack_Down, 150, 0, true, true, "Attack");
    Attack_Left = new Animation(1, K9_Attack_Left, 150, 0, true, true, "Attack");
    Attack_Right = new Animation(1, K9_Attack_Right, 150, 0, true, true, "Attack");
    
    // Add animations to sprite for each possible state (Idle, Walk, Attack) in all directions
    thisSprite.addAnimation("Idle_Down", Idle_Down);
    thisSprite.addAnimation("Idle_Up", Idle_Up);
    thisSprite.addAnimation("Idle_Left", Idle_Left);
    thisSprite.addAnimation("Idle_Right", Idle_Right);
    
    thisSprite.addAnimation("Walk_Down", Walk_Down);
    thisSprite.addAnimation("Walk_Up", Walk_Up);
    thisSprite.addAnimation("Walk_Left", Walk_Left);
    thisSprite.addAnimation("Walk_Right", Walk_Right);
    
    thisSprite.addAnimation("Attack_Down", Attack_Down);
    thisSprite.addAnimation("Attack_Up", Attack_Up);
    thisSprite.addAnimation("Attack_Left", Attack_Left);
    thisSprite.addAnimation("Attack_Right", Attack_Right);
    
    // Initialize tracker for player tracking behavior (e.g., how K9 reacts to player movements)
    tracker = new Tracker(this, player, 3000, 75, true);
    
    // Update sprite state with the current game time
    thisSprite.Update(clock.get_Time());
  }
  
  // Display method handles the K9's animation based on tracking and actions
  void display()
  {
    // If the K9 is tracking or has a non-standard movement state
    if (tracker.tracking || tracker.Tracker.nostandardMove)
    {
      // If K9 is attacking, play corresponding attack animation based on direction
      if (tracker.attacking)
      {
        if (tracker.lookUp) thisSprite.PlayAnimation("Attack_Up");
        else if (tracker.lookDown) thisSprite.PlayAnimation("Attack_Down");
        if (tracker.lookLeft) thisSprite.PlayAnimation("Attack_Left");
        else if (tracker.lookRight) thisSprite.PlayAnimation("Attack_Right");
      }
      // If K9 is idle but in non-standard move state, play corresponding idle animation
      else if (tracker.Tracker.nostandardMove)
      {
        if (tracker.lookUp) thisSprite.PlayAnimation("Idle_Up");
        else if (tracker.lookDown) thisSprite.PlayAnimation("Idle_Down");
        if (tracker.lookLeft) thisSprite.PlayAnimation("Idle_Left");
        else if (tracker.lookRight) thisSprite.PlayAnimation("Idle_Right");
      }
      // If K9 is moving, play corresponding walk animation based on direction
      else
      {
        if (tracker.lookUp) thisSprite.PlayAnimation("Walk_Up");
        else if (tracker.lookDown) thisSprite.PlayAnimation("Walk_Down");
        if (tracker.lookLeft) thisSprite.PlayAnimation("Walk_Left");
        else if (tracker.lookRight) thisSprite.PlayAnimation("Walk_Right");
      }
    }
    // If K9 is not actively tracking, still play walk animation based on direction
    else
    {
      if (tracker.lookUp) thisSprite.PlayAnimation("Walk_Up");
      else if (tracker.lookDown) thisSprite.PlayAnimation("Walk_Down");
      if (tracker.lookLeft) thisSprite.PlayAnimation("Walk_Left");
      else if (tracker.lookRight) thisSprite.PlayAnimation("Walk_Right");
    }
    
    // Call the Track_Display method 
    tracker.Track_Display();
    
    // Call parent display method to ensure general display behavior
    super.display();
  }
  
  // Placeholder method for movement logic (can be implemented later)
  // void Move() {}
}
