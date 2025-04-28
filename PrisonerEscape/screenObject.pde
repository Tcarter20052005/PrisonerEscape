abstract class screenObject
{
  screenObject()
  {
    on_screen.add(this);
  }

  abstract void display();
  
  abstract void Move();
}
