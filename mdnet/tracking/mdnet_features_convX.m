function [ feat ] = mdnet_features_convX(net, img, boxes, opts)
% MDNET_FEATURES_CONVX
% Extract CNN features from bounding box regions of an input image.
%
% Hyeonseob Nam, 2015
% 

n = size(boxes,1);
ims = mdnet_extract_regions(img, boxes, opts);
nBatches = ceil(n/opts.batchSize_test);

t = tcpip('219.224.168.43', 54377, 'Timeout', 60,'InputBufferSize',10240);%连接这个ip和这个端口的UDP服务器
for i=1:nBatches
%     fprintf('extract batch %d/%d...\n',i,nBatches);
    
    batch = ims(:,:,:,opts.batchSize_test*(i-1)+1:min(end,opts.batchSize_test*i));
%     save batch.mat batch;
%     ori = '/home/swf/swfcode/matlab/Vital_release-master/tracking/batch.mat'
%     data_all=['/home/swf/swfcode/gan/pytorch-CycleGAN-and-pix2pix-master/'];%用于存储所有的数据
% %t.BytesAvailableFcnMode='byte'
%     fopen(t);
%     %ori = '/home/swf/swfcode/gan/pytorch-CycleGAN-and-pix2pix-master/datasets/drone2kitti0/drone0/0/60251_img0000619.jpg';
%     fwrite(t,ori);%发送一段数据给tcp服务器。服务器好知道matlab的ip和端口
%     while(1) %轮询，直到有数据了再fread
%         nBytes = get(t,'BytesAvailable');
%         if nBytes>0
%             break;
%         end
%     end
%     receive = fread(t,nBytes);%读取tcp服务器传来的数据
%     %fread(t);
%     fclose(t);
%     %data=str2num(char(receive(2:end-1)')); %将ASCII码转换为str，再将str转换为数组
%     data=char(receive(1:end)'); %将ASCII码转换为str，再将str转换为数组
%     data_name=[data_all,data];
%     data
%     pause(0.0001);
%     data=load(data_name);
%     batch=struct('batch',single(data.batch));
%     
    
    
%     if(opts.useGpu)
%         batch = gpuArray(batch.batch);
%     end
    if(opts.useGpu)
        batch = gpuArray(batch);
    end
    
    res = vl_simplenn(net, batch, [], [], ...
        'disableDropout', true, ...
        'conserveMemory', true, ...
        'sync', true) ;
    
    f = gather(res(end).x) ;
    if ~exist('feat','var')
        feat = zeros(size(f,1),size(f,2),size(f,3),n,'single');
    end
    feat(:,:,:,opts.batchSize_test*(i-1)+1:min(end,opts.batchSize_test*i)) = f;
end
delete(t);
