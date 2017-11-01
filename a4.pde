Bubble_chart bubbleChart;
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
String[] lines;
String[] headers;
float[] fundStart;
float[] fundEnd;
float[] numCandidates; 
int numStates = 18;
String currSt;
String matchSt;
float totalFundSt;
float totalFundEnd;
int numCand;

color chartC = color(68, 100, 173);
color hoverC = color(222, 107, 72);

void setup() {
  size(800, 600); 
  lines = loadStrings("data.csv");
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
    
  for(int i = 1; i < lines.length; i++){
    String[] content = split(lines[i], ",");
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
  }
 // println(lastName); 
 // println(firstName); 
 // println(states);
 // println(parties);
 // println(parties2);
 // println(jan); 
 // println(sep);
  
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
        // println("current ", currSt, " Match: ", matchSt);
         if (currSt.equals(matchSt) == true) {
          // println("MATCHED############################################");
            totalFundSt += jan[k]; 
            totalFundEnd += sep[k];
            numCand ++; 
         }
      }
     // println(currSt, totalFundSt, totalFundEnd); 
      fundStart[i] = totalFundSt;
      fundEnd[i] = totalFundEnd;
      numCandidates[i] = numCand; 
  }
  
}

void draw() {
    bubbleChart = new Bubble_chart(states, fundStart, fundEnd, numCandidates, 0, 0, width, height); 
    bubbleChart.render();
}