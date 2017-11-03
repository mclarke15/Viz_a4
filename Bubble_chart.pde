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
        DataPair d = new DataPair(titles[i], names[i], values[i], bubSize[i] * defaultRadius/2);
        if (dataPairs.contains(d) == false) {
           dataPairs.add(d); 
        }
    }
    xPosChart = _xPosChart;
    yPosChart = _yPosChart;
    chartWidth = _chartWidth;
    chartHeight = _chartHeight;
    xmax = log(max(names));
    ymax = log(max(values));
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
  }
  
  void render() {
    ToolTip t = null;
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
     // println("x: " + x + " y: " + y); 
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
          t = new ToolTip(d.name + " (" + d.xValue + ", " + d.yValue + ")", mouseX, mouseY);
        } else {
          fill(chartC); 
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
    
    int NUMTICKS = 10;
    float yInterval = (ymax - ymin) / NUMTICKS;
    float ySpacing = (yStart - yEnd)/NUMTICKS;
    //float ySpacing = (chartHeight - 2*padding*chartHeight) / (log(ymax) - ymin);
   // println("ySpacing: " + ySpacing);
   // println("yEnd: " + yEnd + " yStart: " + yStart);
   // println("yInterval: " + yInterval);
   // println("ymax: " + ymax + " ymin: " + ymin); 
    for (float i = ymin; i <= ymax; i+=yInterval) {
      pushStyle(); 
      textAlign(RIGHT); 
      fill(0); 
      //println("xStart " + xStart + " yStart " + yStart + " y "+ (yStart - i*ySpacing));
     // println(i);
      text(i + " ", xStart, yStart - i*ySpacing);
      popStyle(); 
    } 
  }
  
  
  
  
}