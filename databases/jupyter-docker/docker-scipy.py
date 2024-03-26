import numpy as np
from scipy import io as sio
array = np.ones((4, 4))
sio.savemat('example.mat', {'ar': array}) 
data = sio.loadmat('example.mat', struct_as_record=True)
data['ar']