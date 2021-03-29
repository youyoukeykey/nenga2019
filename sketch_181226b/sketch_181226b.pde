
/* @pjs preload="migime.png,hidari.png,migimayu.png,hidarimayu.png,kuti.png,hana.png,haikei.png,setumei.png,taitoru.png"; */
PImage migime, hidarime, migimayu, hidarimayu, hana, kuti, megane, haikei, taitoru, setumei;
ArrayList buhintati=new ArrayList();
int rx;
int ry;
int bairitu=2;
int seen;//0 taitoru 1 setumei 2 game
int sc;
int hsc=0;
int wc;
void rp() {
  rx=int(random(0, width/bairitu));
  ry=int(random(0, height/bairitu));
}
void setup() {
  size(296, 404);//296,404
  migime=loadImage("migime.png");
  hidarime=loadImage("hidari.png");
  migimayu=loadImage("migimayu.png");
  hidarimayu=loadImage("hidarimayu.png");
  hana=loadImage("hana.png");
  megane=loadImage("megane.png");
  kuti=loadImage("kuti.png");
  haikei=loadImage("ahaikei.png");
  setumei=loadImage("setumei.png");
  taitoru=loadImage("taitoru.png");
  rp();
  buhintati.add(new buhin(rx, ry, 73, 160, kuti));
  rp();
  buhintati.add(new buhin(rx, ry, 73, 120, hana));
  rp();
  buhintati.add(new buhin(rx, ry, 100, 98, migime));
  rp();
  buhintati.add(new buhin(rx, ry, 40, 100, hidarime));
  rp();
  buhintati.add(new buhin(rx, ry, 75, 100, megane));
  rp();
  buhintati.add(new buhin(rx, ry, 40, 75, hidarimayu));
  rp();
  buhintati.add(new buhin(rx, ry, 100, 75, migimayu));
  frameRate(30);
}
void draw() {
  if (seen==0) {
    scale(bairitu);
    background(0);
    image(taitoru, 0, 0);
  }
  if (seen==1) {
    scale(bairitu);
    background(0);
    image(setumei, 0, 0);
  }
  if (seen==2) {
    background(200);
    scale(bairitu);
    image(haikei, 0, 0);
    for (int i=0; i<buhintati.size(); i++) {
      buhin b=(buhin)buhintati.get(i);
      b.byouga();
      b.upde();
    }
  }
  if (seen==3) {
    wc--;
    background(200);
    scale(bairitu);
    image(haikei, 0, 0);
    for (int i=0; i<buhintati.size(); i++) {
      buhin b=(buhin)buhintati.get(i);
      b.byouga();
    }
    fill(0);
    textSize(30);
    text("click to next", 0, 20);
    fill(255);
  }
  if (seen==4) {
    fill(0);
    background(200);
    textSize(30);
    text("score\n"+hsc, 0, 20);
    fill(255);
    if (sc>=hsc) {
      hsc+=17;
    }
  }
  //textSize(30);
  //text(""+mouseX/bairitu+"\n"+mouseY/bairitu, 0, 20);
}
void mousePressed() {
  if (seen==0||seen==1) {
    seen++;
  }
  if (seen==2) {
    for (int i=0; i<buhintati.size(); i++) {
      buhin b=(buhin)buhintati.get(i);
      b.click();
    }
    int j=0;
    for (int k=0; k<buhintati.size(); k++) {
      buhin bu=(buhin)buhintati.get(k);
      if (bu.move) {
        j++;
      }
    }
    if (j==0) {
      seen=3;
      wc=60;
    }
  }
  if (seen==3) {
    println(wc);
    if(wc<0){
    seen++;
    int ss=0;
    for (int k=0; k<buhintati.size(); k++) {
      buhin bu=(buhin)buhintati.get(k);
      ss+=bu.score();
    }
    sc=ss;
    hsc=0;
    }else{
    }
  }
  if (seen==4) {
    if (hsc>=sc) {
      seen=0;
      rp();
      buhintati=new ArrayList();
      buhintati.add(new buhin(rx, ry, 73, 160, kuti));
      rp();
      buhintati.add(new buhin(rx, ry, 73, 120, hana));
      rp();
      buhintati.add(new buhin(rx, ry, 100, 98, migime));
      rp();
      buhintati.add(new buhin(rx, ry, 40, 100, hidarime));
      rp();
      buhintati.add(new buhin(rx, ry, 75, 100, megane));
      rp();
      buhintati.add(new buhin(rx, ry, 40, 75, hidarimayu));
      rp();
      buhintati.add(new buhin(rx, ry, 100, 75, migimayu));
    }
  }
}
void ri( int x, int y, PImage img, float k ) { 
  pushMatrix(); 
  translate( x, y); 
  rotate(radians( k )); 
  imageMode(CENTER); 
  image( img, 0, 0 ); 
  imageMode(CORNER); 
  popMatrix();
}
class buhin {
  int x, y;
  int motox, motoy;
  int mf;
  PImage g;
  int kakudo;
  int mukif, basyof;
  int mx, my;
  boolean move;
  buhin(int x, int y, PImage i) {
    this.x=x;
    this.y=y;
    this.motox=x;
    this.motoy=y;
    this.g=i;
    move=true;
  }
  buhin(int x, int y, int mx, int my, PImage i) {
    this.x=x;
    this.y=y;
    this.motox=mx;
    this.motoy=my;
    this.g=i;
    move=true;
  }
  void byouga() {
    ri(x, y, g, kakudo);
    if (move) {
      ellipse(x, y, 20, 20);
    }
  }
  void upde() {
    if (move) {
      if (basyof>0) {
        x+=mx;
        y+=my;
        if (x>width/bairitu) {
          mx=-mx;
        }
        if (y>height/bairitu) {
          my=-my;
        }
        if (y<0) {
          my=-my;
        }
        if (x<0) {
          x=mx=-mx;
        }
        basyof--;
      } else {
        basyof=int(random(100, 1000));
        mx=int(random(-5, 5));
        my=int(random(-5, 5));
        if (mx==0) {
          mx++;
        }
        if (my==0) {
          my++;
        }
      }
      if (mukif!=0) {
        if (mukif>0) {
          kakudo++;
          mukif--;
        } else {
          kakudo--;
          mukif++;
        }
      } else {
        mukif=int(random(-100, 100));
      }
    }
  }
  void click() {
    if (dist(x, y, mouseX/bairitu, mouseY/bairitu)<10) {
      move=false;
    }
  }
  int score() {
    return abs(100/motox-x);
  }
}