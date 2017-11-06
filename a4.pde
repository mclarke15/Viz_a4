import java.util.*;
Bubble_chart bubbleChart;
Bar_chart barChart;
Line_chart lineChart;
String[] lastName;
String[] firstName;
String[] states;
String[] parties;
String[] parties2;
float[] jan;
float[] feb;
float[] mar;
float[] apr;
float[] may;
float[] jun;
float[] jul;
float[] aug;
float[] sep;
boolean[] high; 
String[] lines0;
String[] lines;
String[] headers;
float[] fundStart;
float[] fundEnd;
float[] numCandidates; 
String[] partiesBar = {"Democrat", "Republican", "Other"};
String[] monthNames = {"Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep"};
float[] monthNums = {0, 1, 2, 3, 4, 5, 6, 7};
float[][] CandidateDiffs;
String[][] sts; 
String[][] ptys;
float[] fundBar; 
int numStates = 18;
String currSt;
String matchSt;
float totalFundSt;
float totalFundEnd;
int numCand;
button AR;
button CA;
button FL;
button KY;
button LA;
button MA;
button MD;
button NJ;
button NM;
button NY;
button OH;
button PA;
button SC;
button TX;
button UT;
button VA;
button VT;
button WI;

String stateInd = "all";
String stateHovInd = "all"; 
String partyInd = "all"; 
String partyHovInd = "all"; 
String hoverInd = null; 
String hoverInd2 = null; 

color chartC = color(68, 100, 173);
color hoverC = color(222, 107, 72); 
String[] content;

void setup() {
  size(1000, 600); 
  makeButtons();
}

void draw() {
    readLines();
    stateHovInd = hoverInd; 
    partyHovInd = hoverInd2; 
    //println("hoverind: " + hoverInd);
    //println("stateind: " + stateInd);
    bubbleChart = new Bubble_chart(states, fundStart, fundEnd, numCandidates, 0, 0, width, height/2); 
    bubbleChart.render();
   
    barChart = new Bar_chart("", "", partiesBar, fundBar, 0, height/2, width/2, height/2); 
    barChart.render();
    
    lineChart = new Line_chart(lastName, monthNums, CandidateDiffs, sts, ptys, width/2, height/2, width/2, height/2); 
    lineChart.render();
    
    drawButtons();
}

void mouseClicked() {
  if (mouseButton == LEFT && hoverInd != null) {
     stateInd = hoverInd; 
  }
  if (mouseButton == LEFT && hoverInd2 != null) { 
     partyInd = hoverInd2;
  }
  if (mouseButton == RIGHT) {
     stateInd = "all";  
     partyInd = "all";
  }
  if (mouseButton == LEFT) {
    if (mouseX > AR.X1 && mouseX < AR.X2 && mouseY > AR.Y1 && mouseY < AR.Y2) {
       stateInd = "AR";
       partyInd = "all";
    }  if (mouseX > CA.X1 && mouseX < CA.X2 && mouseY > CA.Y1 && mouseY < CA.Y2) {
       stateInd = "CA";
       partyInd = "all";
    }  if (mouseX > FL.X1 && mouseX < FL.X2 && mouseY > FL.Y1 && mouseY < FL.Y2) {
       stateInd = "FL";
       partyInd = "all";
    }  if (mouseX > KY.X1 && mouseX < KY.X2 && mouseY > KY.Y1 && mouseY < KY.Y2) {
       stateInd = "KY";
       partyInd = "all";
    }  if (mouseX > LA.X1 && mouseX < LA.X2 && mouseY > LA.Y1 && mouseY < LA.Y2) {
       stateInd = "LA";
       partyInd = "all";
    }  if (mouseX > MA.X1 && mouseX < MA.X2 && mouseY > MA.Y1 && mouseY < MA.Y2) {
       stateInd = "MA";
       partyInd = "all";
    }  if (mouseX > MD.X1 && mouseX < MD.X2 && mouseY > MD.Y1 && mouseY < MD.Y2) {
       stateInd = "MD";
       partyInd = "all";
    }  if (mouseX > NJ.X1 && mouseX < NJ.X2 && mouseY > NJ.Y1 && mouseY < NJ.Y2) {
       stateInd = "NJ";
       partyInd = "all";
    }  if (mouseX > NM.X1 && mouseX < NM.X2 && mouseY > NM.Y1 && mouseY < NM.Y2) {
       stateInd = "NM";
       partyInd = "all";
    }  if (mouseX > NY.X1 && mouseX < NY.X2 && mouseY > NY.Y1 && mouseY < NY.Y2) {
       stateInd = "NY";
       partyInd = "all";
    }  if (mouseX > OH.X1 && mouseX < OH.X2 && mouseY > OH.Y1 && mouseY < OH.Y2) {
       stateInd = "OH";
       partyInd = "all";
    }  if (mouseX > PA.X1 && mouseX < PA.X2 && mouseY > PA.Y1 && mouseY < PA.Y2) {
       stateInd = "PA";
       partyInd = "all";
    }  if (mouseX > SC.X1 && mouseX < SC.X2 && mouseY > SC.Y1 && mouseY < SC.Y2) {
       stateInd = "SC";
       partyInd = "all";
    }  if (mouseX > TX.X1 && mouseX < TX.X2 && mouseY > TX.Y1 && mouseY < TX.Y2) {
       stateInd = "TX";
       partyInd = "all";
    }  if (mouseX > UT.X1 && mouseX < UT.X2 && mouseY > UT.Y1 && mouseY < UT.Y2) {
       stateInd = "UT";
       partyInd = "all";
    }  if (mouseX > VA.X1 && mouseX < VA.X2 && mouseY > VA.Y1 && mouseY < VA.Y2) {
       stateInd = "VA";
       partyInd = "all";
    }  if (mouseX > VT.X1 && mouseX < VT.X2 && mouseY > VT.Y1 && mouseY < VT.Y2) {
       stateInd = "VT";
       partyInd = "all";
    }  if (mouseX > WI.X1 && mouseX < WI.X2 && mouseY > WI.Y1 && mouseY < WI.Y2) {
       stateInd = "WI";
       partyInd = "all";
    }
  }
}

String[] filterLines(String ind, String[] linesIn) {
  ArrayList<String> keepLines = new ArrayList<String>();
  String[] content;
  String ret[]; 
  keepLines.add(linesIn[0]);
  if (ind.length() == 2) {
    for(int i = 1; i < linesIn.length; i++){
      content = split(linesIn[i], ",");
      if (content[2].equals(ind)) {
        keepLines.add(linesIn[i]); 
      }
    }
  } else {
    for(int i = 1; i < linesIn.length; i++){
      content = split(linesIn[i], ",");
      if (content[3].equals(ind)) {
        keepLines.add(linesIn[i]); 
      }
    }
  }
  ret = new String[keepLines.size()];
  for (int k = 0; k < keepLines.size(); k++) { 
    ret[k] = keepLines.get(k); 
  }
  return ret; 
}

void readLines() {
  lines0 = loadStrings("data.csv");
  if (stateInd.equals("all") && partyInd.equals("all")) {
        lines = lines0;  
  } else if (stateInd.equals("all") && !partyInd.equals("all")) {
        lines = filterLines(partyInd, lines0);
  } else if (!stateInd.equals("all") && partyInd.equals("all")) {
        lines = filterLines(stateInd, lines0);
  } else {
        lines = filterLines(stateInd, lines0);
        lines = filterLines(partyInd, lines);
  }
  
  headers = split(lines[0],   ",");
  
  lastName = new String[lines.length - 1];
  firstName = new String[lines.length - 1];
  states = new String[lines.length - 1];
  parties = new String[lines.length - 1];
  parties2 = new String[lines.length - 1];
  jan = new float[lines.length - 1];
  feb = new float[lines.length - 1];
  mar = new float[lines.length - 1];
  apr = new float[lines.length - 1];
  may = new float[lines.length - 1];
  jun = new float[lines.length - 1];
  jul = new float[lines.length - 1];
  aug = new float[lines.length - 1];
  sep = new float[lines.length - 1];
  //high = new boolean[lines.length - 1];

  for(int i = 1; i < lines.length; i++){
    content = split(lines[i], ",");
    lastName[i-1] = content[0].replace('"', ' ');
    firstName[i-1] = content[1].replace('"', ' ');
    states[i-1] = content[2];
    parties[i-1] = content[3];
    parties2[i-1] = content[4];
    jan[i-1] = float(content[5]);
    feb[i-1] = float(content[6]);
    mar[i-1] = float(content[7]);
    apr[i-1] = float(content[8]);
    may[i-1] = float(content[9]);
    jun[i-1] = float(content[10]);
    jul[i-1] = float(content[11]);
    aug[i-1] = float(content[12]);
    sep[i-1] = float(content[13]);
    //high[i - 1] = false; 
  }
  
  
  
  fundStart = new float[lastName.length];
  fundEnd = new float[lastName.length];
  numCandidates = new float[lastName.length]; 
 
  for (int i = 0; i < states.length; i++) { 
      totalFundSt = 0;
      totalFundEnd = 0;
      numCand = 0; 
      currSt = states[i];
      for (int k = 0; k < states.length; k++) {
         matchSt = states[k];
         if (currSt.equals(matchSt) == true) {
            totalFundSt += jan[k]; 
            totalFundEnd += sep[k];
            numCand ++; 
         }
      }
      fundStart[i] = totalFundSt;
      fundEnd[i] = totalFundEnd;
      numCandidates[i] = numCand; 
  }
   
  float fundTot; 
  fundBar = new float[3];
  for (int i = 0; i < 3; i++) {
    String currP = partiesBar[i];
    fundTot = 0;
    for (int k = 0; k < sep.length; k++) {
        if (currP.equals(parties[k]) == true) {
          fundTot += sep[k]; 
        }
    }
    fundBar[i] = fundTot; 
  }
  
  CandidateDiffs = new float[8][firstName.length];
  sts = new String[8][firstName.length];
  ptys = new String[8][firstName.length];
  for (int i = 0; i < firstName.length; i++) {
    CandidateDiffs[0][i] = feb[i] - jan[i]; 
    CandidateDiffs[1][i] = mar[i] - feb[i]; 
    CandidateDiffs[2][i] = apr[i] - mar[i]; 
    CandidateDiffs[3][i] = may[i] - apr[i]; 
    CandidateDiffs[4][i] = jun[i] - may[i]; 
    CandidateDiffs[5][i] = jul[i] - jun[i]; 
    CandidateDiffs[6][i] = aug[i] - jul[i]; 
    CandidateDiffs[7][i] = sep[i] - aug[i];
    sts[0][i] = states[i];
    sts[1][i] = states[i];
    sts[2][i] = states[i];
    sts[3][i] = states[i];
    sts[4][i] = states[i];
    sts[5][i] = states[i];
    sts[6][i] = states[i];
    sts[7][i] = states[i];
    ptys[0][i] = parties[i];
    ptys[1][i] = parties[i];
    ptys[2][i] = parties[i];
    ptys[3][i] = parties[i];
    ptys[4][i] = parties[i];
    ptys[5][i] = parties[i];
    ptys[6][i] = parties[i];
    ptys[7][i] = parties[i];
  } 
}

void makeButtons() {
   color buttonColor = color(164, 176, 245);
   AR = new button(buttonColor, "AR", 20, 20, 0, 0, 10);
   CA = new button(buttonColor, "CA", 20, 20, 20, 0, 10);
   FL = new button(buttonColor, "FL", 20, 20, 40, 0, 10);
   KY = new button(buttonColor, "KY", 20, 20, 60, 0, 10);
   LA = new button(buttonColor, "LA", 20, 20, 80, 0, 10);
   MA = new button(buttonColor, "MA", 20, 20, 100, 0, 10);
   MD = new button(buttonColor, "MD", 20, 20, 120, 0, 10);
   NJ = new button(buttonColor, "NJ", 20, 20, 140, 0, 10);
   NM = new button(buttonColor, "NM", 20, 20, 160, 0, 10);
   NY = new button(buttonColor, "NY", 20, 20, 180, 0, 10);
   OH = new button(buttonColor, "OH", 20, 20, 200, 0, 10);
   PA = new button(buttonColor, "PA", 20, 20, 220, 0, 10);
   SC = new button(buttonColor, "SC", 20, 20, 240, 0, 10);
   TX = new button(buttonColor, "TX", 20, 20, 260, 0, 10);
   UT = new button(buttonColor, "UT", 20, 20, 280, 0, 10);
   VA = new button(buttonColor, "VA", 20, 20, 300, 0, 10);
   VT = new button(buttonColor, "VT",20, 20, 320, 0, 10);
   WI = new button(buttonColor, "WI", 20, 20, 340, 0, 10);

}

void drawButtons() {
 AR.drawButton();
 CA.drawButton();
 FL.drawButton();
 KY.drawButton();
 LA.drawButton();
 MA.drawButton();
 MD.drawButton();
 NJ.drawButton();
 NM.drawButton();
 NY.drawButton();
 OH.drawButton();
 PA.drawButton();
 SC.drawButton();
 TX.drawButton();
 UT.drawButton();
 VA.drawButton();
 VT.drawButton();
 WI.drawButton();
}