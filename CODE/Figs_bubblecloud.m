clear all
close all
%%
load('Results_Model_Organ.mat')

keywords={  'Animal model','Mouse model','Rat model','Zebrafish model','Xenograft model','In vivo model','Mice model',...%'model disease'
            'In vitro model','Tumor on a chip','Microfluidic model','3D Bioprinting','Organ on a chip','Organoid model','Spheroid model',...             %'3D model',...
            'Mechanistic Model','Scoring model','Prediction model','Risk model','Integrative model','Mathematical model','Prognostic model',...
            'In silico model','Computational model','Deep Learning model','Machine Learning model','Convolutional Neural Network','Agent-based model'};

keywords3={  'Animal','Mouse','Rat','Zeb','Xeno','In Vivo','Mice',...%'model disease'
            'In Vitro','T Chip','Microfl','3D Bio','Or Chip','Organoid','Spher',...             %'3D model',...
            'Mechan','Scor','Pred','Risk','Integr','Math','Progn',...
            'Silico','Compt','D.L.','M.L.','CNN','Agent'};


colormap3 =[[0.8 0 0]+rand(7,3)/10;...
            [0 0.6 0]+rand(7,3)/10;...             % [0.5 0.5 0.5];...
            [0 0.2 0.8]+rand(7,3)/10;...
            [0.6 0.3 0.0]+rand(6,3)/10];         
                       
numKeywords = numel(keywords);                       
keywords2 ={'Bladder','Bone','Bowel','Brain','Breast','Cervical','Colon','Colorectal','Gastric','Intestinal','Kidney','Leukaemia','Liver','Lung','Lymphoma',...
    'Melanoma','Mouth','Ovarian','Pancreas','Pituitary','Prostate','Sarcoma','Stomach','Testicular','Thyroid','Uterus','Uterine'};
numKeywords2 = numel(keywords2);  

totEntries_per_KW2=totEntries_per_KW(1:end-1,2:end-1);
totEntries_per_KW2(isnan( totEntries_per_KW2))=0;


[~,index_model]=sort(sum(totEntries_per_KW2,2),'descend');
[~,index_organ]=sort(sum(totEntries_per_KW2,1),'descend');

%%
totEntries_per_KW3 = totEntries_per_KW2(:,index_organ);
clear t1 t2 t3 t4

row=0;
for k1=[5 2 21 18 1 17 8]  % 1:27
    % loop over the model
    [a1,a2] = sort(totEntries_per_KW2(k1,:),'descend'  );
    for k2=1:27
        % loop over the organ
        %row = k2+27*(k1-1);
        row=row+1;

        t1(row,1)    = a1(k2);
        t2{row,1}    = keywords{k1};
        t3{row,1}    = keywords2{a2(k2)};

%        t1(row,1)    = 0+totEntries_per_KW2(k1,k2);
%        t2{row,1}    = keywords3{k1};
%        t3{row,1}    = keywords2{k2};
        
    end
end
%t2(t1==0)=[];
%t3(t1==0)=[];
%t1(t1==0)=[];

t4=table((t1).^1.2,t2,t3,'VariableNames',["Cases" "Model" "Organ"] );


figure(1)
b=bubblecloud(t4,"Cases","Model","Organ");
b.FontSize=8;
figure(2)
d=bubblecloud(t4,"Cases","Organ","Model");
d.FontSize=8;