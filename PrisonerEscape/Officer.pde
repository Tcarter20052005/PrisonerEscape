// Officer Class
// Extends obstacle as its an obstacle Type
// Behaviour: moves across x axis searching for player then tracks to that player for a specified time
class Officer extends Obstacle
{
  // Animations for the officer's different actions
  Animation Idle,Walk,Run,Attack;
  
  // Speed range for the officer
  float minspeed = 1.5;
  float maxspeed = 2.3;
  
  Officer(float y)
  {
    Determine_Pos("Officer", y, minspeed, maxspeed, false, 0); // Determine position type Officer
    
    
    thisSprite.setPos(new PVector(x,y)); // Set position of sprite transfrom to Officer position
    this.type = "Police officer"; // Set obstacle type
    
    tracker = new Tracker(this,player, 2000, true); // Instialise tracker required with time of 2 seconds 2000ms

    // Set Dimensions
    Width = 40;
    Height = 40;
    
    
    DecideOutfit(); // Decide whether appearance is type 1 or 2
    
    // Update Sprite
    thisSprite.Update(clock.get_Time());
  }
  
  // Display Officer
  void display()
  {
    // Check if the tracker is currently tracking or if non-standard move is active
    if (tracker.tracking || tracker.Tracker.nostandardMove)
    {
      // If in attacking state play 'Attack' animation
      if (tracker.attacking)
      {
        thisSprite.PlayAnimation("Attack");
      }
      // If neither attacking nor using standard movement play "Idle" animation
      else if(tracker.Tracker.nostandardMove)
      {
        thisSprite.PlayAnimation("Idle");
      }
      // If standard movement active play "Run" animation
      else
      {
        thisSprite.PlayAnimation("Run");
      }
    }
    else
    {
      //println("Walk");
      thisSprite.PlayAnimation("Walk");
    }
    
    // original officer display
    //PFont bold = createFont("Arial-BoldMT", 128);
    //fill(0);
    //rectMode(CENTER);
    //rect(x,y,Width,Height);
    //fill(255);
    //textFont(bold);
    //textAlign(CENTER);
    //textSize(15);
    //text("P",x,y);
    
    // Call the Track_Display method 
    tracker.Track_Display();
    
    super.display(); // Call the parent class' display method for any shared functionality
  }
  
  // Decide Outfit - Randomly selects the officer's outfit and sets the corresponding animations
  void DecideOutfit()
  {
    int outfitNum = (int) random(1,3);
    
    // Dependent on oufitNum set animations to look selected
    switch (outfitNum)
    {
      case 1:
      // Set the animations for outfit 1
        Idle = new Animation(3,Officer_1_Idle,200,0,true,true);
        Walk = new Animation(2,Officer_1_Walk,200,0,true, true);
        Run = new Animation(2,Officer_1_Run,125,0,true, true);
        Attack = new Animation(1,Officer_1_Attack,200,0,true, true);
        break;
      case 2:
      // Set the animations for outfit 2
        Idle = new Animation(3,Officer_2_Idle,200,0,true,true);
        Walk = new Animation(2,Officer_2_Walk,200,0,true, true);
        Run = new Animation(2,Officer_2_Run,125,0,true, true);
        Attack = new Animation(1,Officer_2_Attack,200,0,true, true);
        break;
    }
    
    // Add animations to officers sprite
    thisSprite.addAnimation("Idle", Idle);
    thisSprite.addAnimation("Walk", Walk);
    thisSprite.addAnimation("Run", Run);
    thisSprite.addAnimation("Attack", Attack);
  }
}
