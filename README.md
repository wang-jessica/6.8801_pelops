# 6.8801 Final Project - Team Pelops

This repository has all code and raw data for the project titled "Diagnosis of Wolff-Parkinson-White Syndrome from Lead 1
Electrocardiograms using Time-Frequency Analysis and Deep Learning" submitted for a final project of 6.8801 at MIT taught by Dr.
Ridwan Alam. 

There are  raw data files from the PTBXL and China datasets, along with preprocessing scripts to convert these to CSVs. Chiefly, 
the data is contained in any folder marked 'PTB-XL' or 'China,' and the corresponding code is in any script annotated with 'preprocessing.'

Training data, consisting of augmented ECGs in CSV format, is given in in the Training Data folder as .zip files. Each file is a 
10-second ECG clip. File names that are appended with _1 are original patient data, while file names appended with 2-4 are augmented
data. 

Code for time-domain augmentation used to generate example figures is given in ECG_augment.m. Code for performing augmentations of all of our data at once if found in the RN2 folder in the file integrated_loading_augmentation.m

Wavelet analysis to generate 2D scalograms is performed by gen_images.m. 

Finally, training of deep learning model and calculation of performance metrics is given in train.m. 





misc. notes:
- patient 230 has instance of WPW at timestamp 5:11
- https://archive.physionet.org/physiobank/database/html/mitdbdir/records.htm#230 

ecg csv data: 
- use convert2() in ecg_csvConvert.py to convert the MIT-BIH data to csv format
- Column 1 is lead 2 signal; column 2 is lead 5 signal
- norm_230 is the [0,1] normalized version of patient 230
- Patient 230 samples of interest:
- --> rows 112305:114304 (~5.5 minutes starting from WPW timestamp)
- --> rows 204389:206388 (~5.5 minutes starting from normal sinus rhythm timestamp)

WPW-Automated: 
- contains all WPW ECGs from this database: https://data.mendeley.com/datasets/6jd4rn2z9x/1
- still need to convert them to a .csv (now in .xlsx)
- each file has 12 leads, 10 second segments, Fs=500Hz
  
WPW_Automated_China_CSV
- 100 WPW ECGs converted to CSV format

WPW_PTB-XL: 
- 79 WPW ECGs
- .dat file --> find way to convert!
- each file has 12 leads, 10 second segments, Fs=500Hz
- from PTB-XL Database

Normal_PTB-XL: 
- 97 normal ECGs from PTB-XL database
- .dat file --> find way to convert!
- each file has 12 leads, 10 second segments, Fs=500Hz


Normal_PTB-XL-pt2: 
- remaining 23 normal ECGs from PTB-XL database (couldn't upload more than 100 files at once)
- .dat file --> find way to convert!
- each file has 12 leads, 10 second segments, Fs=500Hz

RN2 Folder
- Contains 5 data augmentation subfunctions that take a lead vector (length 5000) as input
- Data augmentation functions are: gaussian noise, baseline wander, line noise, dropout, and butterworth
- Combined_ECG_Augmentation combines 2 augmentations per larger augmentation --> creates 4 output (raw & combined augmentations 1,2, & 3)

