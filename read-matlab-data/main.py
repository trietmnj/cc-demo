from scipy.io import loadmat
import numpy as np

data_path = "/Users/rdcrltmn/Downloads/CHS-NA_ITCS_Param_MasterTable.mat"

data = loadmat(data_path)
print(data.keys())
print(dir(data))
print(data)
# print(data["__header__"])
# print(data["Param_MT"])

# storm_ID
# Region_ID
# Track_ID
# Track_lat
# Track_lon
# Heading
# dP
# Rmax
# Translational_speed Beta(shape parameter)
np.savetxt("read-matlab-data/Param_MT.csv", data["Param_MT"], delimiter=",")
