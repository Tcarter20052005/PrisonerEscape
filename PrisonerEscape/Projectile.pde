// Projectile class
// Extends obstacle as its an obstacle Type
// Behaviour: Moves at rate of speed.

class Projectile extends Obstacle
{
  // Animation for Bullet projectile 
  Animation Bullet;
  
  // Position
  PVector pos;

  Projectile(PVector spawn, float obx_sp)
  {
    // Intialise position
    pos = new PVector(spawn.x,spawn.y);
    this.x = (int)pos.x;
    this.y = (int)pos.y;
    
    // Intilaise sprite and its position
    thisSprite = new Sprite();
    thisSprite.setPos(new PVector(pos.x, pos.y));
    
    // Set obstacle type and dimensions
    this.type = "Armed Police";
    Width = 15;
    Height = 9;
    
    // Set speed 
    obx_speed = obx_sp; //5
    
    // Initialise animation for the projectile and add to sprite
    Bullet = new Animation(1,Bullet_Img, 3000, 0,false,false);
    thisSprite.addAnimation("Bullet", Bullet);
    
  }
 
  // Display Bullet
  void display()
  {
    // Play bullet animation
    thisSprite.PlayAnimation("Bullet");
    
    // Update sprite state using current game time
    thisSprite.Update(clock.get_Time());
    
    // Display sprite at current position
    PVector currentPos = new PVector(x,y);
    thisSprite.Display(currentPos,Width,Height);
    
    // Call parent class's display method
    super.display();
    
    // origianl display
    //PFont bold = createFont("Arial-BoldMT", 128);
    //fill(0);
    //rectMode(CENTER);
    //rect(x,y,Width,Height);
    //fill(255);
    //textFont(bold);
    //textAlign(CENTER);
    //textSize(10);
    //text("B",x,y);
    
  }
}
