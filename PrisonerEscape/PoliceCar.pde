// Police_Car class
// Extends obstacle as its an obstacle Type
// Represents a police car obstacle with siren animation, warning signal, and movement.
// Behaviors: The car displays a siren animation and shows a warning when it reaches the bottom of the screen.

class Police_Car extends Obstacle
{
  // Speed range for the police car
  float minspeed = 4;  // Minimum speed
  float maxspeed = 6;  // Maximum speed
  
  // Animation for the police car's siren
  Animation Siren;
  
  // Colors for warning and text
  color Warningcol = color(255, 255, 255); // White for the warning rectangle
  color textcol = color(0, 0, 0); // Black for the warning text
  
  // Text object to display a warning symbol
  Text Warning;
  
  // Constructor to initialise the police car position, speed, animations, and warning text
  Police_Car(float y)
  {
    // Set initial position using Determine_Pos method (positioning the car in the grid)
    Determine_Pos("Car", y, minspeed, maxspeed, true, 14);
    
    // initialise the sprite and set its position
    thisSprite.setPos(new PVector(x, y));
    this.type = "Police Car";  // Set the type of obstacle
    
    // Set dimensions of the police car
    Width = 50;
    Height = 80;
    
    // Initialise siren animation and add it to the sprite
    Siren = new Animation(1, Police_Car, 200, 0, true);  // Police car siren animation
    thisSprite.addAnimation("Siren", Siren);
    
    
  }
  
  // Display method handles displaying the police car, its siren, and the warning signal
  void display()
  {
    // Play the siren animation
    thisSprite.PlayAnimation("Siren");
    
    // If the police car off the bottom of the screen (y > height), show a warning
    if (y > height)
    {
      // Initialise warning text with an exclamation mark
      Warning = new Text("!", x, height - 100, "Montserrat-ExtraBold.ttf", 17, CENTER, textcol);
      // Display a warning message and icon
      println("WARNING!!");  // Print warning in console
      
      pushMatrix();  // Start drawing transformation 
      
      // Draw a warning rectangle under the police car
      rectMode(CENTER); // Rectangle is drawn from the center
      fill(Warningcol);  // Set rectangle color
      rect(x, height - 100, 40, 40);  // Draw warning rectangle
      
      // Display warning text
      Warning.display();
      
      popMatrix();  // End drawing transformation
    }
    
    // Call the super class's display method
    super.display();
  }
  
  // Placeholder method
  // void Move() {}
}
