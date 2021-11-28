import numpy as np
import matplotlib.pyplot as plt

def parse_time_to_seconds(t):
  t = t.split(b':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds


method_1_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:01:23.800082'),
  parse_time_to_seconds(b'0:01:20.584015'),
  parse_time_to_seconds(b'0:01:21.732356'),
  parse_time_to_seconds(b'0:01:17.192985'),
  parse_time_to_seconds(b'0:01:20.374413'),
  parse_time_to_seconds(b'0:01:19.671584'),
  parse_time_to_seconds(b'0:01:20.312114'),
  parse_time_to_seconds(b'0:01:18.391291'),
  parse_time_to_seconds(b'0:01:18.591462'),
  parse_time_to_seconds(b'0:01:18.012523'),
])
method_2_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:00:34.024476'),
  parse_time_to_seconds(b'0:00:29.014340'),
  parse_time_to_seconds(b'0:00:29.877339'),
  parse_time_to_seconds(b'0:00:28.999831'),
  parse_time_to_seconds(b'0:00:29.311125'),
  parse_time_to_seconds(b'0:00:29.519735'),
  parse_time_to_seconds(b'0:00:28.996699'),
  parse_time_to_seconds(b'0:00:29.095022'),
  parse_time_to_seconds(b'0:00:29.675414'),
  parse_time_to_seconds(b'0:00:28.910795'),
])
method_3_keygen_1000x = np.average([
  parse_time_to_seconds(b'0:00:36.772032'),
  parse_time_to_seconds(b'0:00:34.582718'),
  parse_time_to_seconds(b'0:00:34.406049'),
  parse_time_to_seconds(b'0:00:33.891410'),
  parse_time_to_seconds(b'0:00:34.085712'),
  parse_time_to_seconds(b'0:00:34.682930'),
  parse_time_to_seconds(b'0:00:34.090755'),
  parse_time_to_seconds(b'0:00:34.815835'),
  parse_time_to_seconds(b'0:00:35.242918'),
  parse_time_to_seconds(b'0:00:34.995316'),
])

data = {'Method 1': method_1_keygen_1000x, 'Method 2': method_2_keygen_1000x, 'Method 3': method_3_keygen_1000x}
print(data)
methods = list(data.keys())
values = list(data.values())

plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Execution time (seconds)")
plt.savefig('01_01_key generation.png')
plt.clf()

method_1_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:06.598773'),
  parse_time_to_seconds(b'0:00:06.497502'),
  parse_time_to_seconds(b'0:00:06.693213'),
  parse_time_to_seconds(b'0:00:06.592262'),
  parse_time_to_seconds(b'0:00:06.498742'),
  parse_time_to_seconds(b'0:00:06.587471'),
  parse_time_to_seconds(b'0:00:06.417479'),
  parse_time_to_seconds(b'0:00:06.684727'),
  parse_time_to_seconds(b'0:00:06.681499'),
  parse_time_to_seconds(b'0:00:06.427748'),
])
method_2_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:06.624839'),
  parse_time_to_seconds(b'0:00:06.582814'),
  parse_time_to_seconds(b'0:00:06.620140'),
  parse_time_to_seconds(b'0:00:06.587585'),
  parse_time_to_seconds(b'0:00:06.487661'),
  parse_time_to_seconds(b'0:00:06.411851'),
  parse_time_to_seconds(b'0:00:06.499515'),
  parse_time_to_seconds(b'0:00:06.595064'),
  parse_time_to_seconds(b'0:00:06.618271'),
  parse_time_to_seconds(b'0:00:06.517356'),
])
method_3_encryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:06.800938'),
  parse_time_to_seconds(b'0:00:06.515788'),
  parse_time_to_seconds(b'0:00:06.628088'),
  parse_time_to_seconds(b'0:00:06.482226'),
  parse_time_to_seconds(b'0:00:06.492843'),
  parse_time_to_seconds(b'0:00:06.604795'),
  parse_time_to_seconds(b'0:00:06.705190'),
  parse_time_to_seconds(b'0:00:06.567095'),
  parse_time_to_seconds(b'0:00:06.528590'),
  parse_time_to_seconds(b'0:00:06.507548'),
])
data = {'Method 1': method_1_encryption_10000x, 'Method 2': method_2_encryption_10000x, 'Method 3': method_3_encryption_10000x}
print(data)
methods = list(data.keys())
values = list(data.values())
plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Execution time (seconds)")
plt.savefig('01_02_encryption.png')
plt.clf()

method_1_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:13.598540'),
  parse_time_to_seconds(b'0:00:14.870265'),
  parse_time_to_seconds(b'0:00:14.782012'),
  parse_time_to_seconds(b'0:00:14.778385'),
  parse_time_to_seconds(b'0:00:14.972359'),
  parse_time_to_seconds(b'0:00:15.027034'),
  parse_time_to_seconds(b'0:00:16.311179'),
  parse_time_to_seconds(b'0:00:14.809375'),
  parse_time_to_seconds(b'0:00:14.822734'),
  parse_time_to_seconds(b'0:00:15.100733'),
])
method_2_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:16.029317'),
  parse_time_to_seconds(b'0:00:15.612008'),
  parse_time_to_seconds(b'0:00:15.692435'),
  parse_time_to_seconds(b'0:00:15.686813'),
  parse_time_to_seconds(b'0:00:15.795326'),
  parse_time_to_seconds(b'0:00:15.781134'),
  parse_time_to_seconds(b'0:00:17.109377'),
  parse_time_to_seconds(b'0:00:15.723484'),
  parse_time_to_seconds(b'0:00:16.164435'),
  parse_time_to_seconds(b'0:00:15.974520'),
])
method_3_decryption_10000x = np.average([
  parse_time_to_seconds(b'0:00:15.821174'),
  parse_time_to_seconds(b'0:00:16.005561'),
  parse_time_to_seconds(b'0:00:15.880723'),
  parse_time_to_seconds(b'0:00:16.018448'),
  parse_time_to_seconds(b'0:00:15.704389'),
  parse_time_to_seconds(b'0:00:15.570855'),
  parse_time_to_seconds(b'0:00:16.029327'),
  parse_time_to_seconds(b'0:00:15.816719'),
  parse_time_to_seconds(b'0:00:16.069549'),
  parse_time_to_seconds(b'0:00:15.614441'),
])
data = {'Method 1': method_1_decryption_10000x, 'Method 2': method_2_decryption_10000x, 'Method 3': method_3_decryption_10000x}
print(data)
methods = list(data.keys())
values = list(data.values())
plt.bar(methods, values, color=(0.2, 0.4, 0.6, 0.6),width = 0.4)
plt.ylabel("Execution time (seconds)")
plt.savefig('01_03_decryption.png')
plt.clf()