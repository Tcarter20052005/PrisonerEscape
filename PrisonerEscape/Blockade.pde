// Police_Blockade class
// Extends obstacle as its an obstacle Type

class Police_Blockade extends Obstacle
{
  // Road position and required data points
  float[] roadpos;
  float left,right,gapStart,gapWidth,gapend,lw,rw, base_gs, base_ge;
  
  // Dimensions of blockade image
  float imgWidth = 60;
  float imgHeight = 21;
  
  // Collision blocks for the left and right parts of the blockade
  Collision_Block Left = new Collision_Block();
  Collision_Block Right = new Collision_Block();
  
  Police_Blockade(float y)
  {
    // Gather grid position coordinates and set them
    PVector pos = playfield_Man.GridPos(0,y);
    this.x = 0;
    this.y = (int)pos.y;
    
    // Tag obstacle type
    this.type = "Police Blockade";
    
    // Set Dimensions
    Width = 0;
    Height = 0;
    
    // Determine gap position and road alignment
    Set_Pos_Road();
  }
  
  // Display Police Blockade
  void display()
  {
    generate_Block(); // Genrate visuals and collision elements
    super.display(); // call parent class display
  }
  
  // Fills block section with blockade image
  void Image_Fill(float y, float start, float Widthend)
  { 
    float imgx = start; // Starting position for images
    
    // Calculate how many full images fit and any remaining partial space
    int AllowedCal = (int)(Widthend / imgWidth);
    float remainingWidth = (Widthend / imgWidth) % 1;
    
    pushMatrix();
    imageMode(CORNER);
    
    // Draw full images
    for (int i = 1; i <= AllowedCal; i++)
    {
      image(Barbed, imgx,y, imgWidth, imgHeight);
      imgx += imgWidth;
      
    }
    
    // Draw partial images if required
    if (remainingWidth > 0)
    {
      image(Barbed, imgx,y,imgWidth*remainingWidth,imgHeight);
    }
    popMatrix();
  }
  
  // Draw outline of block
  void Outline(float x,float y,float olWidth,float olHeight)
  {
    float x2 = x + olWidth;
    float y2 = y + olHeight;
    
    line(x,y,x2,y); //top
    line(x,y,x,y2); // left
    line(x2,y,x2,y2); // right
    line(x,y2,x2,y2); // bottom
    
  }
  
  // Generate the visual and collision elements of the police blockade
  void generate_Block()
  {
    // Get current road position
    roadpos = playfield_Man.road.current_CurbPos();
    
    // Gather the left and right bounds of the road
    left = roadpos[0];
    right = roadpos[1];
    
    pushMatrix();
    // Calculate gaps end and width of each half
    gapend = gapWidth+gapStart;
    lw = gapStart-playfield_Man.road.current_CurbPos()[0];
    rw = (playfield_Man.road.current_CurbPos()[1]-gapend);
    
    // Draw left and right blockades based on the gap position
    if (gapStart == left)
    {
      Outline(gapend,y,rw,imgHeight);
      Image_Fill(y, gapend, rw);
    }
    else if (gapend >= right)
    {
      Outline(playfield_Man.road.current_CurbPos()[0],y,lw,imgHeight);
      Image_Fill(y, playfield_Man.road.current_CurbPos()[0], lw);
    }
    else
    {
      Outline(gapend,y,rw,imgHeight);
      Image_Fill(y, gapend, rw);      
         
      Outline(playfield_Man.road.current_CurbPos()[0],y,lw,imgHeight);
      Image_Fill(y, playfield_Man.road.current_CurbPos()[0], lw);
      
    }
    // Set left and right collision blockse based on gap position
    float center_y = imgHeight/2; // Calculate center of blockade
    
    float r_cen_x = playfield_Man.road.current_CurbPos()[1]-(rw/2); // Calculated center x of left block
    Right.Collision(r_cen_x,y+center_y, rw);
    
    float l_cen_x = gapStart-(lw/2); // Calculated center x of left block
    Left.Collision(l_cen_x,y+center_y, lw);
    popMatrix();
  }
  
  // Handles the movement of the blockade
  void Move()
  {
    gapStart += x_Movement;
    gapend += x_Movement;
  }
  
  // Determine the position of road and the gap
  void Set_Pos_Road()
  {
    
    // Get current road position
    roadpos = playfield_Man.road.current_CurbPos();
    left = roadpos[0];
    right = roadpos[1];
    
    // Determine gap width and starting position
    int gapPadding = 45;
    int minWidth = gapPadding;
    int maxWidth = 70;
    gapWidth = random(minWidth, maxWidth);
    gapStart = random(left+gapPadding,right-gapPadding);
    
    // Store base values for resetting/reference
    base_gs = gapStart;
    base_ge = gapWidth;
  }
}
