###########################################################
###########################################################
#### SHORT PHYSICAL PERFORMANCE BATTERY (SPPB) DATASET ####
###########################################################
###########################################################

Date of creation: 10/14/2020

Created by: Laura Romeo
Contact: laura.romeo@stiima.cnr.it

All files *Set.mat contain ID, date of execution, sex, age, and skeletal information of the balance, sit-to-stand and walking tests performed by elderly patient, both healthy and affected from neurological diseases.
In samplePaper.m there is an example of a graphic realized using the data in the dataset.

The dataset is composed as follows:

size: [num of tests] x 6
###############################################################################################
## patient ID ## date of the test ## sex ## age ## evaluation of the test ## skeletal joints ##
###############################################################################################
The size of balanceSet is [num of tests] x 8, as the skeletal joints are grabbed from 3 different exercises that compose the Balance Test (side by side, semi-tandem and tandem). If one of the element is empty, it means that the patient was incapable of performing the exercise.

The skeletal joints struct is:

size: 3 x 1
#################################
#################################
#1# joints from left camera    ##
#################################
#2# joints from central camera ##
#################################
#3# joints from right camera   ##
#################################
#################################

skeletonJointsXx has size [num of frames] x 1. Inside skeletonJointsXx{i,1} there are the following values:

size: [num of joints] x 4
############################################################################################
## i-coordinate of the joint ## j-coordinate of the joint ## joint confidence ## joint ID ##
############################################################################################

The joint ID parameters refer to the following table:

##########################
##########################
##  1 ## Nose           ##
##  2 ## Neck           ##
##  3 ## Right Shoulder ##
##  4 ## Right Elbow    ##
##  5 ## Right Hand     ##
##  6 ## Left Shoulder  ##
##  7 ## Left Elbow     ##
##  8 ## Left Hand      ##
##  9 ## Right Hip      ##
## 10 ## Right Knee     ##
## 11 ## Right Foot     ##
## 12 ## Left Hip       ##
## 13 ## Left Knee      ##
## 14 ## Left Foot      ##
## 15 ## Right Eye      ##
## 16 ## Left Eye       ##
## 17 ## Right Ear      ##
## 18 ## Left Ear       ##
##########################
##########################


The joints are given in ij coordinate. To have them in xy coordinate, they must be multiplied by a parameter given by OpenPose: multiplier = 0.5111.