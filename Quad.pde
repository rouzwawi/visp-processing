import java.util.List;

class Quad {
  volatile boolean inited = false;

  final Quad[] qs = new Quad[4];
  final List<Object> elements = new ArrayList<Object>();

  final int xmin, xmax, ymin, ymax;
  final int xmid, ymid;

  Quad() {
    this(0, width, 0, height);
  }

  Quad(int xmin, int xmax, int ymin, int ymax) {
    this.xmin = xmin;
    this.xmax = xmax;
    this.ymin = ymin;
    this.ymax = ymax;
    this.xmid = (xmax-xmin)/2;
    this.ymid = (ymax-ymin)/2;
  }

  void initAll() {
    initAll(1);
  }

  void initAll(int recurse) {
    if (recurse == 0) return;
    for (int i = 0; i < 4; i++) {
      init(i);
      qs[i].initAll(recurse - 1);
    }
    inited = true;
  }

  void init(int q) {
    assert(q >= 0 && q < 4);
    switch (q) {
      case 0:
        qs[0] = new Quad(xmin, xmax-xmid, ymin, ymax-ymid);
        break;
      case 1:
        qs[1] = new Quad(xmin+xmid, xmax, ymin, ymax-ymid);
        break;
      case 2:
        qs[2] = new Quad(xmin, xmax-xmid, ymin+ymid, ymax);
        break;
      case 3:
        qs[3] = new Quad(xmin+xmid, xmax, ymin+ymid, ymax);
        break;
    }
  }

  Quad find(int x, int y) {
    int q = quadrant(x, y);
    rect(xmin, ymin, xmid*2, ymid*2);
    return qs[q] != null ? qs[q].find(x, y) : this;
  }

  int quadrant(int x, int y) {
    boolean xless = x < xmin+xmid,
            yless = y < ymin+ymid;

    if      ( xless &&  yless) return 0;
    else if (!xless &&  yless) return 1;
    else if ( xless && !yless) return 2;
    else                       return 3;
  }

  void drawGrid() {
    for (Quad q : qs) {
      if (q != null) q.drawGrid();
    }
    if (inited) {
      line(xmin+xmid, ymin, xmin+xmid, ymax);
      line(xmin, ymin+ymid, xmax, ymin+ymid);
    }
  }

  void drawBox() {
    for (Quad q : qs) {
      if (q != null) q.drawBox();
    }
    rect(xmin, ymin, xmid*2, ymid*2);
  }  
}
