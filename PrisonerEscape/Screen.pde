// Screen Abstract class
// To be used by any ui screen
abstract class Screen
{ 
  // Constructor can be used for shared initialization if needed
  Screen() {
    // Initialisation code that all screens might need
  }
  
  // Handles display/render of screen, needs to be implemented by each screen.
  abstract void Display(); 
  
  // Handles Button interactions such as clicks or hover
  abstract void ButtonCheck(); 
  
  // Defines the background for the screen
  abstract void Background(); 
  
  // Handles other forms of input on the screen that are unrelated to buttons.
  abstract void Input(); 
}
