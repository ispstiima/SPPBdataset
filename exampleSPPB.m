%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%% EXAMPLE OF HOW TO USE THE DATASET %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% DATASET: datasetPaper.mat %%%% created by: Laura Romeo %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Contact: laura.romeo@stiima.cnr.it %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% PARAMETERS

clc
clear

multiplier = 0.5111;
user = 1;
nFeatures = 2;
load('walkingSet.mat')
nFrames = size(walkingSet{user,6}.skeletonJointsCx,1);

%% VISUALIZATION OF THE SKELETAL JOINTS

for i = 1:nFrames
    
    jointsR = walkingSet{user,6}.skeletonJointsDx{i}(:,1:2)./multiplier;
    jointsC = walkingSet{user,6}.skeletonJointsCx{i}(:,1:2)./multiplier;
    jointsL = walkingSet{user,6}.skeletonJointsSx{i}(:,1:2)./multiplier;
    
    
    set(gcf, 'Position',  [25, 200, 1500, 300])
    subplot(1,3,1)
    plot(jointsR(:,1),jointsR(:,2),'.','Markersize',18, 'Color', 'b')
    grid on
    axis([0 720 0 480])
    axis ij
    subplot(1,3,2)
    plot(jointsC(:,1),jointsC(:,2),'.','Markersize',18, 'Color', 'b')
    grid on
    axis([0 720 0 480])
    axis ij
    subplot(1,3,3)
    plot(jointsL(:,1),jointsL(:,2),'.','Markersize',18, 'Color', 'b')
    grid on
    axis([0 720 0 480])
    axis ij
    suptitle(['Walking exercise of patient ', walkingSet{user,1}, ' grabbed on ', walkingSet{user,2}])
    
    drawnow
end

%% VISUALIZATION OF THE EXTRACTED FEATURES
for i = 1:nFrames
    
    % Checks if the skeleton exist in the i-th frame
    if sum(walkingSet{user,6}.skeletonJointsCx{i}(:,4)>0) > 0
        joints(walkingSet{user,6}.skeletonJointsCx{i}(:,4),1:4) = ...
            walkingSet{user,6}.skeletonJointsCx{i}(:,1:4);
        
        nTotJoints = numel(joints(:,4));
        hUser = max(joints(joints(:,2)>0,2)) - min(joints(joints(:,2)>0,2));
        jointsW = -ones(2,2);
        featureVectorW(i,1:nFeatures) = -ones(nFeatures,1);
        
        for j = 1:nTotJoints
            
            % Store the joints according to their IDs
            if joints(j,4) == 2
                jointsW(1,1:2) = joints(j,1:2)./multiplier;
            end
            if joints(j,4) == 12
                jointsW(2,1:2) = joints(j,1:2)./multiplier;
            end
            if joints(j,4) == 11
                jointsW(3,1:2) = joints(j,1:2)./multiplier;
            end
            if joints(j,4) == 14
                jointsW(4,1:2) = joints(j,1:2)./multiplier;
            end
        end
       
        % Body Posture, calculated considering the projection in the x-axis
        % of the segment between the neck and the hips
        % (Neck ID = 2, Left Hip ID = 12)
        if jointsW(1,1)<0 || jointsW(2,1)<0
            bodyP = -1;
        else
            % If both joints exsist, the value can be calculated
            bodyP = pdist(jointsW(1:2,1),'euclidean') / hUser;
        end
        
        % Feet distance, (Right Foot ID = 11, Left Foot ID = 14)
        if jointsW(3,1)<0 || jointsW(4,1)<0
            FFdist = -1;
        else
            FFdist = pdist(jointsW(3:4,1),'euclidean') / hUser;
        end
        
        feat = [bodyP; FFdist];
        
        featureVectorW(i, 1:nFeatures) = feat;
    end
end

featureVectorWtime(:,1) = interp(double(featureVectorW(:,1)),50);
featureVectorWtime(:,2) = interp(double(featureVectorW(:,2)),50);

figure
set(gcf, 'Position',  [100, 100, 1800, 600])
subplot(1,2,1)
plot(1:size(featureVectorWtime,1), featureVectorWtime(:,2), 'Linewidth', 2)
xlabel('execution time [ms]')
ylabel('walking width')
title('Walking width')
axis([0 size(featureVectorWtime,1) 0 1])
grid on
subplot(1,2,2)
plot(1:size(featureVectorWtime,1), featureVectorWtime(:,1), 'Linewidth', 2)
xlabel('execution time [ms]')
ylabel('body posture')
axis([0 size(featureVectorWtime,1) 0 1])
title('Body posture')
grid on
suptitle(['Walking exercise of patient ', walkingSet{user,1}, ' grabbed on ', walkingSet{user,2}])