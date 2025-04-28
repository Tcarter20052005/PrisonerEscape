// Combined Armed Block class
// Extends obstacle as its an obstacle Type
// Behaviour: spawns a armed police officer and blockade

class Combined_ArmedBlock extends Obstacle
{
  // Verticle coordinate to place block and officer
  float spawnY;
  
  // Obstacles spawned by this class
  Obstacle armed,block;
  
  Combined_ArmedBlock(float spawnY)
  {
    // Set the position using playfield grid
    PVector pos = playfield_Man.GridPos(2,spawnY);
    this.spawnY = spawnY;
    this.x = (int)pos.x;
    this.y = (int)pos.y;
    
    
    // Set type and position of the sprite
    this.type = "Combined_ArmedBlock";
    thisSprite.setPos(new PVector(x,y));
    //Width = playersize;
    //Height = playersize;
    
    // Spawn the armed officer and the blockade
    armed = spawnArmed();
    block = spawnBlock();
  }
  
  // Creates an Armed_Police obstacle
  Obstacle spawnArmed()
  {
    return new Armed_Police(spawnY);
  }
  
  // Creates a Police_Blockade obstacle slightly above the specified vertical position
  Obstacle spawnBlock()
  {
    return new Police_Blockade(spawnY - 1); // Position the blockade 1 unit above the armed officer
  }
  
  // Placeholder for displaying the combined obstacle
  void display()
  {
  }
  
  // Placeholder for movement logic
  void Move()
  {
  }
}
