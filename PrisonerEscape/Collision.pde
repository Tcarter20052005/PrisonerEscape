import java.util.HashSet;
// Collision Manager - Responsible for handling collision detection and responses between collidable objects.
class Collision_Man
{
  // A map to track previously colliding objects
  HashMap<Collidable, HashSet<Collidable>> previouslyColliding = new HashMap<>();
  
  // Adds a new collidable object to the system
  void Add_Collidable(Collidable col_ob)
  {
    collidables.add(col_ob); // Add the collidable object to the list of collidables
    previouslyColliding.put(col_ob, new HashSet<Collidable>()); // Initialise an empty set for tracking previously colliding objects
  }
  
  // Removes a collidable object from the system
  void Remove_Collidable(Collidable col_ob)
  {
    collidables.remove(col_ob); // Remove the collidable object from the list
    previouslyColliding.remove(col_ob); // Remove the associated entry from the collision map
  }
  
  // Checks for collisions between all collidable objects in the provided list
  void checkCollisions(ArrayList<Collidable> colls)
  {
    for (int i = 0; i < colls.size(); i++) // Loop through each collidable object
    {
      Collidable ob1 = colls.get(i); // Current collidable object
      PVector ob1_Pos = ob1.getPos(); // Get the position of the object
      float ob1_Width = ob1.getWidth(); // Get the width of the object
      float ob1_Height = ob1.getHeight(); // Get the height of the object
      
      // Check for collisions with all other collidables
      for (int j = 0; j<colls.size(); j++)
      {
        if (j != i) // Skip checking for collision with itself
        {
          Collidable ob2 = colls.get(j); // Another collidable object
          PVector ob2_Pos = ob2.getPos(); // Get the position of the second object
          float ob2_Width = ob2.getWidth(); // Get the width of the second object
          float ob2_Height = ob2.getHeight(); // Get the height of the second object
          
          
          // Check if the two objects are colliding
          if (CheckCollision(ob1_Pos, ob1_Width, ob1_Height, ob2_Pos, ob2_Width, ob2_Height))
          {
            ob1.collidesWith(ob2); // Call collidesWith on the first object
            ob2.collidesWith(ob1); // Call collidesWith on the second object
            
            // Add the objects to each other's previouslyColliding set
            previouslyColliding.get(ob1).add(ob2);
            previouslyColliding.get(ob2).add(ob1);
          }
          else
          {
            // If the objects were previously colliding but are no longer, call collisionExit
            if (previouslyColliding.get(ob1).contains(ob2))
            {
              ob1.collisionExit(ob2);
              ob2.collisionExit(ob1);
            }
            
            // Remove the objects from each other's previouslyColliding set
            previouslyColliding.get(ob1).remove(ob2);
            previouslyColliding.get(ob2).remove(ob1);
          }
        }
      }
    }
  }
  
  // Checks if two objects are colliding based on their positions and dimensions
  boolean CheckCollision(PVector ob1_pos, float ob1_Width, float ob1_Height, PVector ob2_pos, float ob2_Width, float ob2_Height)
  {
    // Get half-width and half-height values for both objects as we are using rectMode(CENTER)
    float ob1_halfWidth = ob1_Width/2;
    float ob1_halfHeight = ob1_Height/2;
    float ob2_halfWidth = ob2_Width/2;
    float ob2_halfHeight = ob2_Height/2;
    
    // Collider debug
    //noFill();
    //stroke(255, 0, 0); // Red for object 1
    //rect(ob1_pos.x, ob1_pos.y, ob1_Width, ob1_Height); // Object 1 rectangle
    //stroke(0, 255, 0); // Green for object 2
    //rect(ob2_pos.x, ob2_pos.y, ob2_Width, ob2_Height); // Object 2
    
    // Check for an x-axis overlap (horizontal collision)
    boolean is_X_overlap = 
        (ob1_pos.x + ob1_halfWidth > ob2_pos.x - ob2_halfWidth) && 
        (ob1_pos.x - ob1_halfWidth < ob2_pos.x + ob2_halfWidth);

    // Check for a y-axis overlap (vertical collision)
    boolean is_Y_overlap = 
        (ob1_pos.y + ob1_halfHeight > ob2_pos.y - ob2_halfHeight) && 
        (ob1_pos.y - ob1_halfHeight < ob2_pos.y + ob2_halfHeight);

    // Return true if there is overlap in both the x and y axes, indicating a collision
    return is_X_overlap && is_Y_overlap;
  }
}

// Collidable interface - Objects that can collide must implement this interface
interface Collidable
{
  PVector getPos(); // Get the current position of the object
  float getWidth(); // Get the width of the object
  float getHeight(); // Get the height of the object
  String getTag(); // Get a tag associated with the object (for identification purposes)
  String getType(); // Get the type of the object (e.g. "Player", "Obstacle")
  
  // Called when a collision occurs with another collidable object
  void collidesWith(Collidable other);
  
  // Called when a previously detected collision ends
  void collisionExit(Collidable other); 
}
