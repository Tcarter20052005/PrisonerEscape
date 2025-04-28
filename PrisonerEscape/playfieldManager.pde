// Playfield Manager
// Manages the playfield during gameplay. Including:
// -- Display of road
// -- Movement of Obstacles on screen
// -- Grid base system for object placement

// Grid Setup for Game
final int cellWidth = screenWidth/8;
final int cellHeight = screenHeight/8;

ArrayList<screenObject> on_screen; // Array list to hold all objects on screen or yet to be on screen
ArrayList<Collidable> collidables; // Array list of all collidable objects in the game


class playfieldManager
{
  static final int POLICE_CAR_SCREEN_THRESHOLD = -50; // Offset threshold for police car visibility
static final int GENERIC_OBJECT_SCREEN_THRESHOLD = 0; // Threshold for generic objects

  Road road; // Road Object

  playfieldManager()
  { 
    on_screen = new ArrayList<screenObject>(); // Initialise on-screen objects list
    collidables = new ArrayList<Collidable>(); // Initialise collidables list
    road = new Road(); // Create road for play surface
  }
  
  
  void display()
  {
    road.display(); // Display road surface
  }
  
  // Grid Pos a function that will return a vector that will contain coordinates for grid position requested
  PVector GridPos(float x, float y)
  {
    float grid_x = (cellWidth*x)+screen_offset; // Calculate x-coord of grid position
    float grid_y = cellHeight*y; // Calculate y-coord of grid position
    PVector coords = new PVector(grid_x, grid_y); // Return the position as a vector
    return coords;
  }
  
  // Move all objects on screen
  void Move()
  {
    for (screenObject object : on_screen)
    {
      object.Move();
     
    }
  }
  
  // Returns true if object within a specified bound of the screen
  boolean ob_IsOnScreen(Obstacle ob)
  {
    if (ob instanceof Police_Car)
    {
      if (ob.y >= POLICE_CAR_SCREEN_THRESHOLD)
      {
        return true;
      }
    }
    else if (ob.y >= GENERIC_OBJECT_SCREEN_THRESHOLD)
    {
      return true;
    }
    return false;
  }
  
}
