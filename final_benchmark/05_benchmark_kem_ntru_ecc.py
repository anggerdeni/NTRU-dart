import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


ntru = np.average([
  parse_time_to_seconds(b'0:03:31.185178'),
  parse_time_to_seconds(b'0:03:30.732040'),
  parse_time_to_seconds(b'0:03:30.817637'),
  parse_time_to_seconds(b'0:03:31.273467'),
  parse_time_to_seconds(b'0:03:30.912776'),
])

ecc = np.average([
  parse_time_to_seconds(b'0:03:36.103790'),
  parse_time_to_seconds(b'0:03:35.594110'),
  parse_time_to_seconds(b'0:03:37.287485'),
  parse_time_to_seconds(b'0:03:38.622984'),
  parse_time_to_seconds(b'0:03:36.208480'),
])

data = {'X25519': ecc, 'NTRU': ntru}
print(data)
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('05_kem_100000.png')
plt.clf()