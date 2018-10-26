t = tcpip('0.0.0.0',4000,'NetworkRole','Server')  
fopen(t)  
data = fread(t,t.BytesAvailable)  
fwrite(t,'hello back')  