%MUG2
PATH = 'C:\DB\MUG_FACES';
FILES = dir([PATH,'\*.jpg']);

lmrk = [18,20,22,23,25,27,37,38,41,40,43,44,47,46,32,34,36,49,55,52,58];
emotions = {'an','di','fe','ha','sa','su'};     
EMO = zeros(1,length(FILES));

HOG = cell(length(FILES),1);
LBP = cell(length(FILES),1);
TSS = zeros(length(FILES),nchoosek(length(lmrk),3));


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
    
    img = imread(foldername);
    
    if length(size(img)) == 3
        img = rgb2gray(img);
    end
    
    img = imresize(img,[150,100]);
    img = adapthisteq(img);
    
    HOG0 = extractHOGFeatures(img,'CellSize',[4 4],'BlockSize'...
        ,[4 4],'BlockOverlap',[1 1],'NumBins',9);
    HOG1 = extractHOGFeatures(img,'CellSize',[8 8],'BlockSize'...
        ,[3 3],'BlockOverlap',[1 1],'NumBins',9);
    HOG2 = extractHOGFeatures(img,'CellSize',[16 16],'BlockSize'...
        ,[2 2],'BlockOverlap',[1 1],'NumBins',9);
    HOG3 = extractHOGFeatures(img,'CellSize',[32 32],'BlockSize'...
        ,[2 2],'BlockOverlap',[1 1],'NumBins',9);
    HOG{i} = [HOG0,HOG1,HOG2,HOG3];
    
    LBP0 = extractLBPFeatures(img,'CellSize',[8 8],...
        'Normalization','L2');
    LBP1 = extractLBPFeatures(img,'CellSize',[16 16],...
        'Normalization','L2');
    LBP2 = extractLBPFeatures(img,'CellSize',[32 32],...
        'Normalization','L2');
    LBP{i} = [LBP0,LBP1,LBP2];
    
    %TSS(i,:) = tringle_side_signature(pts); % mu_i
    
    waitbar(i / length(FILES))
    
end

close(h)

% DATAH
DATAH = cell2mat(HOG);
DATAH(isnan(DATAH)) = 0;
SM = sum(DATAH);
IND = SM > 20;
DATAH2 = DATAH(:,IND);
DATAH2 = hnormalize(DATAH2);
% DATAL
DATAL = cell2mat(LBP);
DATAL(isnan(DATAL)) = 0;
SM = sum(DATAL);
IND = SM > 10;
DATAL2 = DATAL(:,IND);
DATAL2 = hnormalize(DATAL2);
% % Normalize TSS
%DATASIG = hnormalize(TSS);

DATA2 = [DATAH2,DATAL2];%,DATASIG];

I = eye(7);
EMO2 = I(EMO+1,:); 

        
        