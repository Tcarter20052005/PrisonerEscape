// Sprite class
// Used for managing, playing and loading animations
class Sprite
{
  PVector defaultpos = new PVector(0,0); // Default position of the sprite
  PVector spawnPos = new PVector(0,0); // Position where the sprite is spawned
  PVector position = new PVector(0,0); // Current position of the sprite
  PVector previousPos = new PVector(0,0); // Store the previous position of the sprite
  
  
  boolean isDirectional = false; // Flag to check if sprite is directional
  boolean lookUp = false; // Directional flag for looking upwards
  boolean lookDown = false; // Directional flag for looking downwards
  boolean lookLeft = false; // Directional flag for looking left
  boolean lookRight = false; // Directional flag for looking right
  
  boolean isFlipped = false; // Flag to determine if sprite is flipped
  
  float Width, Height; // Width and height of the sprite
  HashMap<String, Animation> Animations = new HashMap<>(); // A map to store different animations for the sprite
  
  Animation defAnimation; // Default animation of the sprite
  Animation currentAnimation; // Current animation being played
  
  Sprite()
  {
    // Constructor to initialise the sprite object
  }
  
  void setPos(PVector defaultpos)
  {
    position = defaultpos; // Set current position
    previousPos = defaultpos; // Set previous position
    spawnPos = new PVector(position.x, position.y); // Set spawn position
    
    // Check if sprite is flipped based on its position
    if ((spawnPos.x > width/2) && !isDirectional)
    {
      isFlipped = true; // If sprite is on the right side of the screen, it is flipped
    }
  }
  
  void addAnimation(String Name, Animation animation)
  {
    Animations.put(Name, animation); // Add a new animation to the sprite
    
    // If no default animation exists, set the provided animation as the default
    if (defAnimation == null)
    {
      defAnimation = animation;
    }
    
    // If no current animation exists, set the provided animation as the current
    if (currentAnimation == null)
    {
      currentAnimation = animation;
    }
  }
  
  void PlayAnimation(String name)
  {
    // Check if the animation exists in the hashmap
    if (Animations.containsKey(name))
    {
      // If the animation is already playing and can't override, return early
      Animation newAnimation = Animations.get(name);
      boolean sameasCurrent = currentAnimation == newAnimation;
      
      boolean SameisPlaying = false;
      if (currentAnimation.Direction != null & newAnimation.Direction != null)
      {
        if (currentAnimation.Direction == newAnimation.Direction)
        {
          return; // If the direction is the same, no need to change the animation
        }
      }
      
      if (sameasCurrent && currentAnimation.isPlaying)
      {
        SameisPlaying = true; // If the animation is already playing, don't restart it
      }
      
      if (!currentAnimation.canOverride || SameisPlaying)  
      {
        return; // If the current animation can't be overridden or is playing, do nothing
      }
      
      // Change the animation and start it
      currentAnimation = newAnimation;
      currentAnimation.Start();
      
    } else
    {
      println("Animation not found name:" + name); // Print an error message if the animation name doesn't exist
    }
  }
  
  void Update(float currentTime)
  {
    // Update the sprite position and animation state
    previousPos.set(position); // Save the previous position
    
    // If an animation is set, update its state
    if (currentAnimation != null)
    {
      if (isFlipped)
      {
        currentAnimation.flipped = true; // Set the animation to be flipped if required
      }
      
      currentAnimation.Update(currentTime); // Update the current animation state
    }
  }
  
  void Display(PVector pos, float Width, float Height)
  {
    position = pos; // Set the current position for the sprite
    
    // If an animation is set, display it
    if (currentAnimation != null)
    { 
      currentAnimation.Display(pos.x, pos.y, Width, Height); // Display the current animation at the given position
    }
  }
  
  PImage[] LoadFrames(String folderPath, String fileName, int numOfFrames)
  {
    // Load the frames for an animation from a specified folder
    File folder = new File(dataPath(folderPath));
    
    PImage[] frames = new PImage[numOfFrames]; // Array to store the frames
    
    for (int i = 0; i < numOfFrames; i++)
    {
      PImage image = loadImage(folder+"/"+fileName+"_00"+i+".png"); // Load the image file for each frame
      if (image.width > 720 || image.height > 1280) {
        println("RESIZE"); // If the image is too large, resize it
        image.resize(720, 0); // Resize the image to fit within a maximum width of 720
      }
      frames[i] = image; // Store the loaded frame in the array
    }
    return frames; // Return the array of frames
  }
}
