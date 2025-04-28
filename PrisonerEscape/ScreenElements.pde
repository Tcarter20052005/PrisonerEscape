// Class that stores the different type of elements to be used on UI Screens.
class ScreenElement
{
  float x, y, Width, Height;
  boolean isVisible = true;  // Visibility flag for the element
  
  // Constructor initializes position and dimensions of the element
  ScreenElement(float x, float y, float Width, float Height)
  {
    this.x = x;
    this.y = y;
    this.Width = Width;
    this.Height = Height;
  }
  
  // Displays the element if it's visible
  void display()
  {
    if (isVisible) 
    {
      rectMode(CENTER);  // Center rectangle mode for positioning
      rect(x, y, Width, Height);  // Draws the rectangle (element)
    }
  }
  
  // Toggles the visibility of the element
  void toggleVisibility() 
  {
    isVisible = !isVisible;
  }
}

// Button Class - Represents a clickable button on the UI
class Button extends ScreenElement
{
  String labelvalue;  // Text displayed on the button
  Text label;  // Text object for rendering the button's label
  color bgColor, textColor;  // Background and text colors
  float FontSize, FontSizeW, FontSizeH;
  
  // Proportions for font size relative to button's dimensions
  float proportionWidth = 0.5; // Font size based on width (50% of the button width)
  float proportionHeight = 0.4; // Font size based on height (40% of the button height)
  
  // Constructor initializes button's dimensions, label, and font size
  Button(float x, float y, float Width, float Height, String labelvalue)
  {
    super(x, y, Height * 2, Height);  // Calls the parent constructor
    Width = Height * 2;  // Set the button width
    this.labelvalue = labelvalue;
    this.bgColor = color(100);  // Default background color (grey)
    this.textColor = color(255);  // Default text color (white)
    
    FontSizeW = Width * proportionWidth;  // Font size based on width
    FontSizeH = Height * proportionHeight;  // Font size based on height
    FontSize = min(FontSizeW, FontSizeH);  // Choose the smaller font size
    label = new Text(labelvalue, x, y, "Montserrat-Regular.ttf", FontSize, CENTER, textColor);  // Initialize label
  }
  
  // Displays the button and its label
  void display()
  {
    if (isVisible) 
    {
      fill(bgColor);  // Set button's background color
      rectMode(CENTER);  // Center the rectangle for positioning
      rect(x, y, Height * 2, Height);  // Draw the button
      label.display();  // Display the label on the button
    }
  }
  
  // Checks if the mouse is over the button (for hover effect or click)
  boolean IfOver(float mouseX, float mouseY) 
  {
    return mouseX > x - Width / 2 && mouseX < x + Width / 2 &&  // Check if mouseX is within button's width
           mouseY > y - Height / 2 && mouseY < y + Height / 2;  // Check if mouseY is within button's height
  }
  
}

// Text Class - Represents a text element displayed on the UI
class Text extends ScreenElement
{
  String value, fontName;  // The text value and font name
  float fontSize = 1;  // The font size for the text
  PFont bold, Montserrat_EB;  // Font objects (can be extended)
  int Alignment = CENTER;  // Text alignment (default is CENTER)
  
  PFont currentFont;  // Current font used for rendering
  PFont defaultFont;  // Default font
  color TextCol = color(0, 0, 0);  // Default text color (black)
  
  // Constructor initializes the text value, position, font, size, alignment, and color
  Text(String value, float x, float y, String fontName, float fontSize, int Alignment, color col)
  {
    super(x, y, 0, 0);  // Calls the parent constructor, no width/height needed for text
    this.value = value;
    this.fontName = fontName;
    this.fontSize = fontSize;
    this.Alignment = Alignment;
    this.TextCol = col;  // Set text color
    loadFont(fontName);  // Load the font
    
    textAlign(CENTER, CENTER);  // Set text alignment to center
  }
  
  // Loads the specified font
  void loadFont(String fontName)
  {
    currentFont = createFont("Fonts/" + fontName, fontSize);  // Load the font file
  }
  
  // Set the alignment of the text (e.g., LEFT, CENTER, RIGHT)
  void setAlignment(int newAlignment)
  {
    this.Alignment = newAlignment;
    textAlign(Alignment);  // Apply the new alignment
  }
  
  // Set the font size of the text
  void setFontSize(float newSize)
  {
    this.fontSize = newSize;
    currentFont = createFont(currentFont.getName(), newSize);  // Re-load font with new size
  }
  
  // Displays the text with the specified settings
  void display()
  {
    fill(TextCol);  // Set text color
    textFont(currentFont);  // Set the current font
    text(value, x, y);  // Draw the text at specified position
  }
}
