import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


ntru = parse_time_to_seconds(b'0:00:02.211068')
rsa = parse_time_to_seconds(b'0:02:03.102293')
ecc = parse_time_to_seconds(b'0:00:02.340858')

data = {'RSA': rsa, 'X25519': ecc, 'NTRU': ntru}
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('04_kem_1000.png')
plt.clf()