import math
import numpy as np
from scipy.stats import norm
import matplotlib.pyplot as plt

# m = np.genfromtxt("fort.100");
# mu, std = norm.fit(m)
# fitInfo = ': mu = %.2f,  std = %.2f' % (mu, std)
#
# # hist, bins = np.histogram(m, density=True)
# # center = (bins[:-1] + bins[1:]) / 2
# # plt.plot( center, hist, label='natural frequency')
#
# # plt.subplot(3,1,1)
# n, bins, patches = plt.hist( m, bins=25, alpha=0.6, color='g', label='data')
#
# xmin, xmax = plt.xlim()
# x = np.linspace(xmin, xmax, 100)
# p = norm.pdf(x, mu, std)
# plt.plot(x, p, 'k', linewidth=2, label=fitInfo)
# # plt.legend()
# plt.title('Natural Frequency Distribution' + fitInfo)
# plt.xlabel('Frequency (1/s)'); plt.ylabel('Probability')
# # plt.savefig('dist1.png')
# plt.show()


plt.subplot(3,1,1)
n = np.genfromtxt("fort.104");
plt.plot( n[:,0], n[:,1])
plt.ylabel('$<I_g>$')

plt.subplot(3,1,2)
plt.plot( n[:,0], n[:,2])
plt.ylabel('$<q>$')
plt.xlabel('time')

# plt.savefig('test1.png')
# plt.show()


plt.subplot(3,1,3)
# n = np.genfromtxt("fort.103");
# plt.plot( n[:,0], n[:,1], n[:,0], n[:,2], n[:,0], n[:,3])
# plt.ylabel('sample $\omega$ trajectories')

# n = np.genfromtxt("fort.102");
# plt.plot( n[:,0], n[:,1], linewidth=2, label='Averaged Signal')
# plt.legend()
# plt.xlabel('time')
# plt.ylabel('Intensity Trajectoties')
# plt.title('Sound Intensity')

n = np.genfromtxt("fort.102");
plt.plot( n[:,0], n[:,2], linewidth=2, label='q')
plt.legend()
plt.xlabel('time')

# plt.savefig('test2.png')
plt.show()
