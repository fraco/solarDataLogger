// ITP entrance dataLogger 01
// 4/5/15 by Fraco and Yifan

import processing.serial.*; 
Serial myPort;             

int senEl1;
boolean stateEl1;
int valEl1;

int senEl2;
boolean stateEl2;
int valEl2;

int valEls;

int senSt;
boolean stateSt;
int valSt;

PFont font;
Table table;


void setup() {
  size(displayWidth, displayHeight);

  // serial port
  println(Serial.list());
  String portName = Serial.list()[5];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil('\n');

  // table
  loadData();

  font = createFont("GillSans-Light-48.vlw", 24);
  textFont(font);
}

void draw() {
  background(56);  

  counterEnt();
  displayCount();
}

void loadData() {
  // Load CSV file into a Table object
  // "header" option indicates the file has a header row
  table = loadTable("data.csv", "header");

  // You can access iterate over all the rows in a table
  int rowCount = 0;
  for (TableRow row : table.rows ()) {
    // You can access the fields via their column name (or index)
    //int elev1;
    int elev1 = row.getInt("senE1");
    if (elev1 != 0 || elev1 != 1) {
      elev1 = 0;
    }
    int elev2 = row.getInt("senE2");
    if (elev2 != 0 || elev2 != 1) {
      elev2 = 0;
    }
    int elevs = row.getInt("senTE");
    if (elevs != 0 || elevs != 1) {
      elevs = 0;
    }
    int stai = row.getInt("senS");
    if (stai != 0 || stai != 1) {
      stai = 0;
    }
    //pass the stored values to global variables
    valEl1 = elev1;
    valEl2 = elev2;
    valEls = elevs;
    valSt = stai;
    rowCount++;
  }
}

void serialEvent(Serial myPort) {
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    myString = trim(myString);
    int hall[] = int(split(myString, ','));

    for (int hallNum = 0; hallNum < hall.length; hallNum++) {
      print("Hall" + hallNum + ": " + hall[hallNum] + " \t");
    }    
    if (hall.length > 1) {
      senEl1 = hall[0];
      senEl2 = hall[1];
      senSt = hall[2];
    }      
    println();
  }
}

void displayCount() {
  noStroke();
  fill(222, 0, 22, 222);
  ellipse(width/3, height/2.5, 222, 222);  
  fill(222, 222, 0, 222);
  ellipse(width/1.5, height/2.5, 222, 222);

  fill(255);
  textAlign(CENTER);
  textSize(47);
  text(nf(valEls, 3, 0), width/3, height/2.3);  
  text(nf(valSt, 3, 0), width/1.5, height/2.3);

  textSize(29);
  text("Elevator", width/3, height/2.7);
  text("Stairs", width/1.5, height/2.7);
}

void counterEnt() {
  //if elevator sensor activates and
  // elevator state is deactivated
  if (senEl1 == 1 && stateEl1==false) {
    //activate elevator state
    stateEl1 = true;
    //add row to data logger
    TableRow row = table.addRow();
    //add value to elevator1
    row.setInt("senE1", valEl1+senEl1);
    //valEl1+= senEl1;
    //add total elevators value
    row.setInt("senTE", valEl1+valEl2);
    //leave elevator2 values alone
    row.setInt("senE2", valEl2);
    //leave stair values alone
    row.setInt("senS", valSt);
    // Writing the CSV back to the same file
    saveTable(table, "data/data.csv");
    // And reloading it
    loadData();
  } else if (senEl1 == 0) {
    stateEl1 = false;
  }

  //elevator 2
  if (senEl2 == 1 && stateEl2==false) {    
    stateEl2 = true;    
    TableRow row = table.addRow();    
    row.setInt("senE2", valEl2+senEl2);    
    row.setInt("senTE", valEl2+valEl1);    
    row.setInt("senE1", valEl1);    
    row.setInt("senS", valSt);    
    saveTable(table, "data/data.csv");    
    loadData();
  } else if (senEl2 == 0) {
    stateEl2 = false;
  }

  if (senSt == 1 && stateSt==false) {
    stateSt = true; 
    TableRow row = table.addRow();
    row.setInt("senE1", valEl1);
    row.setInt("senE2", valEl2);
    row.setInt("senTE", valEls);
    row.setInt("senS", valSt+senSt);    
    saveTable(table, "data/data.csv");    
    loadData();
  } else if (senSt == 0) {
    stateSt = false;
  }
}
