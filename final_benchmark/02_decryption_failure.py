import matplotlib.pyplot as plt

x = []
y = []
with open('./02_decryption_failure.txt', 'r') as f:
    lines = f.readlines()
    for line in lines:
        tmp = line.split(': ')
        x.append(int(tmp[0]))
        y.append(int(tmp[1].split('/')[0]) / 10.0)


plt.ylabel("Percentage of decryption failure")
plt.xlabel("Value of q")
plt.plot(x, y)
plt.savefig('02_decryption failure.png')
plt.clf()
