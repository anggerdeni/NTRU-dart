from lll import *
import timeit

class Unbuffered(object):
   def __init__(self, stream):
       self.stream = stream
   def write(self, data):
       self.stream.write(data)
       self.stream.flush()
   def writelines(self, datas):
       self.stream.writelines(datas)
       self.stream.flush()
   def __getattr__(self, attr):
       return getattr(self.stream, attr)

import sys
sys.stdout = Unbuffered(sys.stdout)


def generate_matrix(h, q):
       l = len(h)
       one_mtx = [1] + [0 for _ in range(l-1)]
       mat = []
       for i in range(l):
              tmp = one_mtx + h
              mat.append(tmp)
              one_mtx = [one_mtx[-1]]+one_mtx[:-1]
              h = [h[-1]]+h[:-1]
       
       q_mtx = [q] + [0 for _ in range(l-1)]
       zero_mtx = [0 for _ in range(l)]
       for i in range(l):
              tmp = zero_mtx + q_mtx
              mat.append(tmp)
              q_mtx = [q_mtx[-1]]+q_mtx[:-1]
       return mat

def check_if_f_found(f, mtx_lll):
       l = len(f)
       mtx = [[int(y) for y in x[:l]] for x in mtx_lll]

       for row in mtx:
              tmp_row = row
              for i in range(l):
                     if(tmp_row == f):
                            return True
                     tmp_row = [tmp_row[-1]] + tmp_row[:-1]
       return False

f_s = []
h_s = []

"""
"""

# -----------
f_s.append([3, 0, -3, -3, -3, 0, 0, -3, 3, 0, 3, 0, 3, 0, 0, 0, 3, -3, 3, 3, -3, 3, 3, -3, -3, 0, 3, 3, 0, -3, 0, 0, -3, 0, -3, -3, 0, 0, 3, 1])
h_s.append([1245, 1918, 1937, 913, 1080, 616, 867, 1249, 1504, 496, 1588, 330, 181, 127, 1511, 1587, 1580, 574, 1538, 1053, 1019, 565, 578, 219, 1696, 872, 1421, 1547, 1403, 1414, 1754, 1398, 1419, 266, 1777, 164, 1884, 742, 403, 576])
# -----------
f_s.append([0, 0, 0, -3, 3, 0, -3, 0, -3, 3, -3, 3, 3, 3, 0, -3, 3, 0, -3, -3, 0, 0, -3, 0, 3, 0, 0, 3, -3, 3, 0, -3, 0, 3, 0, 0, -3, -3, 3, 3, 1])
h_s.append([1560, 1662, 607, 132, 1232, 1262, 890, 1865, 1328, 2030, 2023, 1981, 462, 502, 1978, 1776, 642, 925, 535, 1361, 61, 458, 232, 1212, 1437, 733, 1887, 1185, 1848, 953, 1812, 1667, 548, 932, 1962, 774, 105, 742, 1585, 1259, 962])


"""
"""


for i in range(len(f_s)):
       start = timeit.default_timer()
       mat = generate_matrix(h_s[i], 2048)
       mat1 = create_matrix(mat)
       mat1pass = lll_reduction(mat1)
       stop = timeit.default_timer()
       if(check_if_f_found(f_s[i], mat1pass)):
              print(f'N {len(f_s[i])} broken in {stop-start} s')
       else:
              print(f'N {len(f_s[i])} unbroken')