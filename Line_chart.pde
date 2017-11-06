class Line_chart {
  ArrayList<DataPair> dataPairs;
  ArrayList<ArrayList> CandidatesPairs;
  float defaultRadius = 10; 
  float xPosChart;
  float yPosChart;
  float chartWidth;
  float chartHeight;
  float xmax;
  float ymax;
  float xmin;
  float ymin;
  float[] yVals;
  
  Line_chart(String[] titles, float[] names, float[][] values, String[][] st, String[][] pt, float _xPosChart, float _yPosChart, float _chartWidth, float _chartHeight) {
    CandidatesPairs = new ArrayList<ArrayList>();
    yVals = new float[titles.length * 8]; 
    for (int i = 0; i < titles.length; i++) {
      dataPairs = new ArrayList<DataPair>();
      for (int k = 0; k < 8; k++) {
        DataPair d = new DataPair(titles[i], names[k], values[k][i], defaultRadius/2, st[k][i], pt[k][i]);
        yVals[i*8 + k] = values[k][i]; 
        if (dataPairs.contains(d) == false) {
           dataPairs.add(d); 
        }
      }
      CandidatesPairs.add(dataPairs);
    }
    xPosChart = _xPosChart;
    yPosChart = _yPosChart;
    chartWidth = _chartWidth;
    chartHeight = _chartHeight;
    
    //set max 
    xmax = max(names); 
    ymax = max(yVals); 
    //set min
    xmin = min(names);
    ymin = min(yVals); 
    //check max and min 
    if (xmin == xmax) {
       if (xmax == 0) {
         xmax = 100; 
       } else {
         xmin = 0;  
       }
    }
    if (ymin == ymax) {
      if (ymax == 0) {
        ymax = 100;  
      } else {
        ymin = 0;  
      }
    }

  }
  
  void render() {
    ToolTip t = null;
    float padding = 0.15;
    float xStart = padding * chartWidth + xPosChart;
    float yStart = (1 - padding) * chartHeight + yPosChart;
    float xEnd = (1 - padding) * chartWidth + xPosChart; 
    float yEnd = padding * chartHeight + yPosChart;
    fill(255);
    rect(xPosChart, yPosChart, chartWidth, chartHeight);
    fill(0);
    line(xStart, yStart, xStart, yEnd);
    line(xStart, yStart, xEnd, yStart);
    
    int NUMTICKS = 10;
    float yInterval = (ymax - ymin) / NUMTICKS;
    float ySpacing = (yStart - yEnd)/NUMTICKS;
    int count = 0;
    for (float i = ymin; i <= ymax; i+=yInterval) {
      pushStyle(); 
      textAlign(RIGHT); 
      fill(0); 
      text(String.format("%.02f", i / 1000000) + "   ", xStart, yStart - count*ySpacing);
      popStyle(); 
      count++; 
    }
    pushMatrix();
    translate(xStart - 50, yEnd + 100); //change origin 
    rotate(PI/2); //rotate around new origin 
    fill(0);
    text("Difference in Funding ($)", 0, 0);
    popMatrix();
    
    for (int j = 0; j < CandidatesPairs.size(); j ++) {
      ArrayList<DataPair> cand = CandidatesPairs.get(j);  
      for (int i = 0; i < dataPairs.size(); i++) {
        DataPair d = cand.get(i);
        DataPair d2 = cand.get(i);
        if ( i != 7 ) {
          d2 = cand.get(i + 1); 
        }
        float lx, ly; 
        float lx2, ly2; 
        lx = d.xValue;
        lx2 = d2.xValue;
        ly = d.yValue; 
        ly2 = d2.yValue;

        float x = (lx - xmin) / (xmax - xmin) * (xEnd - xStart) + xStart; 
        float y = (ly - ymin) / (ymax - ymin) * (yEnd - yStart) + yStart; 
        float x2 = (lx2 - xmin) / (xmax - xmin) * (xEnd - xStart) + xStart; 
        float y2 = (ly2 - ymin) / (ymax - ymin) * (yEnd - yStart) + yStart; 
        
        if (j == 0) {
          pushMatrix();
          translate(x, yStart); //change origin 
          rotate(PI/2); //rotate around new origin 
          fill(0);
          text(monthNames[int(d.xValue)], 30, 8); //put text at new origin 
          popMatrix();
        }

        if (mouseX >= x - d.radius && mouseX <= x + d.radius 
                        && mouseY >= y - d.radius && mouseY <= y + d.radius) {
            if (i != 7) {
              line(x, y, x2, y2);
            }
            fill(hoverC);
            ellipse(x, y, d.radius*2, d.radius*2); 
            hoverInd = d.st; 
            t = new ToolTip(d.name + " (" + monthNames[int(d.xValue)] + ", " + d.yValue + ")", mouseX, mouseY);
          } else {
            if (i != 7) {
              line(x, y, x2, y2);
            }
            if (stateHovInd != null) {
              if (stateHovInd.equals(d.st)) {
               fill(hoverC); 
              } else {
               fill(chartC);  
              }
            } else if (partyHovInd != null) {
              if (partyHovInd.equals(d.pty)) {
               fill(hoverC); 
              } else {
               fill(chartC);  
              }
            } else {
              fill(chartC); 
            }
            ellipse(x, y, d.radius*2, d.radius*2);
          }
      }
      if (t != null) {
        t.render();
      }
    } 

  } 
}