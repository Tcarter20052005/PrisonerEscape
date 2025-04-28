// Main File of Prisoner Escape
// Intialises and manages the game

// Screen Dimensions
int screenWidth = 400; // Width of Game Window
int screenHeight = 300; // Height of Game Window

// Game Modes
gameMode gamemode = gameMode.SPLASH; // Set gamemode using gamemode enum

// Game Management Tool Object Declarations
Clock clock;              // Manages game time and provides timing functionalities.
playfieldManager playfield_Man; // Handles gamefield during game play. Object movement, Background Display etc
Player player;            // Represents the player character and its interactions.
Collision_Man collide;    // Manages collision detection between game objects.
Obstacle_Manager obstacle_Man;  // Controls the spawning and behavior of obstacles.
Difficulty difficulty;     // Manages game difficulty scaling.
highScore highscore; // Highscore management
  

// Screen Objects
Screen splash, start, pause, player_HUD, death;

// Called before sketch has started
void settings()
{
  size(screenWidth, screenHeight); // set size of sketch window using variables
}

// Runs once when sketch starts
void setup()
{
  
  surface.setTitle("Prisoner Escape");
  
  rectMode(CENTER); // Set default rectmode to CENTER
  
  PlayLoad();
  
  // Create Screens
  splash = new SplashScreen();
  start = new StartScreen();
  pause = new PauseScreen();
  death = new DeathScreen();
  
  LoadImages();
  
}

// Creates/Reintialises game managment systems
void PlayLoad()
{
  collide = new Collision_Man();
  playfield_Man = new playfieldManager();
  
  clock = new Clock();
  difficulty = new Difficulty();
  obstacle_Man = new Obstacle_Manager();
  player = new Player(); 
  player_HUD = new PlayDisplay();
  
  highscore = new highScore();
  
  // Reset key states
  // Each Key State
  leftPressed = false;
  rightPressed = false;
  upPressed = false;
  downPressed = false;
  
  speedY = 1.5; // reset speed
  
  clock.Reset(); // Reset clock time relevant to program time
}

void draw()
{ 
  // Handle different game modes based on the current state (splash screen, start, playing, pause, or death).
  // The gamemode variable determining which screen or gameplay state is active at any given time.
  switch(gamemode) {
    case SPLASH:
        // Display splash screen when game intialised
        splash.Display();
        break;
    case START:
        // Display start screen
        start.Display();
        break;
    case PLAYING:
        // Handle game logic and systems when game is active/unpaused
    
        clock.Run(); // Run the game clock
        difficulty.Play(); // Adjust game difficulty over time
        
        background(255); // Clear the screen
        
        playfield_Man.display(); // Display game environment and manage on screen objects
        player.display(); // Display Player character
        obstacle_Man.Display(); // Display Obstacles
        
        obstacle_Man.Spawner(); // Spawn obstacles
        obstacle_Man.RunLoopRun(); // Execute obstacle specified behaviour
        
        collide.checkCollisions(collidables); // Check for collisions between all collidables
        player_HUD.Display(); // Show player HUD
        break;
    case DEATH:
        // Display the death screen
        death.Display();
        break;
    case PAUSE:
        // Display pause screen
        pause.Display();
        break;
  }
}

// Runs when mouse pressed
void mousePressed()
{
  // Handles button click checks for various screens
  if (gamemode == gameMode.START)
  {
    start.ButtonCheck();
  } 
  else if (gamemode == gameMode.PAUSE)
  {
    pause.ButtonCheck();
  }
  else if (gamemode == gameMode.DEATH)
  {
    death.ButtonCheck();
  }
}

// Runs when key pressed
void keyPressed()
{
  // Handles user kyboard input for different modes
  if (gamemode == gameMode.SPLASH)
  {
    splash.Input();
  } 
  else if (gamemode == gameMode.PLAYING)
  {
    player.OnKeyPressed();
  }
  
}

// Runs when key released
void keyReleased()
{
  // Handles key release player actions
  if (gamemode == gameMode.PLAYING)
  {
    player.onKeyReleased();
  }
}
