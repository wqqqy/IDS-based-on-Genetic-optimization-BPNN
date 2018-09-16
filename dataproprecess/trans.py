import string,csv  

protocol_type = []  
service = []  
flag = []  
attack_type = []  
dos_type = ['back','land','neptune','pod','smurf','teardrop']  
probe_type = ['ipsweep','nmap','portsweep','satan']  
r2l_type = ['ftp_write','guess_passwd','imap','multihop','phf','spy','warezclient','warezmaster']  
u2r_type = ['buffer_overflow','loadmodule','perl','rootkit']  

def main():  
    print ("data dealing...")  
    writer=csv.writer(open('allout','w'),delimiter=" ")  
    reader=csv.reader(open('all','r'))  
    for line in reader:  
            #protocol  
            if line[1] in protocol_type:  
                    pass   #not do deal  
            else:  
                    protocol_type.append(line[1])  
            protocol_index = protocol_type.index(line[1])+1  
            line[1]=protocol_index  
            #service  
            if line[2] in service:  
                    pass #not do deal  
            else:  
                    service.append(line[2])  
            service_index = service.index(line[2])+1  
            line[2] = service_index  
            #flag  
            if line[3] in flag:  
                    pass #not do deal  
            else:  
                    flag.append(line[3])  
            flag_index = flag.index(line[3])+1  
            line[3] = flag_index  
            # #type  
            # line[41] = ''.join(line[41].split('.'))  
            # if line[41] == 'normal':  
                    # line[41] = 1  
            # elif line[41] in dos_type:  
                    # line[41] = 2  
            # elif line[41] in probe_type:  
                    # line[41] = 3  
            # elif line[41] in r2l_type:  
                    # line[41] = 4  
            # elif line[41] in u2r_type:  
                    # line[41] = 5  

            removelist=[5,6,8,9,11,12,13,14,15,17,18,19,20,21,24,25,29,30,32,33,34,35,36,37,38,39,40,41]
            x = 0
            for y in removelist:
				line.pop(y-x)
				x+=1
			# temp = line[41]  
            # line.insert(0,temp)  
            # del line[42]  
            # for k in range(1,len(line)):  
                    # k2str = str(k) + ':'  
                    # line[k] = k2str + str(line[k])  
            writer.writerow(line)  

if __name__=="__main__":  
            main()  
