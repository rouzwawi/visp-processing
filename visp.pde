import java.util.List;


Quad quad;
Quad hoverQuad;

void setup() {
  size(1600, 1600);
  quad = new Quad();
  quad.initAll(6);
}

void draw() {
  background(0);
  stroke(255, 50);
  quad.drawGrid();
  fill(0, 200, 130);
  if (hoverQuad != null) hoverQuad.drawBox();
}

void mouseMoved() {
//  fill(0, 180, 255, 15);
  noFill();
  stroke(0, 130, 200);
  hoverQuad = quad.find(mouseX, mouseY);
}
