import wfdb
import csv

# doesn't work but in theory is an alternative way of converting to csv
def convert(filename):
    oldFile = wfdb.rdrecord(filename,pn_dir='mitdb')
    patient_number = oldFile.record_name
    leads = oldFile.sig_name
    ecg = oldFile.p_signal
    ecg_data = f'{filename}.csv'
    with open(ecg_data,"w") as csvfile:
        out_csv = csv.writer(csvfile)
        out_csv.writerow(leads)
        for row in ecg_data:
            out_csv.writerow(row)
            break
    return out_csv

## convert2() while files are on desktop
def convert2():
    """
    Code to convert all .dat files (ECG signals) in a folder to CSV format 
    @author: Abhishek Patil
    """
    import wfdb #WaveForm-Database package. A library of tools for reading, writing, and processing WFDB signals and annotations.
    import pandas as pd
    import numpy as np
    import glob


    dat_files=glob.glob('*.dat') #Get list of all .dat files in the current folder
    df=pd.DataFrame(data=dat_files)
    df.to_csv("files_list.csv",index=False,header=None) #Write the list to a CSV file
    files=pd.read_csv("files_list.csv",header=None)

    for i in range(1,len(files)+1):
            recordname=str(files.iloc[[i]])
            print(recordname[:-4])
            recordname_new=recordname[-7:-4] #Extracting just the filename part (will differ from database to database)
            record = wfdb.rdsamp(recordname_new) # rdsamp() returns the signal as a numpy array  
            record=np.asarray(record[0])
            path=recordname_new+".csv"
            np.savetxt(path,record,delimiter=",") #Writing the CSV for each record
            print("Files done: %s/%s"% (i,len(files)))

    print("\nAll files done!")
    convert2()







