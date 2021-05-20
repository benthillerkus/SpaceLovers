class GameMenu extends Layer{
  
int menuState = 0;


  
    @Override
    protected void draw() {
          if(menuState == 0){
              mainMenu();
          }
          if(menuState == 1){
            options();
          }
          
          if(menuState == 2){
            credits(); 
          }
    }
    
    void mainMenu(){
        //Asteroids
        textAlign(CENTER, TOP);
        textSize(80*pixelFactor);
        text("ASTEROIDS", width/2, height*0.1);
        
        
        
        //Play
        textAlign(CENTER);
        textSize(55*pixelFactor);
        text("Play", width/2, height/2);
        if(mousePressed == true & (width*0.45<mouseX& mouseX<width*0.55 & height*0.45<mouseY & mouseY < height*0.55)){
          sounds.menuForward.play();
          game.state = State.Play;
        }
        
        //Options
        textAlign(BOTTOM);
        textSize(45*pixelFactor);
        text("Options", width*0.15, height*0.75);
       
        
        //Credits
        textAlign(BOTTOM);
        textSize(45*pixelFactor);
        text("Credits", width*0.75, height*0.75);
        
        //"Button"-condition -- Options
        if(mousePressed == true & (width*0.1<mouseX& mouseX<width*0.35 & height*0.65<mouseY & mouseY<height*0.9)){
          clear();
          sounds.menuForward.play();
          menuState = 1;
        }
        //"Button"-condition -- Credits
        if(mousePressed == true & (width*0.7<mouseX& mouseX<width*0.9 & height*0.65<mouseY & mouseY < height*0.9)){
          clear();
          sounds.menuForward.play();
          menuState = 2;
        }
    }
    
    void options(){
      //Here be Dragons
      textAlign(CENTER);
      textSize(50*pixelFactor);
      text("Here be Dragons", width/2, height/2);
      
      //back
      textSize(20*pixelFactor);
      textAlign(CENTER);
      text("BACK", width/2, height*0.8);
      
      //"Button"-condition
      if(mousePressed == true & (width*0.45<mouseX& mouseX<width*0.55 & height*0.7<mouseY & mouseY < height*0.9)){
        clear();
        sounds.menuBack.play();
        menuState = 0;
  }
}

    void credits(){
      
      //Bent Hillerkus
      textSize(40*pixelFactor);
      textAlign(CENTER);
      text("Bent Hillerkus", width/2, height*0.5);
      
      //Joshua Lasse Einhoff
      textSize(40*pixelFactor);
      textAlign(CENTER);
      text("Joshua Lasse Einhoff", width/2, height*0.55);
      
      //Kevin Kader
      textSize(40*pixelFactor);
      textAlign(CENTER);
      text("Kevin Kader", width/2, height*0.45);
      
      //Natalie Ruth Turek
      textSize(40*pixelFactor);
      textAlign(CENTER);
      text("Natalie Ruth Turek", width/2, height*0.4);
      
      //back
      textSize(20*pixelFactor);
      textAlign(CENTER);
      text("BACK", width/2, height*0.8);
      
      //"Button"-condition
      if(mousePressed == true & (width*0.45<mouseX& mouseX<width*0.55 & height*0.7<mouseY & mouseY < height*0.9)){
        clear();
        sounds.menuBack.play();
        menuState = 0;
      }
    }
    
    void update(){
      
    }

}
