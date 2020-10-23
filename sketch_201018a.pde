import processing.svg.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;

boolean bExportSVG = false;
int nbPoints = 10;
float nbForms = 25;
float radiusMin = 10;
float radiusMax = 200;
float nbWaves = 5;
float angleRotation = 0.22;



void nbPointsSlider(int val){
  nbPoints = val;
}

void controlEvent(ControlEvent theControlEvent){
    if(theControlEvent.isFrom("radius")) 
  {
    radiusMin = int(theControlEvent.getController().getArrayValue(0));
    radiusMax = int(theControlEvent.getController().getArrayValue(1));
  }
}

void initControls(){
  
  cp5
  .addSlider("nbPoints")
  .setSize(10,150).setPosition(700,600)
  .setLabel("nb points")
  .setRange(3,10).setNumberOfTickMarks(10-3)
  .setValue(nbPoints)
  .setColorLabel(0);
  
  cp5.addRange("radius")
  .setSize(400,20)
  .setPosition(200,750)
  .setLabel("radius range")
  .setColorLabel(0)
  .setRange(0,315)
  .setValue(200)
  .setRangeValues(radiusMin,radiusMax);
}



void setup(){
  size(800, 800);
  cp5 = new ControlP5(this);
  initControls();
}


void draw(){
  background(255);
  
  
  if (bExportSVG){
    beginRecord(SVG, "data/exports/svg/export_"+timestamp()+".svg");
  }
  
  pushMatrix();
  translate(width/2, height/2);
  
  for (int n=0; n<nbForms; n++)
  {
    pushMatrix();
    
    rotate( map( sin(nbWaves*n/(nbForms-1)*TWO_PI), -1, 1, -angleRotation, angleRotation) );
    circle(nbPoints, map(n,0,nbForms-1,radiusMax, radiusMin));
    
    popMatrix();
  }

  noFill();
  stroke(0);
  
  popMatrix();

  if (bExportSVG)
  {
    endRecord();
    bExportSVG = false;
  }
}

void keyPressed()
{
  if (key == 'e')
  {
    bExportSVG = true;
  }
}

String timestamp() 
{
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}

void circle(int nbPoints, float radius)
{
  beginShape();
  for (int i=0; i<nbPoints; i++)
  {
    float angle = -PI/2+float(i)*TWO_PI/float(nbPoints);
    vertex( radius*cos(angle), radius*sin(angle));
  }
  endShape(CLOSE);
}
