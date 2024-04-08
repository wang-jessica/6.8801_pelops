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

