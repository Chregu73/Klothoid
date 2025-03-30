// Uebergangsradius von Gerade auf 579.3mm Radius Standardgleis
// Länge Mittellinie 224mm, muss aber 223

zahnstange=false;
//zahnstange=true;
// kurve=1  gibt Rechtskurve
// kurve=-1 gibt Linkskurve
kurve=-1;

farbe=1;
// farbe=0 gibt ganzer Rost
// farbe=1 gibt Schwellen
// farbe=2 gibt Schienenstühle

schwelle_aussen_points = [
[ -22, -3.5, 0 ], //0
[ 22, -3.5, 0 ], //1
[ 22, 3.5, 0 ], //2
[ -22, 3.5, 0 ], //3
[ -21.5, -3, 5 ], //4
[ 21.5, -3, 5 ], //5
[ 21.5, 3, 5 ], //6
[ -21.5, 3, 5 ]]; //7

schwelle_faces = [
[0,1,2,3],  // bottom
[4,5,1,0],  // front
[7,6,5,4],  // top
[5,6,2,1],  // right
[6,7,3,2],  // back
[7,4,0,3]]; // left

schwelle_innen_points = [
[ -20.5, -2, -.001 ], //0
[ 20.5, -2, -.001 ], //1
[ 20.5, 2, -.001 ], //2
[ -20.5, 2, -.001 ], //3
[ -20, -1.5, 4 ], //4
[ 20, -1.5, 4 ], //5
[ 20, 1.5, 4 ], //6
[ -20, 1.5, 4 ]]; //7

// rechte Seite (x+, kürzere Schiene bei Rechtskurve)
module stuhl1(schwellennummer){
  //Schwellenverbindung
  if (schwellennummer==1) {
    translate([12.5,4.2,3])
    cube([2,8.4,6],true);
  }
  else if (schwellennummer==14) {
    translate([12.5,-4.2,3])
    cube([2,8.4,6],true);
  }
  else {
    translate([12.5,0,3])
    //rotate(a=[0,0,angle])
    cube([2,16.7,6],true);
  }
  //Schienenstuhl nieder
  translate([12.5,0,5.5])
  //rotate(a=[0,0,angle])
  cube([9,4.5,1],true);
  //Schienenstuhl hoch
  translate([12.5,0,6.7])
  //rotate(a=[0,0,angle])
  cube([8,3,2.7],true);
  //Schrauben
  /*
  translate([15,0,8.35])
  cylinder(r=.4,h=.5,$fn=8,center=true);
  translate([10,0,8.35])
  cylinder(r=.4,h=.5,$fn=8,center=true);
  */  
}
// linke Seite (x-, längere Schiene bei Rechtskurve)
module stuhl2(schwellennummer){
  //Schwellenverbindung
  if (schwellennummer==1) {
    translate([-12.5,4.2,3])
    cube([2,8.4,6],true);
  }
  else if (schwellennummer==14) {
    translate([-12.5,-4.2,3])
    cube([2,8.4,6],true);
  }
  else {
    translate([-12.5,0,3])
    //rotate(a=[0,0,angle])
    cube([2,16.7,6],true);
  }
  //Schienenstuhl nieder
  translate([-12.5,0,5.5])
  //rotate(a=[0,0,angle])
  cube([9,4.5,1],true);
  //Schienenstuhl hoch
  translate([-12.5,0,6.7])
  //rotate(a=[0,0,angle])
  cube([8,3,2.7],true);
  //Schrauben
  /*
  translate([-15,0,8.35])
  cylinder(r=.4,h=.5,$fn=8,center=true);
  translate([-10,0,8.35])
  cylinder(r=.4,h=.5,$fn=8,center=true);
  */
}

module schwelle(x,y,angle,a1,a2,i){
  translate([x,y, 0])
  rotate(a=[0,0,angle])
  union() {
    difference() {
      union(){
        //Schwelle
        translate([0,0,0])
        color("Sienna")
        polyhedron(schwelle_aussen_points, schwelle_faces);
    
        if (a1!=undef) {
          stuhl1(i);
        }
        if (a2!=undef) {
          stuhl2(i);
        }

        if (zahnstange==true) {
          //Stuhl Zahnstange
          translate([0,0,4])
          color("Turquoise")
          minkowski()
          {
            cube([9,4,2], center=true);
            cylinder(r=.6,h=2);
          }
        }
      }
  
      // Hohle Schwelle:
      //translate([-20,-2,-1])
      //cube([40,4,5]);
      polyhedron(schwelle_innen_points, schwelle_faces);
  
      if (i==1) {
        translate([10.5,-2.3,-1])
        cube([4,0.8,8]);
        translate([10.5,-9.5,5.0])
        cube([4,8,1.1]);
        translate([-14.5,-9.5,5.0])
        cube([4,8,1.1]);
      }
      if (i==14) {
        translate([-14.5,1.5,-1])
        cube([4,0.8,8]);
        translate([10.5,1.5,5.0])
        cube([4,8,1.1]);
        translate([-14.5,1.5,5.0])
        cube([4,8,1.1]);
      }

      //Schienendurchstoss
      schienenquerschnitt=[[-0.2,0],      // Punkt 1
                           [ 3.2,0],      // Punkt 2
                           [ 3.2,1.2],    // Punkt 3
                           [ 2.2,1.5],    // Punkt 4
                           [ 2.2,3],      // Punkt 5
                           [ 2.4,3],      // Punkt 6
                           [ 2.4,4],      // Punkt 7
                           [ 0.6,4],      // Punkt 8
                           [ 0.6,3],      // Punkt 9
                           [ 0.8,3],      // Punkt 10
                           [ 0.8,1.5],    // Punkt 11
                           [-0.2,1.2]];   // Punkt 12
      #translate([11,8,6])
      rotate([90,0,0])
      linear_extrude(height = 16.5, $fn=400, convexity=2)
      polygon(schienenquerschnitt);
    
      #translate([-14,8,6])
      rotate([90,0,0])
      linear_extrude(height = 16.5, $fn=400, convexity=2)
      polygon(schienenquerschnitt);



    }
    
    //Quader und Schlitz für Schienenlasche
    //Am Anfang (1. Schwelle, rechts)
    if (i==1) {
      difference() {
      translate([9.5,-3.5,0])
      cube([6,3,5]);
      translate([10.5,-2.3,-1])
      cube([4,0.8,8]);
      }
      // Schrift:
      difference(){
        // Quader
        translate([-2,0,.25])
        cube([23,5,.5],center=true);
        // Text:
        translate([-2,0,.7])
        rotate(a=[0,180,180])
        linear_extrude(height = 1)
        text("U0-580",
        size = 4,
        font = "Arial:style=Black",
        halign = "center",
        valign = "center",
        $fn = 40);
      }
    }
    //Am Ende (14. Schwelle, links)
    if (i==14) {
      difference() {
      translate([-15.5,0.5,0])
      cube([6,3,5]);
      translate([-14.5,1.5,-1])
      cube([4,0.8,8]);
      }
    }
    

  }
}



module zahn(x, y, w){
  color("Turquoise")
  translate([x,y-2,0])
  rotate([90,0,w+90])
  linear_extrude(height = 3, center = true, convexity = 10, twist = 0)
  translate([-2,0,0])
  polygon(points=[[0,0],[0,10.5],[0.75,10.5],[1.5,13],[2.5,13],[3.25,10.5],[4,10.5],[4,0]]);
}

//Schrittweite (Zahnlänge)
//sw = 3.9285714285714286; //Vorher, Rost zu kurz
sw = 4.025;


/* So gehts nicht!
X_alt = 0;
Y_alt = 0;
Winkel = 0;

for (i = [1:1:56]) {
  X_neu = pow(i,3)/12100;
  Winkel = asin((X_neu-X_alt)/sw);
  Y_neu = cos((Winkel*sw)+Y_alt);
  //Zeichnen:
  if ((i+2)%2==0) {
    swnr = abs((i+2)/4);
    schwelle(X_neu,Y_neu,-Winkel,0,0,swnr);
  }
}
*/


module iterieren(i, x1, y1, sw) {
  if (i < 56) {
    i  = i + 1;
    x2 = pow(i,3)/12100;    //X_neu
    w  = asin((x2-x1)/sw);  //Winkel
    y2 = cos(w)*sw+y1;      //Y_neu
    if ((i+2)%4==0) {       //nur #2,6,10,14...
      //Schwellen nummerieren 1,2,3,4...14
      swnr = abs((i+2)/4);  
      schwelle(x2*kurve,y2,-w*kurve,0,0,swnr);
    }
    echo(w);
    if (zahnstange==true) {
      zahn(x2*kurve, y2, -w*kurve);
    }
    iterieren(i, x2, y2, sw);
  }
}

difference() {
  iterieren(0, 0, 0, sw);
  if (farbe==2) {
    translate([0,120,0])
    cylinder(10, r=125, center=true);
  } else if (farbe==1) {
    translate([0,120,10])
    cylinder(10, r=125, center=true);
  }
}


