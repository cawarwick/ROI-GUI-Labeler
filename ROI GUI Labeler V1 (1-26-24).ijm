ParentD="Y:/DRGS project/#505 12-18-23/SDH Recording/Final FOV/Functional/Splits/suite2p V2/Structural Image/Red/P0/"; //where to save the files


Table.create("Results");
DirR=ParentD + "Red/";
DirC=ParentD + "Clear/";
DirB=ParentD + "Bad/";
File.makeDirectory(DirC);
File.makeDirectory(DirR);
File.makeDirectory(DirB);

Dialog.createNonBlocking("Nuclear mCherry or Not?");
options = newArray("Clear" , "Red Nucleus" , "Can't tell") ;
Dialog.addRadioButtonGroup("  ", options, 3, 1, "Clear");
Dialog.setLocation(600, 400)

Stack.getDimensions(Wd,Ht,Ch,Sl,F);

ROI=roiManager("count")
i=0;
run("Remove Overlay");
while (i<ROI) {
	roiManager("Select", i);
	Roi.setPosition("", "", "");
	Overlay.addSelection;
	X = getValue("XM");
	Y = getValue("YM");
	topLeftX = (X-20);
	topLeftY = (Y-20);
	makeRectangle(topLeftX, topLeftY, 40, 40);
	run("Duplicate...", "duplicate");
	setLocation(850, 300);
	name = "ROI"+ i + ".tif";
	run("In [+]");
	run("In [+]");
	run("In [+]");
	run("In [+]");
	run("In [+]");
	run("In [+]");
	run("In [+]");
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
	Dialog.show();
	label = Dialog.getRadioButton();
	print(label);
	Table.set("Label", i, label);
	if (label=="Clear") {
		Table.set("Binary", i, "0");
		SaveD=DirC+name;
		saveAs("Tiff", SaveD);
		close();
	}
	else {
		if (label=="Red Nucleus"){
		Table.set("Binary", i, "1");
		SaveD=DirR+name;
		saveAs("Tiff", SaveD);
		close();
	}
		else {
			Table.set("Binary", i, "?");
			SaveD=DirB+name;
			saveAs("Tiff", SaveD);
			close();
			}
		}
	
	run("Remove Overlay");
	i=i+1;
}
	
Results=ParentD + "Labeled.csv";
saveAs("Results", Results);