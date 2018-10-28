1 install https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix and run the demo
2 install https://github.com/ybsong00/Vital_release/tree/master/vital and run the demo
tips:
better use conda create 

3 copy the python code in gans to the pytorch-CycleGAN-and-pix2pix directories
4 copy the drone2kitti0_cyclegan to the pytorch-CycleGAN-and-pix2pix/checkpoints
5 as the sever end:
 python serverbatch.py 

change the IP address to localhost, if your network is not stable.

6 copy everything of mdnet into the Vital_release directories and replace all the same codes
7 put the dataset into dataset dir.
 cd tracking run the demo_tracking
8 change the directories paths in 
gan_mdnet_features_convX.m
10 bug fixed change the line 19 in gan_mdnet_features_convX.m 
to 
save ('batch.mat', 'batch','-v6');

