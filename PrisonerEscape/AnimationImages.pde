// Load Animation Images

PImage[] Prisoner_IMG;
String Pris_Folder,Pris_Filename;

PImage[] Officer_1_Idle,Officer_1_Walk,Officer_1_Run,Officer_1_Attack;
String Officer_1_Idle_Folder,Officer_1_Idle_Filename, Officer_1_Walk_Folder,Officer_1_Walk_Filename, Officer_1_Run_Folder,Officer_1_Run_Filename, Officer_1_Attack_Folder,Officer_1_Attack_Filename;

PImage[] Officer_2_Idle,Officer_2_Walk,Officer_2_Run,Officer_2_Attack;
String Officer_2_Idle_Folder,Officer_2_Idle_Filename, Officer_2_Walk_Folder,Officer_2_Walk_Filename, Officer_2_Run_Folder,Officer_2_Run_Filename, Officer_2_Attack_Folder,Officer_2_Attack_Filename;

PImage[] Armed_Idle,Armed_Run,Armed_Shooting;
String Armed_Idle_Folder,Armed_Idle_Filename, Armed_Run_Folder,Armed_Run_Filename, Armed_Shooting_Folder,Armed_Shooting_Filename;

PImage[] K9_Idle_Up,K9_Idle_Down,K9_Idle_Left,K9_Idle_Right;
PImage[] K9_Walk_Up,K9_Walk_Down,K9_Walk_Left,K9_Walk_Right;
PImage[] K9_Attack_Up,K9_Attack_Down,K9_Attack_Left,K9_Attack_Right;
String K9_Up_Filename,K9_Dw_Filename,K9_L_Filename,K9_R_Filename;
String K9_Idle_Up_Folder,K9_Idle_Dw_Folder, K9_Idle_L_Folder, K9_Idle_R_Folder;
String K9_Run_Up_Folder,K9_Run_Dw_Folder, K9_Run_L_Folder,K9_Run_R_Folder;
String K9_Attack_Up_Folder, K9_Attack_Dw_Folder,K9_Attack_L_Folder, K9_Attack_R_Folder;

PImage[] Bullet_Img;
String Bullet_Folder,Bullet_Filename;

PImage Barbed;

PImage[] Police_Car;
String Car_Folder,Car_Filename;

void LoadImages()
{
  // Create an instance of Sprite to load animation frames
  Sprite thisSp = new Sprite();
  
  // Animation Images for Prisoner
  Pris_Folder = "Prisoner"; // Folder containing prisoner animation frames
  Pris_Filename = "Priz";   // Filename prefix for prisoner animation
  Prisoner_IMG = thisSp.LoadFrames(Pris_Folder, Pris_Filename, 1); // Load prisoner frames
  
  // Animation Images for Officer Type 1 (Standard Officer)
  Officer_1_Idle_Folder = "2_Normal/idle"; // Folder for idle animation
  Officer_1_Idle_Filename = "2_police_Idle"; // Filename for idle frames (8 frames)
        
  Officer_1_Walk_Folder = "2_Normal/Walk"; // Folder for walking animation
  Officer_1_Walk_Filename = "2_police_Walk"; // Filename for walk frames (8 frames)
        
  Officer_1_Run_Folder = "2_Normal/Run"; // Folder for running animation
  Officer_1_Run_Filename = "2_police_Run"; // Filename for run frames (6 frames)
        
  Officer_1_Attack_Folder = "2_Normal/Attack"; // Folder for attack animation
  Officer_1_Attack_Filename = "2_police_attack_Attack1"; // Filename for attack frames (10 frames)
  
  // Load the animations for Officer Type 1 (Idle, Walk, Run, Attack)
  Officer_1_Idle = thisSp.LoadFrames(Officer_1_Idle_Folder, Officer_1_Idle_Filename, 8);
  Officer_1_Walk = thisSp.LoadFrames(Officer_1_Walk_Folder, Officer_1_Walk_Filename, 8);
  Officer_1_Run = thisSp.LoadFrames(Officer_1_Run_Folder, Officer_1_Run_Filename, 6);
  Officer_1_Attack = thisSp.LoadFrames(Officer_1_Attack_Folder, Officer_1_Attack_Filename, 10);
  
  // Animation Images for Officer Type 2 (Another Standard Officer)
  Officer_2_Idle_Folder = "3_Normal/idle"; // Folder for idle animation
  Officer_2_Idle_Filename = "3_police_Idle"; // Filename for idle frames (8 frames)
        
  Officer_2_Walk_Folder = "3_Normal/Walk"; // Folder for walking animation
  Officer_2_Walk_Filename = "3_police_Walk"; // Filename for walk frames (8 frames)
        
  Officer_2_Run_Folder = "3_Normal/Run"; // Folder for running animation
  Officer_2_Run_Filename = "3_police_Run"; // Filename for run frames (6 frames)
        
  Officer_2_Attack_Folder = "3_Normal/Attack"; // Folder for attack animation
  Officer_2_Attack_Filename = "3_police_attack_Attack1"; // Filename for attack frames (10 frames)
  
  // Load the animations for Officer Type 2 (Idle, Walk, Run, Attack)
  Officer_2_Idle = thisSp.LoadFrames(Officer_2_Idle_Folder, Officer_2_Idle_Filename, 8);
  Officer_2_Walk = thisSp.LoadFrames(Officer_2_Walk_Folder, Officer_2_Walk_Filename, 8);
  Officer_2_Run = thisSp.LoadFrames(Officer_2_Run_Folder, Officer_2_Run_Filename, 6);
  Officer_2_Attack = thisSp.LoadFrames(Officer_2_Attack_Folder, Officer_2_Attack_Filename, 10);
  
  // Animation Images for Armed Officer
  Armed_Idle_Folder = "1_Armed/idle"; // Folder for idle animation of armed officer
  Armed_Idle_Filename = "1_police_Idle"; // Filename for idle frames (8 frames)
        
  Armed_Run_Folder = "1_Armed/Run"; // Folder for running animation of armed officer
  Armed_Run_Filename = "1_police_Run"; // Filename for run frames (6 frames)
        
  Armed_Shooting_Folder = "1_Armed/Attack"; // Folder for shooting animation of armed officer
  Armed_Shooting_Filename = "1_police_attack_Attack_000"; // Filename for shooting frames (6 frames)
  
  // Load the animations for Armed Officer (Idle, Run, Shooting)
  Armed_Idle = thisSp.LoadFrames(Armed_Idle_Folder, Armed_Idle_Filename, 8);
  Armed_Run = thisSp.LoadFrames(Armed_Run_Folder, Armed_Run_Filename, 6);
  Armed_Shooting = thisSp.LoadFrames(Armed_Shooting_Folder, Armed_Shooting_Filename, 6);
  
  // Animation Images for Bullet
  Bullet_Folder = "1_Armed/Bullet/"; // Folder containing bullet animation frames
  Bullet_Filename = "bullet"; // Filename for bullet frames
  
  Bullet_Img = thisSp.LoadFrames(Bullet_Folder, Bullet_Filename, 1); // Load bullet animation frames
  
  // Animation Images for K9 Unit (Dog)
  K9_Up_Filename = "Up"; // Filename for dog animation facing up
  K9_Dw_Filename = "Down"; // Filename for dog animation facing down
  K9_L_Filename = "Left"; // Filename for dog animation facing left
  K9_R_Filename = "Right"; // Filename for dog animation facing right
  
  // Load the K9 Idle animations for each direction
  K9_Idle_Up_Folder = "Dog/Idle/Up"; // Folder for K9 idle animation facing up
  K9_Idle_Up = thisSp.LoadFrames(K9_Idle_Up_Folder,K9_Up_Filename, 4);
  
  K9_Idle_Dw_Folder = "Dog/Idle/Down"; // Folder for K9 idle animation facing down
  K9_Idle_Down = thisSp.LoadFrames(K9_Idle_Dw_Folder,K9_Dw_Filename, 4);
  
  K9_Idle_L_Folder = "Dog/Idle/Left"; // Folder for K9 idle animation facing left
  K9_Idle_Left = thisSp.LoadFrames(K9_Idle_L_Folder,K9_L_Filename, 4);
  
  K9_Idle_R_Folder = "Dog/Idle/Right"; // Folder for K9 idle animation facing right
  K9_Idle_Right = thisSp.LoadFrames(K9_Idle_R_Folder,K9_R_Filename, 4);
  
  // Load the K9 Walk animations for each direction
  K9_Run_Up_Folder = "Dog/Walk/Up"; // Folder for K9 walk animation facing up
  K9_Walk_Up = thisSp.LoadFrames(K9_Run_Up_Folder,K9_Up_Filename, 4);
  
  K9_Run_Dw_Folder = "Dog/Walk/Down"; // Folder for K9 walk animation facing down
  K9_Walk_Down = thisSp.LoadFrames(K9_Run_Dw_Folder,K9_Dw_Filename, 4);
  
  K9_Run_L_Folder = "Dog/Walk/Left"; // Folder for K9 walk animation facing left
  K9_Walk_Left = thisSp.LoadFrames(K9_Run_L_Folder,K9_L_Filename, 4);
  
  K9_Run_R_Folder = "Dog/Walk/Right"; // Folder for K9 walk animation facing right
  K9_Walk_Right = thisSp.LoadFrames(K9_Run_R_Folder,K9_R_Filename, 4);
  
  // Load the K9 Attack animations for each direction
  K9_Attack_Up_Folder = "Dog/Attack/Up"; // Folder for K9 attack animation facing up
  K9_Attack_Up = thisSp.LoadFrames(K9_Attack_Up_Folder,K9_Up_Filename, 4);
  
  K9_Attack_Dw_Folder = "Dog/Attack/Down"; // Folder for K9 attack animation facing down
  K9_Attack_Down = thisSp.LoadFrames(K9_Attack_Dw_Folder,K9_Dw_Filename, 4);
  
  K9_Attack_L_Folder = "Dog/Attack/Left"; // Folder for K9 attack animation facing left
  K9_Attack_Left = thisSp.LoadFrames(K9_Attack_L_Folder,K9_L_Filename, 4);

  K9_Attack_R_Folder = "Dog/Attack/Right"; // Folder for K9 attack animation facing right
  K9_Attack_Right = thisSp.LoadFrames(K9_Attack_R_Folder,K9_R_Filename, 4);

  // Load the image for barbed wire
  Barbed = loadImage((dataPath("Barbed Wire")+"/wire.png"));
  
  // Animation Images for Police Car
  Car_Folder = "Police Car"; // Folder containing police car animation frames
  Car_Filename = "car"; // Filename for police car frames
  Police_Car = thisSp.LoadFrames(Car_Folder,Car_Filename, 3); // Load police car frames
}
