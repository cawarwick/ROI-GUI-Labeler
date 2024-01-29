# ROI-GUI-Labeler
ImageJ Macro for helping the manual labeling of ROIs. This is intended to be used to manually evaluate whether a cell has nuclear mCherry or not. 

Each plane will need to be done seperately, so pick a plane to evaluate (e.g. P0), make a substack of the relevant planes (e.g. if your ROIs for P0 span from slice 5-40, you can estimate +/- 20 from the mean).

For the reference stack I usually will put the CellPose image at the top and bottom of the Z-stack so that you can see the functional image 1st, e.g. concatenate it to the start and the end of your structural image.

![image](https://github.com/cawarwick/ROI-GUI-Labeler/assets/81972652/e16b68ee-ed3d-465a-b663-e1f612bb2fd7)


Operating instructions:

Change the directory to where you want it to save the ref images and the results
ParentD="Y:/DRGS project/P0/"; //where to save the files and the results


Have your ROIs loaded into imageJ and your reference structural Z-stack already open.
![image](https://github.com/cawarwick/ROI-GUI-Labeler/assets/81972652/504505b4-8ada-4d27-a0c0-9d324b18031d)

Run the macro and evaluate. I usually find that the structural and the functional ROIs rarely line up 1:1 due to warping during the K30, so look for the similar shape rather than the exact XY coordinates.
![image](https://github.com/cawarwick/ROI-GUI-Labeler/assets/81972652/5aae1d92-b25b-4016-9f4e-5cced2482b34)

If your cell doesn't show up in the Max Activity projection or during the K30 strucutral stack due to a low S:N such as in the example below

![image](https://github.com/cawarwick/ROI-GUI-Labeler/assets/81972652/3964e38f-5919-4867-ac69-3132ada6b900)

Use other cells as landmarks to find the right range of Z-plane, e.g. find the cell that lines with the any ROI at the highest and lowest Z-plane and then search within that range. Even including +/-3 zstacks of Z-drift the red nucleus should be visible so if there is no nucelus assume it's excitatory.

![image](https://github.com/cawarwick/ROI-GUI-Labeler/assets/81972652/ad5dbfa6-16c7-4356-bf74-f1b08a57ec9f)

Example of intended useage
https://youtu.be/iI1-M3u2FjM

Variaibles you can change if desired, but default is fine

AllROIOverlays=1 //set to 1 to include all ROIs or only the 1 of interest

SizeOfFOV=35 //this is in pixels +/- the center of the ROI

xd=1150; //coordinate of the Dialog in X pixel on screen, adjust as necessary or preferred

yd=1110; //coordinate of the Dialog in Y pixel on screen

Mag=7; //adjust to set the amount of zoom
