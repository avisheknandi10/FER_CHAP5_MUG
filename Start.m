PATH = 'C:\DB\MMI\';
FILES = dir([PATH,'\*.pts']);

lmrk = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
    
lenT = nchoosek(length(lmrk),3);
% Fuzzy Tringel Sinature
FTS = zeros(length(FILES),lenT,5);
% Centroid Distance Signature
CDS = zeros(length(FILES),lenT,6);
% Tringel Side Signature
TSS = zeros(length(FILES),lenT);
% no of images --> length(FILES)
% no of tringels --> lenT
% no of fuzzy measures --> 5
emotions = {'an','di','fe','ha','sa','su','ne'}; 
EMO = zeros(1,length(FILES));

%EXP = zeros(length(FILES),1);

h = waitbar(0,'Please wait computing Signatures ...');

for i = 1:length(FILES)
    disp(i)
    
    name = FILES(i).name;
    folder = FILES(i).folder;
    foldername = [folder,'\',name];
    %EXP(i) = dlmread(foldername);
    
    for j = 1:length(emotions)
        if contains(name,emotions{j})
            EMO(i) = j;
        end
    end
    
    temp = dlmread(foldername);
    pts = temp(lmrk,:);
        
    %FTS(i,:,:) = fuzzy_tringle_signature(pts); % mu_i
    CDS(i,:,:) = centroid_distance_signature(pts); %di/ri
    %TSS(i,:) = triangle_side_signature(pts);
    
    waitbar(i / length(FILES))
    
end

close(h)

%Prepare Input Data for training
% InputFTS = zeros(length(FILES),5);
% InputCDS = zeros(length(FILES),6);
% 
% for i = 1:length(FILES)
%     InputFTS(i,:) = sum(squeeze(FTS(i,:,:)));
%     InputCDS(i,:) = sum(squeeze(CDS(i,:,:)));
% end
% 
% InputFTS = InputFTS/lenT;
% InputCDS = InputCDS/lenT;
% 
% %Prepare Output Data
I = eye(6);
EMO2 = I(EMO,:);
% [~,pos] = max(FTS,[],3);
% pos1 = reshape(pos,[],1);
% histogram(pos1, 5, 'Normalization','probability')

        
        