abstract class Paddle {
  PVector position;
  float width = 30;
  float height = 5;

  Paddle() {
    position = new PVector(0, 0, 0);
  }

  abstract void update(Ball ball);

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(255, 0, 0);
    box(width, height, 5);
    popMatrix();
  }
}
