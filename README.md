# Klothoid
## Rekursives Iterieren mit OpenSCAD
### Problematik
Ein Projekt mit OpenSCAD, das ein Module nach einem 
iterativem Muster aneinanderreiht. Also der Wert eines for() Durchlaufs 
hängt vom letzten Durchlauf ab. Aber das funktioniert so nicht in 
OpenSCAD:
```
"for() is not an exception to the rule about variables having only one 
value within a scope. Each evaluation is given its own scope, allowing 
any variables to have unique values. No, you still can't do a=a+1;
```
```
Remember this is not an iterative language, the for() does not loop in 
the programmatic sense, it builds a tree of objects one branch for each 
item in the range/vector, inside each branch the 'variable' is a 
specific and separate instantiation or scope."
```
### Lösung
Rekursives Iterieren:
```
module iterieren(i, x1, y1, sw) {
  if (i < 56) {
    i  = i + 1;
    x2 = pow(i,3)/12100;    //X_neu
    w  = asin((x2-x1)/sw);  //Winkel
    y2 = cos(w)*sw+y1;      //Y_neu
    if ((i+2)%4==0) {       //nur #2,6,10,14...
      echo(i);
      swnr = abs((i+2)/4);  //Schwellen nummerieren 1,2,3,4...
      schwelle(x2,y2,-w,0,0,swnr);
    }
    iterieren(i, x2, y2, sw);
  }
}
iterieren(0, 0, 0, sw);
```
