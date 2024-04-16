# 6.8801_pelops

general data notes:
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

