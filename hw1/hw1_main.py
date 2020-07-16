#!/usr/bin/env python
# coding: utf-8

#import random 
import numpy as np
from numpy.linalg import inv
x=np.random.random([15,4])*10
    
theta = np.zeros((4,1))

theta[0,0] = 2.5
theta[1,0] = 1
theta[2,0] = 4
theta[3,0] = 3.5

#real y
y = x.dot(theta)

error1 = np.random.normal(0,0.2,size=(15,1))
error2 = np.random.normal(0,0.4,size=(15,1))

#y with noise std=0.2 and std=0.4
y1 = y + error1
y2 = y + error2

print("FOR STD = 0.2")
#estimated parameters for std=0.2
param1 = (inv(x.T.dot(x))).dot(x.T).dot(y1)
print("estimated parameters")
print (param1)
#estimated y 
yy1 = x.dot(param1)

#lms error
lmsError1 = 0
for i in range (15):
    lmsError1 = lmsError1 + (y1[i][0]-yy1[i][0])**2

print("lms error:")
print (lmsError1)


print("FOR STD = 0.4")
#estimated parameters for std=0.4
param2 = (inv(x.T.dot(x))).dot(x.T).dot(y2)
print (param2)
#estimated y
yy2 = x.dot(param2)

#lms error
lmsError2 = 0
for i in range (15):
    lmsError2 = lmsError2 + (y2[i][0]-yy2[i][0])**2

print("lms error:")
print (lmsError2)
