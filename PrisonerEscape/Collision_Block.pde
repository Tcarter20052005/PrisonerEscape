// Collision_Block class
// Purpose: Used to make each side of the blockade a collidabe object
// Extends obstacle as its an obstacle Type
class Collision_Block extends Obstacle
{
  // Position and size of the collision block
  float imgWidth = 60; // Standard image width for the block
  float imgHeight = 21; // Standard image height for the block
  float blockHeight = imgHeight; // Default height is set to image height
  
  
  Collision_Block()
  {
    // Set obstacle tag
    this.type = "Police Blockade";
  }
  
  // Configures the collision block position and size
  void Collision(float x, float y, float Width1)
  {
    this.x = x;
    this.y = y;
    this.Width = Width1;
    this.Height = blockHeight;
    println(Width);
    println(Height);
  }
}
