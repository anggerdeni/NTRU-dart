import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


method_1_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:01:28.671139'),
  parse_time_to_seconds(b'0:01:35.869347'),
  parse_time_to_seconds(b'0:01:34.298385'),
  parse_time_to_seconds(b'0:01:35.306923'),
  parse_time_to_seconds(b'0:01:34.426339'),
  parse_time_to_seconds(b'0:01:40.081738'),
  parse_time_to_seconds(b'0:01:33.700417'),
  parse_time_to_seconds(b'0:01:38.095148'),
  parse_time_to_seconds(b'0:01:37.079430'),
  parse_time_to_seconds(b'0:01:32.375175'),
])
method_2_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:00:31.031814'),
  parse_time_to_seconds(b'0:00:30.000827'),
  parse_time_to_seconds(b'0:00:30.080094'),
  parse_time_to_seconds(b'0:00:30.419548'),
  parse_time_to_seconds(b'0:00:30.304078'),
  parse_time_to_seconds(b'0:00:30.810492'),
  parse_time_to_seconds(b'0:00:31.084587'),
  parse_time_to_seconds(b'0:00:30.704725'),
  parse_time_to_seconds(b'0:00:32.312263'),
  parse_time_to_seconds(b'0:00:30.104705'),
])
method_3_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:00:31.868657'),
  parse_time_to_seconds(b'0:00:31.126741'),
  parse_time_to_seconds(b'0:00:31.205066'),
  parse_time_to_seconds(b'0:00:31.556783'),
  parse_time_to_seconds(b'0:00:31.668242'),
  parse_time_to_seconds(b'0:00:32.106707'),
  parse_time_to_seconds(b'0:00:32.021123'),
  parse_time_to_seconds(b'0:00:31.964134'),
  parse_time_to_seconds(b'0:00:31.275312'),
  parse_time_to_seconds(b'0:00:31.090003'),
])

data = {'Metode 1': method_1_keygen_1000x, 'Metode 2': method_2_keygen_1000x, 'Metode 3': method_3_keygen_1000x}
print(data)
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('01_01_key generation.png')
plt.clf()

method_1_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:07.293281'),
  parse_time_to_seconds(b'0:00:07.195267'),
  parse_time_to_seconds(b'0:00:07.194645'),
  parse_time_to_seconds(b'0:00:07.224321'),
  parse_time_to_seconds(b'0:00:07.279036'),
  parse_time_to_seconds(b'0:00:07.317581'),
  parse_time_to_seconds(b'0:00:07.385987'),
  parse_time_to_seconds(b'0:00:07.300086'),
  parse_time_to_seconds(b'0:00:07.190335'),
  parse_time_to_seconds(b'0:00:07.100299'),
])
method_2_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:07.288104'),
  parse_time_to_seconds(b'0:00:07.198726'),
  parse_time_to_seconds(b'0:00:07.198167'),
  parse_time_to_seconds(b'0:00:07.292825'),
  parse_time_to_seconds(b'0:00:07.276681'),
  parse_time_to_seconds(b'0:00:07.400947'),
  parse_time_to_seconds(b'0:00:07.387261'),
  parse_time_to_seconds(b'0:00:07.222731'),
  parse_time_to_seconds(b'0:00:07.199467'),
  parse_time_to_seconds(b'0:00:07.107201'),
])
method_3_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:07.396967'),
  parse_time_to_seconds(b'0:00:07.284250'),
  parse_time_to_seconds(b'0:00:07.286105'),
  parse_time_to_seconds(b'0:00:07.288380'),
  parse_time_to_seconds(b'0:00:07.383370'),
  parse_time_to_seconds(b'0:00:07.408101'),
  parse_time_to_seconds(b'0:00:07.394277'),
  parse_time_to_seconds(b'0:00:07.266649'),
  parse_time_to_seconds(b'0:00:07.210599'),
  parse_time_to_seconds(b'0:00:07.202537'),
])
data = {'Metode 1': method_1_encryption_10000x, 'Metode 2': method_2_encryption_10000x, 'Metode 3': method_3_encryption_10000x}
print(data)
methods = list(data.keys())
values = list(data.values())
plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('01_02_encryption.png')
plt.clf()

method_1_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:14.575654'),
  parse_time_to_seconds(b'0:00:16.497240'),
  parse_time_to_seconds(b'0:00:16.671487'),
  parse_time_to_seconds(b'0:00:16.630330'),
  parse_time_to_seconds(b'0:00:16.899678'),
  parse_time_to_seconds(b'0:00:17.101690'),
  parse_time_to_seconds(b'0:00:17.013538'),
  parse_time_to_seconds(b'0:00:16.765575'),
  parse_time_to_seconds(b'0:00:16.520547'),
  parse_time_to_seconds(b'0:00:16.341913'),
])
method_2_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:17.686410'),
  parse_time_to_seconds(b'0:00:17.591802'),
  parse_time_to_seconds(b'0:00:17.627107'),
  parse_time_to_seconds(b'0:00:17.858004'),
  parse_time_to_seconds(b'0:00:17.874820'),
  parse_time_to_seconds(b'0:00:18.041632'),
  parse_time_to_seconds(b'0:00:17.990409'),
  parse_time_to_seconds(b'0:00:17.816311'),
  parse_time_to_seconds(b'0:00:17.505902'),
  parse_time_to_seconds(b'0:00:17.333431'),
])
method_3_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:17.709542'),
  parse_time_to_seconds(b'0:00:17.427994'),
  parse_time_to_seconds(b'0:00:17.601742'),
  parse_time_to_seconds(b'0:00:17.690301'),
  parse_time_to_seconds(b'0:00:17.814664'),
  parse_time_to_seconds(b'0:00:18.116873'),
  parse_time_to_seconds(b'0:00:17.942633'),
  parse_time_to_seconds(b'0:00:17.838497'),
  parse_time_to_seconds(b'0:00:17.420137'),
  parse_time_to_seconds(b'0:00:17.336162'),
])
data = {'Metode 1': method_1_decryption_10000x, 'Metode 2': method_2_decryption_10000x, 'Metode 3': method_3_decryption_10000x}
print(data)
methods = list(data.keys())
values = list(data.values())
plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Lama Eksekusi (dalam detik)")
plt.savefig('01_03_decryption.png')
plt.clf()