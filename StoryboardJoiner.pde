PFont numFont,headFont;
int numFontSize = 36;
int headFontSize = int(1.5*numFontSize);
PImage imgPage;
PImage[] imgPanel;
ArrayList photoArrayNames;
float[] coordsX = { 15, 1210, 15, 1210, 15, 1210 };
float[] coordsY = { 228, 228, 1212, 1212, 2196, 2196 };
//********************************
int imagesPerPage = 6;
boolean saveFiles = true;
String headerText = "Untitled";
String storyboardFile = "16-9 Storyboard.png";
//********************************
int numPages,numImages;
int imageCounter = 0;
int pageCounter = 1;
String panelFileName = "shot";
String panelFileType = "png";
String pageFileName = "page";
String pageFileType = "png";
String saveDir = "render";


void setup() {
  Settings settings = new Settings("settings.txt");
  countFrames();
  numImages = photoArrayNames.size();
  numPages = (numImages/imagesPerPage)+1;
  imgPage = loadImage("images/" + storyboardFile);
  size(imgPage.width, imgPage.height);
  imgPanel = new PImage[imagesPerPage];
  numFont = createFont("Arial",numFontSize);
  headFont = createFont("Arial",headFontSize);
  fill(0);
}

void draw() {
    image(imgPage, 0, 0);
    textFont(headFont,headFontSize);
    text(headerText + "  " + pageCounter + " / " + numPages,headFontSize,headFontSize);
  if (imageCounter<numImages&&pageCounter<numPages+1) {
    for (int i=0;i<imgPanel.length;i++) {
      imgPanel[i] = loadImage((String)photoArrayNames.get(imageCounter));
      image(imgPanel[i], coordsX[i], coordsY[i]);
      textFont(numFont,numFontSize);
      text((1+imageCounter)+".", coordsX[i], coordsY[i]-(numFontSize/3));
      imageCounter++;
    }
    if(saveFiles){
      saveFrame(saveDir + "/" + pageFileName+"_"+pageCounter+"."+pageFileType);
    }
    pageCounter++;
    if(pageCounter>=numPages) exit();
  }else{
  exit();
  }
}

void countFrames() {
  photoArrayNames = new ArrayList();
    try {
        //loads a sequence of frames from a folder
        File dataFolder = new File(sketchPath, "data/"); 
        String[] allFiles = dataFolder.list();
        for (int j=0;j<allFiles.length;j++) {
          if (allFiles[j].toLowerCase().endsWith("png")||allFiles[j].toLowerCase().endsWith("jpg")||allFiles[j].toLowerCase().endsWith("jpeg")||allFiles[j].toLowerCase().endsWith("gif")||allFiles[j].toLowerCase().endsWith("tga")) {
            photoArrayNames.add(allFiles[j]);
          }
        }
    }catch(Exception e){ }
  }
