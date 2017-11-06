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