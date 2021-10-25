import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


ntru = np.average([
  parse_time_to_seconds(b'0:00:07.826555'),
  parse_time_to_seconds(b'0:00:07.288839'),
  parse_time_to_seconds(b'0:00:07.205961'),
  parse_time_to_seconds(b'0:00:07.212847'),
  parse_time_to_seconds(b'0:00:07.036314'),
])

rsa = np.average([
  parse_time_to_seconds(b'0:00:27.988635'),
  parse_time_to_seconds(b'0:00:24.488103'),
  parse_time_to_seconds(b'0:00:23.990250'),
  parse_time_to_seconds(b'0:00:24.030083'),
  parse_time_to_seconds(b'0:00:24.594128'),
])

data = {'RSA': rsa, 'NTRU': ntru}
print(data)
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('06_encryption_10000.png')
plt.clf()