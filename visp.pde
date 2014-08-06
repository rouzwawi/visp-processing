import java.util.List;

Quad quad;
Quad hoverQuad;

void setup() {
  size(800, 800);
  colorMode(HSB, 255);
  quad = new Quad();
  quad.initAll(7);
}

void draw() {
  background(0);

  stroke(0, 0, 50);
  quad.drawGrid();

  noFill();
  stroke(150, 180, 255);
  hoverQuad = quad.find(mouseX, mouseY);

  fill(0, 0, 200);
  if (hoverQuad != null) hoverQuad.drawBox();
}

void mouseMoved() {
}
