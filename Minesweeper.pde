import de.bezier.guido.*;
//Static Variables
int NUM_ROWS =20;
int NUM_COLS=20;
int NUM_MINES=50;

public boolean lost=false;
//Button Master list
private MSButton[][] buttons; //2d array of minesweeper buttons

//Mines List
private ArrayList <MSButton> mines = new ArrayList<MSButton> ();


//Cookie function for mine image
public void cookie(int x, int y){
 fill(255, 0, 0);
 ellipse(x, y, 100, 100);//cookie
 fill(123, 63, 0);
 ellipse(x, y-20, 10, 10);//chocolate chips
 ellipse(x-10, y-40, 10, 10);
 ellipse(x+30, y+10, 10, 10);
 ellipse(x, y+40, 10, 10);
 ellipse(x+10, y+10, 10, 10);
 ellipse(x-40, y-20, 10, 10);
 ellipse(x-25, y+20, 10, 10);
 ellipse(x+35, y-10, 10, 10);
 fill(100);
}

//setup, initialization of lists
void setup ()
{

    size(1000, 1000);
    textAlign(CENTER,CENTER);
   
    // make the manager
    Interactive.make( this );
   
    //your code to initialize buttons goes here
    buttons= new MSButton[NUM_ROWS][NUM_COLS];
    for(int r=0; r<NUM_ROWS; r++){
      for(int c=0; c<NUM_COLS;c++){
        buttons[r][c]= new MSButton(r, c);
      }
    }

   
   
   
    setMines();
}


//sets mines
public void setMines()
{
 
 
  while(mines.size()<NUM_MINES){
    int rRow= (int)(Math.random()*NUM_ROWS);
    int rCol= (int)(Math.random()*NUM_COLS);
   
   
   
    if(mines.contains(buttons[rRow][rCol])){
     
    }
    else{

      mines.add(buttons[rRow][rCol]);
    }
}
}




//draw loop, sets background and establishes winning message
public void draw ()
{
    background(0);
    if(isWon() == true)
        displayWinningMessage();
}


//checks if won

public boolean isWon()
{
    for(int i=0; i<NUM_ROWS; i++){
      for(int p=0; p<NUM_ROWS;p++){
        if(buttons[i][p].clicked==false){
          return false;
        }
      }
    }
    return true;
}



//losing function
public void displayLosingMessage()
{
 

   
     for(int r=0; r<NUM_ROWS; r++){
      for(int c=0; c<NUM_COLS;c++){
        buttons[r][c].myLabel="You Lose!";
      }}
   
     
   
}


//winning function
public void displayWinningMessage()
{
   for(int r=0; r<NUM_ROWS; r++){
      for(int c=0; c<NUM_COLS;c++){
        buttons[r][c].myLabel="You Win!";
      }}
     
   
     
}


//checks validity
public boolean isValid(int r, int c)
{
     if(r<NUM_ROWS && r >=0 && c<NUM_COLS && c>=0){
       return true;
     }
     else
     return false;
 
}


//checks neighboring buttons
public int countMines(int row, int col)
{
    int numMines = 0;
  for(int a=row-1;a<=row+1;a++){
    for(int b=col-1;b<=col+1;b++){
      if(isValid(a, b)==true&&mines.contains(buttons[a][b])){
        numMines++;
      }
     
    }
  }
 
    return numMines;
}



//BEGIN CLASS
public class MSButton
{
  //class variables
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
   
   
   //constructor
    public MSButton ( int row, int col )
    {
         width = 1000/NUM_COLS;
         height = 1000/NUM_ROWS;
        myRow = row;
        myCol = col;
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
   
   
   //gettter and setters
    int getX(){
     
      return (int)x;
    }
   
   
   
    int getY(){
     
      return (int)y;
    }



    // called by manager
    public void mousePressed ()
    {
      
      
      if(isWon()){
        displayWinningMessage();
      }
      else if(lost){
        
      }
      else{
        clicked = true;
       
        if(mouseButton==RIGHT){
          boolean change=false;
          if(flagged==true){
       
          }
          if(flagged==false){
            change=true;
            clicked=false;
          }
          flagged=change;
         
        }
       
 
       
 
       
       else if(countMines(myRow, myCol)>0){
       setLabel(countMines(myRow, myCol));

        }
       
       else{
         
         
   for(int i=myRow-1; i<myRow+2; i++){
     for(int p=myCol-1; p<myCol+2;p++){
       if(isValid(i, p) &&!buttons[i][p].isClicked()){
         buttons[i][p].mousePressed();
         
       }
     }
     
   }
         
     
       }
       
         
         
        }
    }
       
       
       
       
       
       
 
    public void draw ()
    {    
        if (flagged){
            fill(255, 0, 0);
           
        }
         if( clicked && mines.contains(this) ){
           
         fill(255, 0, 0);
            for(int i=0; i<mines.size(); i++){
        mines.get(i).mousePressed();
        cookie(mines.get(i).getX()+400/NUM_COLS/2, mines.get(i).getY()+400/NUM_ROWS/2);
       displayLosingMessage();
      }
       
       
      }
     
   
             
     
        else if(clicked){
            fill( 200 );
           
        }
        else{
         fill(100);}

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
       
       
       
}


   
   
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
   
    public boolean isFlagged()
    {
        return flagged;
    }
    
    public boolean isClicked()
    {
      return clicked;
    }
   

}
