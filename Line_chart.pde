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
        yVals[k + i * k ] = values[k][i]; 
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
    xmax = max(names);
    //ymax = log(max(values));
    ymax = max(yVals); 
    //println(yVals);
    xmin = min(names);
  
   // if (min(values) == 0) {
   //  ymin = 0; 
   // } else {
     //ymin = log(min(values));
    ymin = min(yVals);
   // println("ymin " + ymin + " ymax " + ymax); 
   // }
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
        
        //if (d.yValue == 0) {
        //  ly = 0;
        //} else {
        //   ly = log(d.yValue); 
        ly = d.yValue; 
        ly2 = d2.yValue;
        //}
        //println("ly: " + ly+ " ly2: " + ly2); 
        //println("ymin: " + ymin + " ymax: " + ymax);
        float x = (lx - xmin) / (xmax - xmin) * (xEnd - xStart) + xStart; 
        float y = (ly - ymin) / (ymax - ymin) * (yEnd - yStart) + yStart; 
        float x2 = (lx2 - xmin) / (xmax - xmin) * (xEnd - xStart) + xStart; 
        float y2 = (ly2 - ymin) / (ymax - ymin) * (yEnd - yStart) + yStart; 
        //println("y: " + y + " y2: " + y2); 
        if (mouseX >= x - d.radius && mouseX <= x + d.radius 
                        && mouseY >= y - d.radius && mouseY <= y + d.radius) {
            if (i != 7) {
              line(x, y, x2, y2);
            }
            fill(hoverC);
            ellipse(x, y, d.radius*2, d.radius*2); 
            hoverInd = d.st; 
           // fill(255);
           // textAlign(CENTER, CENTER);
           // textSize(10);
           // text(d.name, x, y);
            fill(color(0, 0, 0));
          /*  if (d.xValue == 0) {
              lx = 0;
            } else {
              lx = log(d.xValue); 
            }
            if (d.yValue == 0) {
              ly = 0;
            } else {
              ly = log(d.yValue); 
            }
            */
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
           // fill(255);
           // textAlign(CENTER, CENTER);
           // textSize(10);
            //text(d.name, x, y);
          }
      }
      if (t != null) {
        t.render();
      }
      
      int NUMTICKS = 10;
      float yInterval = (ymax - ymin) / NUMTICKS;
      float ySpacing = (yEnd - yStart)/NUMTICKS;
      //float ySpacing = (chartHeight - 2*padding*chartHeight) / (log(ymax) - ymin);
      //println("ySpacing: " + ySpacing);
      //println("yEnd: " + yEnd + " yStart: " + yStart);
      //println("yInterval: " + yInterval);
      //println("ymax: " + ymax + " ymin: " + ymin); 
      for (float i = ymin; i <= ymax; i+=yInterval) {
        pushStyle(); 
        textAlign(RIGHT); 
        fill(0); 
        //println("xStart " + xStart + " yStart " + yStart + " y "+ (yStart - i*ySpacing));
       // println(i);
       // text(i + " ", xStart, yStart + i*ySpacing);
        popStyle(); 
      } 
    } 
  }
}