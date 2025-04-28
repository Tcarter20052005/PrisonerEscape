// Curb Class - draws and manages movement of curbs. integrates with collidable to become a collidabe object.
class Curb implements Collidable
{
  String tag;
  int x;
  
  Curb(int side, int x) // 0 = Left, 1 = Right
  {
    collide.Add_Collidable(this); // Make the curb collidable
    
    this.x = x;
    
    // Tag the curb dependent on side of road
    if (side == 0)
    {
      this.tag = "L_Curb";
    }
    else if (side == 1)
    {
      this.tag = "R_Curb";
    }
  }
  
  // Display Curb
  void display()
  {
    line(x,0, x,height);
  }
  
  // Move curb
  void move()
  {
    x += x_Movement;
  }
  
  // Collidable interface specific returns
  void collidesWith(Collidable other) 
  {
    //println(this.tag + " collided with " + other.getTag());
  }
  
  void collisionExit(Collidable other)
  {
    
  }
  
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
    return new PVector(x, 0);
  }
  
  float getWidth()
  {
    return 1;
  }
  
  float getHeight()
  {
    return height;
  }
}
