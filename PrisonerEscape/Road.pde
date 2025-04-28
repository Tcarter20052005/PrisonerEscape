// Had to place curbs as a class to make it collidable

// Road Class
// Handles road look and movement logic

// ROAD Class - Draws and controls the road
class Road extends screenObject
{
  // Boundaries and Position for the road
  int leftBound; // position boundary of left curb
  int rightBound; // position boundary of right curb
  int left_CurbPos; // Current position of left curb
  int right_CurbPos; // Current position of right curb
  int roadCentre; // Current position of centre of road
  
  
  // Road Marking Specifications
  int roadMarkLength = 50; // Length of each road marking in pixels
  int roadMarkGap = 20; // Gap between each road marking in pixels
  
  float[] markingY; // Array to hold Y positions of road markings
  
  Curb curbL,curbR; // Left and Right curbs
  
  Road()
  {
    intialiseRoad();
  }
  
  // Sets up road boundaries, markers etc
  void intialiseRoad()
  {
    // Boundaries setup
    leftBound = cellWidth*1; // left curb boundary
    rightBound =cellWidth*7; // right curb boundary
    
    left_CurbPos = leftBound; // current left curb position
    right_CurbPos = rightBound; // current right curb position
    roadCentre = left_CurbPos + (screenWidth/8)*3; // current road centre
    
    // Create Curbs
    this.curbL = new Curb(0, left_CurbPos);
    this.curbR = new Curb(1, right_CurbPos);
    
    setupCentreMarkings(); // setup centre markings for screen
  }
  
  // Display road surfaces
  void display()
  {
    road_Fill();
    verges();
    curbs();
    centreMarkings();
  }
  
  // Move road surfaces
  void Move() 
  {
    curbL.move();
    curbR.move();
    roadCentre = curbL.x+150; // road width is 300 so add 150 to left curb to get centre
  }
  
  // Return list of x position for both sides of road
  float[] current_CurbPos()
  {
    float[] current = {curbL.x,curbR.x}; // Gather the current pos of the left and right of road
    
    return current;
  }
  
  // Fill the road dynamic to its location
  void road_Fill() 
  {
    fill(179,179,179); // Standard road colour
    rect((curbL.x+cellWidth*3),screenHeight/2, (curbR.x-curbL.x),height);
  }
  
  // Fill verges of road dynamic of road location
  void verges()
  {
    fill(65,152,10);
    int l_x = curbL.x/2; // centre of left verge
    int r_x = curbR.x+(screenWidth-(curbR.x+1))/2; // centre of right verge
    int y = screenHeight/2;
    rect(l_x,y, curbL.x-1, height);
    rect(r_x,y, (screenWidth-(curbR.x+1)), height);
  }
  
  // Display curbs
  void curbs()
  {
    curbL.display();
    curbR.display();
  }
  
  // Draw and move centre markers
  void centreMarkings()
  {
    stroke(255);
    strokeWeight(5);
    
    int bottomBound = screenHeight + roadMarkGap;
    
    for (int y_pos = 0; y_pos < markingY.length; y_pos++)
    {
      markingY[y_pos] += speedY;
      
      if (markingY[y_pos] > bottomBound) // if marking reached bottom of display
      {
        // Loop Markings back to the top
        if (y_pos == markingY.length-1)
        {
          markingY[y_pos] = markingY[0]-(roadMarkLength+roadMarkGap); 
        }
        else
        {
          markingY[y_pos] = markingY[y_pos + 1]-(roadMarkLength+roadMarkGap); // take position of next marking
        }
      }
    }
    
    // Draw updated markings
    for (float liney : markingY) 
    {
        line(roadCentre, liney, roadCentre, liney + roadMarkLength); // Draw each marking with updated y values
    }
    
    // Reset stroke settings
    stroke(1);
    strokeWeight(1);
  }
  
  // Set Up Road Markings
  void setupCentreMarkings()
  {
    int numofMarks = ((screenHeight+roadMarkGap)/(roadMarkLength+roadMarkGap))+2; // Access the number of markers possible
    
    // Intialise MarkingY array to the be set size to the number of markings required
    markingY = new float[numofMarks];
    int y = 0;
    
    // Loop through numofMarks, setting intial y values of markings
    for (int i = 0; i<numofMarks; i++)
    {
      markingY[i] = y;
      y += roadMarkLength+roadMarkGap;
    }
  } 
}
