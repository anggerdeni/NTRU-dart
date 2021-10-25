import numpy as np

def parse_time_to_seconds(t):
  t = t.split(':')
  seconds = float(t[0])*(60*60)
  seconds += float(t[1])*(60)
  seconds += float(t[2])
  return seconds

x = []
with open('./03_keygen_method2.txt', 'r') as f:
    lines = f.readlines()
    for line in lines:
        x.append(parse_time_to_seconds(line[:-1]))

print(f'{np.average(x)}s / 10000 key gen')