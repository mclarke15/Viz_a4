class Bubble_chart {
  ArrayList<DataPair> dataPairs;
  float defaultRadius = 20; 
  float xPosChart;
  float yPosChart;
  float chartWidth;
  float chartHeight;
  float xmax;
  float ymax;
  float xmin;
  float ymin;
  
  Bubble_chart(String[] titles, float[] names, float[] values, float[] bubSize, float _xPosChart, float _yPosChart, float _chartWidth, float _chartHeight) { 
    dataPairs = new ArrayList<DataPair>();
    for (int i = 0; i < names.length; i++) { 
        DataPair d = new DataPair(titles[i], names[i], values[i], bubSize[i] * defaultRadius/2, "", "");
        if (dataPairs.contains(d) == false) {
           dataPairs.add(d); 
        }
    }
    xPosChart = _xPosChart;
    yPosChart = _yPosChart;
    chartWidth = _chartWidth;
    chartHeight = _chartHeight;
    
    //set max
    if (max(names) == 0) {
       xmax = 0;  
    } else {
       xmax = log(max(names)); 
    } 
    if (max(values) == 0) {
       ymax = 0;  
    } else {
       ymax = log(max(values)); 
    }
    //set min
    if (min(names) == 0) {
     xmin = 0; 
    } else {
     xmin = log(min(names));
    } 
    if (min(values) == 0) {
     ymin = 0; 
    } else {
     ymin = log(min(values));
    }
    //check max and min    
    if (xmin == xmax) {
       if (xmax == 0) {
         xmax = 10; 
       } else {
         xmin = 0;  
       }
    }
    if (ymin == ymax) {
      if (ymax == 0) {
        ymax = 10;  
      } else {
        ymin = 0;  
      }
    }
  }
  
  void render() {
    ToolTip t = null;
    String hov = null; 
    float padding = 0.15;
    float xStart = padding * chartWidth;
    float yStart = (1 - padding) * chartHeight;
    float xEnd = (1 - padding) * chartWidth; 
    float yEnd = padding * chartHeight;
    fill(255);
    rect(xPosChart, yPosChart, chartWidth, chartHeight);
    fill(0);
    line(xStart, yStart, xStart, yEnd);
    line(xStart, yStart, xEnd, yStart);
    
    int NUMTICKS = 10;
    float yInterval = (ymax - ymin) / NUMTICKS;
    float ySpacing = (yStart - yEnd)/NUMTICKS;
    int count = 0;
    for (float i = ymin; i <= ymax + yInterval; i+=yInterval) {
      pushStyle(); 
      textAlign(RIGHT); 
      fill(0); 
      text(String.format("%.02f", i) + "   ", xStart, yStart - count*ySpacing);
      popStyle(); 
      count++; 
    } 
    pushMatrix();
    translate(xStart, (yStart - yEnd) / 2); //change origin 
    rotate(PI/2); //rotate around new origin 
    fill(0);
    text("End Funding (Log($Sep))", xStart*0.5, (yStart - yEnd)/4);
    popMatrix();

    
    for (int i = 0; i < dataPairs.size(); i++) {
      DataPair d = dataPairs.get(i);
      float lx, ly; 
      if (d.xValue == 0) {
        lx = 0;
      } else {
         lx = log(d.xValue); 
      }
      if (d.yValue == 0) {
        ly = 0;
      } else {
         ly = log(d.yValue); 
      }
      float x = (lx - xmin) / (xmax - xmin) * (xEnd - xStart) + xStart; 
      float y = (ly - ymin) / (ymax - ymin) * (yEnd - yStart) + yStart; 
      
      float xInterval = (xmax - xmin) / NUMTICKS;
      float xSpacing = (xEnd - xStart)/NUMTICKS;
      int countx = 0;
      
      if (i == 0) {
        for (float j = xmin; j <= xmax; j+=xInterval) {
          pushStyle(); 
          textAlign(CENTER, TOP); 
          fill(0); 
          text(String.format("%.02f", j) + "   ", xStart + countx*xSpacing, yStart + defaultRadius/2);
          popStyle(); 
          countx++; 
        } 
        text("Start Funding (Log($Feb))", (xEnd - xStart)/1.5, yStart + 1.5*defaultRadius);
      }
       
      if (mouseX >= x - d.radius && mouseX <= x + d.radius 
                      && mouseY >= y - d.radius && mouseY <= y + d.radius) {
          fill(hoverC);
          ellipse(x, y, d.radius*2, d.radius*2); 
          fill(255);
          textAlign(CENTER, CENTER);
          textSize(10);
          text(d.name, x, y);
          fill(color(0, 0, 0));
          if (d.xValue == 0) {
            lx = 0;
          } else {
            lx = log(d.xValue); 
          }
          if (d.yValue == 0) {
            ly = 0;
          } else {
            ly = log(d.yValue); 
          }
          t = new ToolTip(d.name + " (" + lx + ", " + ly + ")", mouseX, mouseY);
          hov = d.name;  
      } else {
        
        if (stateHovInd != null) {
              if (stateHovInd.equals(d.name)) {
               fill(hoverC); 
              } else {
               fill(chartC);  
              }
         } else {
           fill(chartC);
         } 
          ellipse(x, y, d.radius*2, d.radius*2); 
          fill(255);
          textAlign(CENTER, CENTER);
          textSize(10);
          text(d.name, x, y);
      }
    }
    if (t != null) {
      t.render();
    }
    hoverInd = hov; 
  }
  
  
  
  
}