import java.util.Iterator;

// Obstacle Manager
// Responsible for managing the spawning, rendering, and updating of obstacles in the game.
// It adjusts the spawn rate based on difficulty and handles adding/removing obstacles from the screen.

class Obstacle_Manager
{
  // List of obstacles currently on screen
  ArrayList<Obstacle> obstacle_OnScreen;

  // Lists for obstacles to be added or removed during the update cycle
  ArrayList<Obstacle> toAdd = new ArrayList<>();
  ArrayList<Obstacle> toRemove = new ArrayList<>();

  // Y position for spawning obstacles
  float spawnY = -2;
  
  // Time interval between spawns
  float interval_Between_Spawns = random(2000f, 4000f);
  
  // Max and min spawn intervals (adjusted by difficulty)
  float max_interval = 4000f;
  float min_interval = 2000f;
  
  // Time of last spawn to calculate spawn intervals
  float time_LastSpawn = 0;

  // Adjusted spawn intervals based on game difficulty
  float adjustedMinInterval = 0;
  float adjustedMaxInterval = 0;

  // Constructor: Initialises the list of obstacles on screen
  Obstacle_Manager()
  {
    obstacle_OnScreen = new ArrayList<Obstacle>(); // List to hold obstacles on the screen
  }

  // Add a new obstacle to the list of obstacles to add
  void AddObstacle(Obstacle ob) 
  {
    toAdd.add(ob);
  }

  // Add an obstacle to the list of obstacles to remove
  void RemoveObstacle(Obstacle ob)
  {
    toRemove.add(ob);
  }

  // Main method to display, update, add, and remove obstacles
  void Display() 
  {
    Render();  // Display all obstacles
    Update();  // Update each obstacle
    Remove();  // Remove obstacles marked for removal
    Add();     // Add new obstacles
  }
  
  // Renders all obstacles currently on screen
  void Render()
  {
    Iterator<Obstacle> iterator = obstacle_OnScreen.iterator();

    while (iterator.hasNext()) {
      Obstacle ob = iterator.next();
      ob.display();  // Display each obstacle
    }
  }
  
  // Updates all obstacles currently on screen
  void Update()
  {
    Iterator<Obstacle> iterator = obstacle_OnScreen.iterator();

    while (iterator.hasNext()) {
      Obstacle ob = iterator.next();
      ob.LoopRun();  // Call the LoopRun method for each obstacle
    }
  }
  
  // Adds obstacles from the toAdd list to the main list
  void Add()
  {
    obstacle_OnScreen.addAll(toAdd);
    toAdd.clear();  // Clear the toAdd list after adding obstacles
  }
  
  // Removes obstacles from the toRemove list from the main list
  void Remove()
  {
    obstacle_OnScreen.removeAll(toRemove);
    toRemove.clear();  // Clear the toRemove list after removal
  }

  // Updates the spawn interval based on the current game difficulty
  void updateSpawnInterval() {
    float difficultyFactor = difficulty.getFactor();
    
    if (difficultyFactor != 1.9) {
      adjustedMinInterval = min_interval / difficultyFactor;
      adjustedMaxInterval = max_interval / difficultyFactor;
    }

    // Set the random spawn interval within the new range
    interval_Between_Spawns = random(adjustedMinInterval, adjustedMaxInterval);
  }
  
  // Handles the spawning of obstacles at regular intervals
  void Spawner()
  {
    float timeSince = clock.get_Time() - time_LastSpawn;

    if (timeSince >= interval_Between_Spawns || timeSince == 0) {
      Obstacle ob = get_Next();  // Get the next obstacle to spawn
      if (ob != null) {
        println("spawned: " + ob.type + " after: " + timeSince);
      } else {
        println("null");  // Log a message if no obstacle is spawned
      }

      time_LastSpawn = clock.get_Time();  // Update the last spawn time
      updateSpawnInterval();  // Adjust the spawn interval based on difficulty
    }
  }
  
  // Calls LoopRun for each obstacle in the current screen
  void RunLoopRun()
  {
    ArrayList<Obstacle> obstaclesCopy = new ArrayList<>(obstacle_OnScreen);

    for (Obstacle ob : obstaclesCopy) {
        ob.LoopRun();  // Update each obstacle
    }
  }

  // Adjusts the weight of each obstacle type based on difficulty
  float getAdjustedWeight(ObWeight current)
  {
    float weight = current.get_Base();
    float game_Difficulty = difficulty.getFactor();

    if (current == ObWeight.PB) {
      weight *= game_Difficulty;  // Police Blockade weight increases with difficulty
    } else if (current == ObWeight.PO) {
      weight /= game_Difficulty;  // Officer weight decreases with difficulty
    } else {
      weight *= Math.pow(game_Difficulty, 1.2);  // Adjust other obstacles with a higher multiplier
    }

    return weight;
  }

  // Determines the next obstacle to spawn based on weighted probabilities
  Obstacle get_Next()
  {
    ObWeight selected = null;
    float totalweight = 0;

    // Calculate the total weight of all obstacle types
    for (ObWeight obs : ObWeight.values()) {
      totalweight += getAdjustedWeight(obs);
    }

    // Select an obstacle based on the weighted random selection
    float randomV = random(0, totalweight);
    float cum_Weight = 0;

    for (ObWeight obs : ObWeight.values()) {
      cum_Weight += getAdjustedWeight(obs);
      if (randomV <= cum_Weight) {
        selected = obs;
        break;
      }
    }

    // If no obstacle is selected, default to Officer (PO)
    if (selected == null) {
      selected = ObWeight.PO;
    }

    // Return the selected obstacle based on the random selection
    switch(selected) {
      case PO:
        return new Officer(spawnY);
      case PB:
        return new Police_Blockade(spawnY);
      case AP:
        return new Armed_Police(spawnY);
      case CAB:
        return new Combined_ArmedBlock(spawnY);
      case K9:
        return new K9(spawnY);
      case PC:
        return new Police_Car(-6);
      default:
        return null;
    }
  }
}

// Enum to store spawn probability weight of each Obstacle type
enum ObWeight {
  PO(0.4f),
  PB(0.3f),
  AP(0.2f),
  CAB(0.1f),
  K9(0.2f),
  PC(0.1f);

  final float baseWeight;

  ObWeight(float baseWeight) {
    this.baseWeight = baseWeight;
  }

  float get_Base() {
    return baseWeight;
  }
}
