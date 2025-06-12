import random as rd

a = []

for i in range(0, 10, 1):
    b = rd.randint(0, 100)
    a.append(b)
print(a)

for i in range(0, 10, 1):
    for j in range(0, 9, 1):
        if a[j] < a[j + 1]:
            temp = a[j]
            a[j] = a[j + 1]
            a[j + 1] = temp

print(a)
