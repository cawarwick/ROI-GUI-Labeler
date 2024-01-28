ParentD="Y:/DRGS project/#505 12-18-23/SDH Recording/Final FOV/Functional/Splits/suite2p V2/Structural Image/Red/P1/"; //where to save the files
Retest=1; //if you want to re-review ROIs at the end
AllROIOverlays=1; //set to 1 to include all ROIs or only the 1 of interest
SizeOfFOV=35; //this is in pixels +/- the center of the ROI
xd=1150; //coordinate of the Dialog in X pixel on screen, adjust as necessary or preferred
yd=1110; //coordinate of the Dialog in Y pixel on screen\
Mag=7; //adjust to set the amount of zoom

Table.create("Results");
DirR=ParentD + "Inh/";
DirC=ParentD + "Exc/";
DirB=ParentD + "Bad/";
File.makeDirectory(DirC);
File.makeDirectory(DirR);
File.makeDirectory(DirB);
Stack.getDimensions(Wd,Ht,Ch,Sl,F);

ROI=roiManager("count");
run("Remove Overlay");

//This creates an Overlay of each ROI in white
if (AllROIOverlays==1) {
  	for (i = 0; i < ROI; i++) {
		roiManager("Select", i);
		Roi.setPosition("", "", "");
		Overlay.addSelection("white");
}

i=0;
while (i<ROI) {
	//
	if (AllROIOverlays==1) {
		if (i>0) {
		Overlay.removeSelection(ROI); //remove the last yellow overlay since otherwise they will be mixed and we only want 1 yellow and the rest are white
		}
	}
	roiManager("Select", i);
	Roi.setPosition("", "", "");
	Overlay.addSelection("yellow");; //This highlights in the default which is usually yellow to differentiate it from the all
	X = getValue("XM");
	Y = getValue("YM");
	topLeftX = (X-SizeOfFOV);
	topLeftY = (Y-SizeOfFOV);
	makeRectangle(topLeftX, topLeftY, (SizeOfFOV*2), (SizeOfFOV*2));
	run("Duplicate...", "duplicate");
	setLocation(850, 200);
	actuali=i+1;
	name = "ROI"+ actuali + ".tif";
	for (z = 0; z < Mag; z++) {
		run("In [+]");
		}
	setSlice(F);
	run("Enhance Contrast", "saturated=0.5"); //this finds the 'right' contrast for the dZ.
	getMinAndMax(min, max);
	setMinAndMax(min, max);//set the maxZ contrast to the whole image
	setSlice(F+1);
	run("Enhance Contrast", "saturated=0.5"); //this finds the 'right' contrast for the dZ.
	getMinAndMax(min, max);
	setMinAndMax(min, max);//set the maxZ contrast to the whole image
	print(name);
	rename(name);
	setSlice(1);
	Dialog.createNonBlocking("Nuclear mCherry or Not?");
	Dialog.addString("0=Clear, 1=Red, 2=?", "0");
	Dialog.setLocation(xd, yd)
	Dialog.show();
	lbl = Dialog.getString();
	print(lbl);
	Table.set("Binary", i, lbl);
	if (lbl==0) {
		Table.set("Label", i, "Exc");
		SaveD=DirC+name;
		saveAs("Tiff", SaveD);
		close();
	}
	else {
		if (lbl==1){
		Table.set("Label", i, "Inh");
		SaveD=DirR+name;
		saveAs("Tiff", SaveD);
		close();
	}
		else {
			Table.set("Label", i, "?");
			SaveD=DirB+name;
			saveAs("Tiff", SaveD);
			close();
			}
		}
	
	if (AllROIOverlays==0) {
	run("Remove Overlay");
	}
	
	i=i+1;
}

if (Retest==1) {
	waitForUser("Starting Retest");
	list=getFileList(DirB);
	print("Retest ",list.length, " Files");
	for (i=0; i<list.length; i++) {
		file=list[i];
		npath=DirB+file;
		print("Retest of",npath);
		open(npath);
		File.delete(npath);
		Filename=getInfo("window.title");
		print("Filename", Filename);
		endoffile=indexOf(Filename, ".");
		ROINum=substring(Filename, 3,endoffile);
		ROINum=parseInt(ROINum);
		print("ROINumber", ROINum);
		setLocation(850, 200);
		for (z = 0; z < Mag; z++) {
			run("In [+]");
			}
		setSlice(1);
		Dialog.createNonBlocking("Nuclear mCherry or Not?");
		Dialog.addString("0=Clear, 1=Red, 2=?", "0");
		Dialog.setLocation(xd, yd)
		Dialog.show();
		lbl = Dialog.getString();
		print(lbl);
		TableNum=ROINum-1;
		print("put new label in row", TableNum);
		Table.set("Binary", (TableNum), lbl);
		if (lbl==0) {
			Table.set("Label", TableNum, "Exc");
			SaveD=DirC+Filename;
			saveAs("Tiff", SaveD);
			close();
		}
		else {
			if (lbl==1){
			Table.set("Label", TableNum, "Inh");
			SaveD=DirR+Filename;
			saveAs("Tiff", SaveD);
			close();
		}
			else {
				Table.set("Label", TableNum, "?");
				SaveD=DirB+Filename;
				saveAs("Tiff", SaveD);
				close();
				}
		}	
	}
}
Results=ParentD + "Labeled.csv";
saveAs("Results", Results);
