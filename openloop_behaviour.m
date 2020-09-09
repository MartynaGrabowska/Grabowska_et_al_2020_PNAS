% % 
% % %% Import data from text file
% % % Script for importing data from the following text file:
% % %
% % %    filename: D:\experiments_PNAS\Open-loop Behaviour\StimululationEphys10Hz_Jul 22_Fly_1_Trial_7.txt
% % %
% % % Auto-generated by MATLAB on 29-Jul-2020 10:54:57
% 
% DataFolder = 'C:\Users\uqmgrabo\Desktop\openloop_behaviour\ATR\Config1\c1_bbb_bsb\'
% 
% files = dir(fullfile(DataFolder, '*.txt'));
% files([files.isdir])=[];
% 
% numFiles = length(files);
% 
% for ii=1:length(files)
% %% Setup the Import Options
% opts = delimitedTextImportOptions("NumVariables", 13);
% 
% % Specify range and delimiter
% opts.DataLines = [2, Inf];
% opts.Delimiter = " ";
% 
% % Specify column names and types
% opts.VariableNames = ["TiMoDa", "XV", "YV", "XPo", "TV", "PetV", "TiSt", "ThInt", "BarAng", "ForVel", "MagActual", "ToBarVel", "DistWlkd"];
% opts.VariableTypes = ["double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double", "double"];
% opts.ExtraColumnsRule = "ignore";
% opts.EmptyLineRule = "read";
% opts.ConsecutiveDelimitersRule = "join";
% opts.LeadingDelimitersRule = "ignore";
% 
% % Import the data
% tbl = readtable('C:\Users\uqmgrabo\Desktop\openloop_beheaviour\Config1\c1_bbb_bsb\*.txt', opts);
% 
% %% Convert to output type
% TiMoDa = tbl.TiMoDa;
% XV = tbl.XV;
% YV = tbl.YV;
% XPo = tbl.XPo;
% TV = tbl.TV;
% PetV = tbl.PetV;
% TiSt = tbl.TiSt;
% ThInt = tbl.ThInt;
% BarAng = tbl.BarAng;
% ForVel = tbl.ForVel;
% MagActual = tbl.MagActual;
% ToBarVel = tbl.ToBarVel;
% DistWlkd = tbl.DistWlkd;
% 
% %% Clear temporary variables
% clear opts tbl
% 
% end
% 
% 
% 



figure
comet(XV5,YV5)

%TVall=[TV;TV1;TV2;TV3;TV4;TV5;TV6;TV7;TV8;TV9;TV10;TV11;TV12;TV13;TV14;TV15;TV16;TV17;TV18;TV19;TV20;TV21;TV22;TV23;TV24;TV25;TV26;TV27;TV28;TV29;TV30];


TVall=TV;TV1;TV2;TV3;TV4;TV5;TV6;TV7;TV8;TV9;TV10];

TVrad=circ_ang2rad(TV);
figure
circ_plot(TVrad,'hist',[],20,true,true,'linewidth',2,'color','r')
view([90 -90])


r=circ_r(TVrad)
meanangle=circ_mean(TVrad);
meanangledeg=circ_rad2ang(meanangle)




%downsample data 

XVdown=downsample(XV,180);
YVdown=downsample(YV,180);


%get coordinates 

P0 = [XVdown(2,:),YVdown(2,:)];
P1 = [XVdown(1,:),YVdown(1,:)];
P2 = [XVdown(3,:),YVdown(3,:)];

%calculate the angle between the three points 
n1 = (P2 - P0) / norm(P2 - P0);  % Normalized vectors
n2 = (P1 - P0) / norm(P1 - P0);

anglerad = atan2(norm(det([n1; n2])), dot(n1, n2)); 
angledeg=rad2deg(anglerad);


comet(XVdown,YVdown)
%%
%calculate the turns 1=left and 0= right turn

TVdown=downsample(TV10,180);
TVwrapped=wrapTo180(TVdown);

figure;
plot(TVwrapped)


for i=1:length(TVwrapped)-1
    if TVwrapped(i+1,:)>= TVwrapped(i,:)
        turn(i,:)=1;
    else 
        turn(i,:)=0;
    end 
end 

figure;
plot(turn,'o')

meanturn=mean(turn)

%%

N=length(turn);
x=1:1:length(turn);
colorMap = [zeros(N, 1), zeros(N, 1), ones(N,1)];
for k = 1 : length(turn)
  if turn(k) > 0.5
    colorMap(k, :) = [1,0,0]; % Red
  else
    colorMap(k, :) = [0,0,1]; % Blue
  end
end

\


