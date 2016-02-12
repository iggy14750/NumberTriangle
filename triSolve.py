from math import sqrt


def row(e):
    return int((sqrt(1+8*e)-1)/2)

def elem(r):
    return int((r*(r+1))/2)

    

def n_ts(n,fullt):
    return elem(row(fullt)-row(n)+1)

def sub_ts(fullt):
    sum=0
    for i in range(1,row(fullt)):
        sum+=n_ts(elem(i),fullt)
    return int(sum+1)

"""filename="tittie.txt"
my_file=open(filename,'w')
for t in range(1,100):
    my_file.write(str(sub_ts(elem(t)))+"\n")
    #print("{} | {}".format(t,sub_ts(elem(t))))"""
    
#print(sub_ts(elem(1000)))