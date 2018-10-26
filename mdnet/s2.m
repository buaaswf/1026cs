clc
clear

data_all=['/home/swf/swfcode/gan/pytorch-CycleGAN-and-pix2pix-master/'];%用于存储所有的数据
t = tcpip('219.224.168.43', 8888, 'Timeout', 60,'InputBufferSize',10240);%连接这个ip和这个端口的UDP服务器
%t.BytesAvailableFcnMode='byte'
while(1)
    fopen(t);
    ori = '/home/swf/swfcode/gan/pytorch-CycleGAN-and-pix2pix-master/datasets/drone2kitti0/drone0/0/60251_img0000619.jpg';
    fwrite(t,ori);%发送一段数据给tcp服务器。服务器好知道matlab的ip和端口
    while(1) %轮询，直到有数据了再fread
        nBytes = get(t,'BytesAvailable');
        if nBytes>0
            break;
        end
    end
    receive = fread(t,nBytes);%读取tcp服务器传来的数据
    %fread(t);
    fclose(t);
    %data=str2num(char(receive(2:end-1)')); %将ASCII码转换为str，再将str转换为数组
    data=char(receive(1:end)'); %将ASCII码转换为str，再将str转换为数组
    data_name=[data_all,data];
    data
    pause(0.0001);
    figure(2);
    imshow(imread(data_name));
    figure(3);
    imshow(imread(ori));
    %plot(data)
end
delete(t);
