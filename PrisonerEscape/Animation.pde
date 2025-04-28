// Animation class
// used to animate objects
class Animation
{
  PImage[] frames; // Array to store the frames of the animation
  float frameDuration; // Duration for each frame to be displayed
  float rotation = 0; // The rotation applied to the sprite during animation
  int priority; // The priority of the animation (higher values may have precedence)
  int currentFrame = 0; // Current frame of the animation being displayed
  float lastframeTime = 0; // The time the last frame was displayed
  float elapsedTime = 0; // The time elapsed since the last frame update
  boolean isPlaying = false; // Flag to check if the animation is playing
  boolean doLoop = false; // Flag to indicate whether the animation should loop
  boolean canOverride = false; // Flag to determine if a new animation can override the current one
  boolean flipped = false; // Flag to indicate if the animation is flipped
  
  String Direction; // The direction of the animation (e.g., "left", "right")
  
  // Constructor for creating an animation with a specific priority, frames, frame duration, and rotation
  Animation(int priority, PImage[] frames, float frameDuration, float rotation) {
    this.priority = priority;
    this.frames = frames;
    this.frameDuration = frameDuration;
    this.rotation = rotation;
  }
  
  // Constructor that allows looping of the animation
  Animation(int priority, PImage[] frames, float frameDuration, float rotation, boolean doLoop) {
    this(priority, frames, frameDuration, rotation); 
    this.doLoop = doLoop; // Set whether the animation should loop
  }
  
  // Constructor that allows overriding of the animation
  Animation(int priority, PImage[] frames, float frameDuration, float rotation, boolean doLoop, boolean canOverride) {
    this(priority, frames, frameDuration, rotation, doLoop); 
    this.canOverride = canOverride; // Set whether the animation can be overridden by another animation
  }
  
  // Constructor that also takes the direction of the animation
  Animation(int priority, PImage[] frames, float frameDuration, float rotation, boolean doLoop, boolean canOverride, String Direction) {
    this(priority, frames, frameDuration, rotation, doLoop, canOverride); 
    this.Direction = Direction; // Set the direction of the animation (e.g., "left", "right")
  }
  
  // Start the animation
  void Start()
  {
    isPlaying = true; // Set the animation to be playing
    currentFrame = 0; // Reset to the first frame
    elapsedTime = 0; // Reset the elapsed time
  }
  
  // Stop the animation
  void Stop()
  {
    isPlaying = false; // Set the animation to not be playing
    currentFrame = 0; // Reset to the first frame
    elapsedTime = 0; // Reset the elapsed time
  }
  
  // Update the animation based on the current time
  void Update(float currentTime)
  {
    if (!isPlaying)
    {
      return; // If the animation is not playing, do nothing
    }
    
    elapsedTime = currentTime - lastframeTime; // Calculate the time elapsed since the last frame
    
    // If the elapsed time exceeds the frame duration, advance to the next frame
    if (elapsedTime >= frameDuration)
    {
      currentFrame += 1; // Move to the next frame
      lastframeTime = currentTime; // Update the time for the last frame
      
      // If the animation has reached the end, loop it or stop it
      if (currentFrame >= frames.length)
      {
        if (doLoop)
        {
          currentFrame = 0; // Loop back to the first frame
        } else 
        {
          currentFrame = frames.length - 1; // Stay on the last frame
          isPlaying = false; // Stop the animation
        }
      }
    }
  }
  
  // Display the current frame of the animation at the given position
  void Display(float x, float y, float Width, float Height)
  {
    pushMatrix(); // Save the current drawing matrix
    translate(x, y); // Translate the origin to the sprite's position
    
    // If the sprite is flipped, flip it horizontally
    if (flipped)
    {
      scale(-1, 1); // Flip horizontally
    }
    
    rotate(radians(rotation)); // Apply rotation to the sprite
    
    imageMode(CENTER); // Set image mode to centre
    
    // Display the current frame with different scaling based on its size
    PImage current = frames[currentFrame]; // Get the current frame to display
    if (Height == 80)
    {
      image(frames[currentFrame], 0, 0, Width+30, Height); // If height is 80, slightly scale the width
    }
    else if (current.width == 64 && current.height == 64) {
      // If the image is 64x64, scale it up
      image(frames[currentFrame], 0, 0, Width * 2, Height * 2);
    } else {
      // Otherwise, use the original dimensions
      image(frames[currentFrame], 0, 0, Width, Height);
    }
    
    popMatrix(); // Restore the previous drawing matrix
  }
}
