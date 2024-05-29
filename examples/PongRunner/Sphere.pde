class Block {
  PVector position;
  PVector dimensions;
  color fillColor;
  boolean visited;

  Block(float x, float y, float z, float w, float h, float d) {
    position = new PVector(x, y, z);
    dimensions = new PVector(w, h, d);
    fillColor = color(random(150, 200));
    visited = false;
  }
  void update() {
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(fillColor, 200);
    box(dimensions.x, dimensions.y, dimensions.z);
    popMatrix();
  }

  void moveDown() {
    position.y += 5;
  }
  void checkCollision(Player player) {
    float playerLeft = player.position.x - player.dimensions.x/2;
    float playerRight = player.position.x + player.dimensions.x/2;
    float playerTop = player.position.y - player.dimensions.y/2;
    float playerBottom = player.position.y + player.dimensions.y/2;
    float playerFront = player.position.z - player.dimensions.z/2;
    float playerBack = player.position.z + player.dimensions.z/2;

    float boxLeft = position.x - dimensions.x/2;
    float boxRight = position.x + dimensions.x/2;
    float boxTop = position.y - dimensions.y/2;
    float boxBottom = position.y + dimensions.y/2;
    float boxFront = position.z - dimensions.z/2;
    float boxBack = position.z + dimensions.z/2;

    if (playerRight > boxLeft && playerLeft < boxRight && playerBottom > boxTop && playerTop < boxBottom && playerBack > boxFront && playerFront < boxBack) {
      // Determine the axis of the smallest overlap
      float xOverlap = min(playerRight - boxLeft, boxRight - playerLeft);
      float yOverlap = min(playerBottom - boxTop, boxBottom - playerTop);
      float zOverlap = min(playerBack - boxFront, boxBack - playerFront);

      // Resolve the collision based on the smallest overlap
      if (xOverlap < yOverlap && xOverlap < zOverlap) {
        if (player.position.x < position.x) {
          player.position.x = boxLeft - player.dimensions.x/2;
        } else {
          player.position.x = boxRight + player.dimensions.x/2;
        }
      } else if (yOverlap < xOverlap && yOverlap < zOverlap) {
        if (player.position.y < position.y) {
          player.position.y = boxTop - player.dimensions.y/2;
          player.velocity.y = 0;
          player.grounded = true;
        } else {
          player.position.y = boxBottom + player.dimensions.y/2;
        }
      } else {
        if (player.position.z < position.z) {
          player.position.z = boxFront - player.dimensions.z/2;
        } else {
          player.position.z = boxBack + player.dimensions.z/2;
        }
      }
    }
  }
}
