class Bar_chart {
  String xTitle, yTitle; 
  String[] names;
  float[] values;
  int yMin, yMax, xNum; 
  float padding = 0.2; 
  float barFill = 0.8; 
  float xPosChart;
  float yPosChart;
  float chartWidth;
  float chartHeight;

  Bar_chart(String xTitle, String yTitle, String[] names, float[] values, float _xPosChart, float _yPosChart, float _chartWidth, float _chartHeight) {
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = names;
    this.values = values;
    this.yMin = 0; // min(int(values));
    this.yMax = max(int(values)); 
    this.xNum = names.length; 
    xPosChart = _xPosChart;
    yPosChart = _yPosChart;
    chartWidth = _chartWidth;
    chartHeight = _chartHeight;
  }

  void render() {
    pushMatrix();
    translate(xPosChart, yPosChart);
    color chartB = color(0);
    //ToolTip t = null;
    fill(255); 
    rect(0, 0, chartWidth, chartHeight);
    fill(0); 
    line(padding*chartWidth, (1 - padding)*chartHeight, (1 - padding)*chartWidth, (1 - padding)*chartHeight);
    pushStyle();
    textAlign(CENTER); 
    text(xTitle, chartWidth/2, (1 - padding/3)*chartHeight);
    popStyle(); 

    //spacing 
    float spacing = (chartWidth - 2*padding*chartWidth)/xNum; 
    float barWidth = barFill*spacing;
    float xStart = chartWidth*padding; 
    float yStart = chartHeight*(1-padding); 
    float ySpacing = (chartHeight - 2*padding*chartHeight) / (yMax - yMin);  
   
    for (int i = 0; i < xNum; i++) {
        float x, y; 
        x = xStart + spacing * i; 
        y = yStart; 
        float barHeight = values[i]*ySpacing - yMin*ySpacing; 
        
        /* try rotating text */
        pushMatrix();
        translate(x, y); //change origin 
        //rotate(PI/2); //rotate around new origin 
        fill(0);
        text(" " + names[i], 30, 8); //put text at new origin 
        popMatrix();
        /* end rotate text */
          
       /* if (mouseX >= x && mouseX <= x + barWidth 
                      && mouseY >= y - barHeight && mouseY <= y) {
          fill(hoverC);
          rect(x, y - barHeight, barWidth, barHeight);
          fill(color(0, 0, 0));
          t = new ToolTip("(" + names[i] + ", " + values[i] + ")", mouseX, mouseY);
        } else { */
          if (names[i].equals("Democrat")) {
            chartB = color(0, 0, 255);
          } else if (names[i].equals("Republican")) {
            chartB = color(255, 0, 0);
          } else if (names[i].equals("Other")) {
            chartB = color(0, 255, 0);
          }
          fill(chartB); 
          rect(x, y - barHeight, barWidth, barHeight);
           
        //}
        
    }
    /*if (t != null) {
      t.render();
    }*/
    
    int NUMTICKS = 10;
    float yInterval = yMax / NUMTICKS;
    for (int i = yMin; i <= yMax; i+=yInterval) {
      pushStyle(); 
      textAlign(RIGHT); 
      fill(0); 
      text(i + " ", xStart, yStart - i*ySpacing); 
      popStyle(); 
    } 
    
    line(padding*chartWidth, padding*chartHeight, padding*chartWidth, (1 - padding)*chartHeight);  
    pushMatrix();
    translate(padding*chartWidth/2, chartHeight / 2); //change origin 
    //translate(padding*chartWidth/2, (1 - padding)*chartHeight / 2); //change origin 
    rotate(PI/2); //rotate around new origin 
    fill(0);
    text(yTitle, 0, 0); //put text at new origin 
    popMatrix();
    popMatrix();
  }
}