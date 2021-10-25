import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


ntru = np.average([
  parse_time_to_seconds(b'0:00:14.897461'),
  parse_time_to_seconds(b'0:00:13.524489'),
  parse_time_to_seconds(b'0:00:14.304229'),
  parse_time_to_seconds(b'0:00:13.901965'),
  parse_time_to_seconds(b'0:00:13.625840'),
])

rsa = np.average([
  parse_time_to_seconds(b'0:20:14.233790'),
  parse_time_to_seconds(b'0:20:10.901642'),
  parse_time_to_seconds(b'0:20:16.928831'),
  parse_time_to_seconds(b'0:20:29.610792'),
  parse_time_to_seconds(b'0:20:22.400371'),
])

data = {'RSA': rsa, 'NTRU': ntru}
print(data)
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('07_decryption_10000.png')
plt.clf()