PFont numFont,headFont;
int numFontSize = 36;
int headFontSize = int(1.5*numFontSize);
PImage imgPage;
PImage[] imgPanel;
ArrayList photoArrayNames;
float[] coordsX = { 15, 1210, 15, 1210, 15, 1210 };
float[] coordsY = { 228, 228, 1212, 1212, 2196, 2196 };
boolean doZeroPadding = true;
//********************************
int imagesPerPage = 6;
boolean saveFiles = true;
String headerText = "Untitled";
String storyboardFile = "16-9 Storyboard.png";
//********************************
int numPages,numImages;
int imageCounter = 0;
int pageCounter = 1;
int spanelW = 1024;
int spanelH = 576;
String panelFileName = "shot";
String panelFileType = "png";
String pageFileName = "page";
String pageFileType = "png";
String saveDir = "render";
String resourcesDir = "resources";

void setup() {
  Settings settings = new Settings("settings.txt");
  countFrames();
  numImages = photoArrayNames.size();
  if(numImages % imagesPerPage==0){
    numPages = (numImages/imagesPerPage)+1;
  }else{
    numPages = (numImages/imagesPerPage)+2;
  }
  imgPage = loadImage(resourcesDir + "/" + storyboardFile);
  size(imgPage.width, imgPage.height);
  imgPanel = new PImage[imagesPerPage];
  numFont = createFont("Arial",numFontSize);
  headFont = createFont("Arial",headFontSize);
  fill(0);
}

void draw() {
    image(imgPage, 0, 0);
    textFont(headFont,headFontSize);
    text(headerText + "  " + pageCounter + " / " + (numPages-1),headFontSize,headFontSize);
  if (imageCounter<numImages&&pageCounter<numPages+1) {
    for (int i=0;i<imgPanel.length;i++) {
      try{
        imgPanel[i] = loadImage((String)photoArrayNames.get(imageCounter));
        image(imgPanel[i], coordsX[i], coordsY[i],spanelW,spanelH);
      }catch(Exception e){ }
      textFont(numFont,numFontSize);
      text((1+imageCounter)+".", coordsX[i], coordsY[i]-(numFontSize/3));
      imageCounter++;
    }
    if(saveFiles){
      if(!doZeroPadding){
        saveFrame(saveDir + "/" + pageFileName+"_"+pageCounter+"."+pageFileType);
      }else{
        saveFrame(saveDir + "/" + pageFileName+"_"+zeroPadding(pageCounter,numPages)+"."+pageFileType);
      }
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
  
  String zeroPadding(int _val, int _maxVal){
  String q = ""+_maxVal;
  return nf(_val,q.length());
}
