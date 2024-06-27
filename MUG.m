PATH = 'E:\MUG\points';
FILES = dir([PATH,'\*.pts']);

lmrk = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
    
lenT = nchoosek(length(lmrk),3);
% Fuzzy Tringel Sinature
TSS = zeros(length(FILES),lenT);
% Fuzzy Tringel Sinature
FTS = zeros(length(FILES),lenT,5);
% Centroid Distance Signature
CDS = zeros(length(FILES),lenT,6);

emotions = {'an','di','fe','ha','sa','su'}; 
EMO = zeros(1,length(FILES));
% Centroid Distance Signature
%CDS = zeros(length(FILES),lenT,8);
% no of images --> length(FILES)
% no of tringels --> lenT
% no of fuzzy measures --> 5

%EXP = zeros(length(FILES),1);

h = waitbar(0,'Please wait computing Signatures ...');

for i = 1:length(FILES)
    disp(i)
    
    name = FILES(i).name;
    folder = FILES(i).folder;
    foldername = [folder,'\',name];
    %EXP(i) = dlmread(foldername);
    
    % Get Emotions
    for j = 1:length(emotions)
        if contains(name,emotions{j})
            EMO(i) = j;
        end
    end
    
    temp = dlmread(foldername);
    pts = temp(lmrk,:);
        
    %TSS(i,:) = tringle_side_signature(pts); % mu_i
    CDS(i,:,:) = centroid_distance_signature(pts); %di/ri
    %FTS(i,:,:) = fuzzy_tringle_signature(pts);
    
    waitbar(i / length(FILES))
    
end

close(h)

I = eye(7);
EMO2 = I(EMO+1,:);


        
        