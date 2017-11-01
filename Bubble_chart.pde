class Bubble_chart {
  String xTitle, yTitle; 
  float[] names;
  float[] values;
  float[] bubSize;
  int yMin, yMax, xNum; 
  float padding = 0.15; 
  float pointRadius = 5;
  float defaultRad = 5; 

  Bubble_chart(String xTitle, String yTitle, float[] names, float[] values, float[] bubSize) {
    this.xTitle = xTitle;
    this.yTitle = yTitle;
    this.names = names;
    this.values = values;
    this.bubSize = bubSize;
    this.yMin = 0; 
    this.yMax = max(int(values)); 
    this.xNum = names.length; 
  }

  void render() {
    ToolTip t = null;
    fill(255); 
    rect(0, 0, width, height);  
    fill(0); 
    line(padding*width, (1 - padding)*height, (1 - padding)*width, (1 - padding)*height);
    pushStyle();
    textAlign(CENTER); 
    text(xTitle, width/2, (1 - padding/3)*height);
    popStyle(); 

    //spacing 
    float spacing = (width - 2*padding*width)/xNum; 
    float xStart = width*padding; 
    float yStart = height*(1-padding); 
    float ySpacing = (height - 2*padding*height) / (yMax - yMin);  
    float x, y, x2, y2; 
    float barHeight, barHeight2; 
   
       int NUMTICKS = 10;
    float yInterval = yMax / NUMTICKS;
    for (int i = yMin; i <= yMax; i+=yInterval) {
      pushStyle(); 
      textAlign(RIGHT); 
      fill(0); 
      text(i + " ", xStart, yStart - i*ySpacing); 
      popStyle(); 
    } 
    
    line(padding*width, padding*height, padding*width, (1 - padding)*height);  
    pushMatrix();
    translate(padding*width/2, height / 2); //change origin 
    rotate(PI/2); //rotate around new origin 
    fill(0);
    //textAlign(CENTER);
    text(yTitle, 0, 0); //put text at new origin 
    popMatrix();
   
   
    for (int i = 0; i < xNum; i++) {
        x = xStart + spacing * i; 
        y = yStart; 
        barHeight = values[i]*ySpacing - yMin*ySpacing; 
        pointRadius = bubSize[i] * defaultRad; 
        
        if (i != xNum - 1) {
          x2 = xStart + spacing * (i + 1); 
          y2 = yStart; 
          barHeight2 = values[i+1]*ySpacing - yMin*ySpacing; 
        } else {
          x2 = 0;
          y2 = 0; 
          barHeight2 = 0; 
        }
        
        /* try rotating text */
        pushMatrix();
        translate(x, y); //change origin 
        rotate(PI/2); //rotate around new origin 
        fill(0);
        //text(" " + names[i], spacing, 0); //put text at new origin 
        popMatrix();
        /* end rotate text */
        println("X " + mouseX + " Y " + mouseY);   
        if (mouseX >= x - pointRadius && mouseX <= x + pointRadius 
                      && mouseY >= y - barHeight - pointRadius && mouseY <= y - barHeight + pointRadius) {
          fill(hoverC);
          ellipse(x, y - barHeight, pointRadius, pointRadius);
          fill(color(0, 0, 0));
          t = new ToolTip("(" + names[i] + ", " + values[i] + ")", mouseX, mouseY);
          println("HOVER"); 
        } else {
          fill(chartC); 
          ellipse(x, y - barHeight, pointRadius, pointRadius);
        }
    }
    if (t != null) {
      t.render();
    }
  }
}