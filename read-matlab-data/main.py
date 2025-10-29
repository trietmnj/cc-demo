from scipy.io import loadmat

data_path = "/Users/rdcrltmn/Downloads/CHS-NA_ITCS_Param_MasterTable.mat"

data = loadmat(data_path)
print(data.keys())
print(dir(data))
print(data)
# print(data["__header__"])
# print(data["Param_MT"])

import numpy as np

"""
The following are the column names for the Param_MT matrix loaded from the MATLAB file.
These columns are saved to the output CSV file 'Param_MT.csv' in the same order as listed below:
    storm_ID
    Region_ID
    Track_ID
    Track_lat
    Track_lon
    Heading
    dP
    Rmax
    Translational_speed
    Beta (shape parameter)
"""
np.savetxt("read-matlab-data/Param_MT.csv", data["Param_MT"], delimiter=",")
