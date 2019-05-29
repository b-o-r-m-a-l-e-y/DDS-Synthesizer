#Script for generating sine samples in interval from 0 to pi/2
import numpy as np

x=np.linspace(0,np.pi/2,64)
print(np.sin(x))
y=127*np.sin(x)
print(len(y))
print(y)
z=[]
i = 0
for elem in y:
	if int(elem)<=16:
		print("lut[%d] = 7'h0%X;" % (i, int(elem)))
	else:
		print("lut[%d] = 7'h%X;" % (i, int(elem)))
	z.append(hex(int(elem)))
	i = i + 1

#print(z)

