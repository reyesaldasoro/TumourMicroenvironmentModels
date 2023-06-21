%% Text mining of PubMed for Tumour Microenvironment
% Ratios of the Cancer entries related to organ-specific keywords. The trends have
% been ranked and presented according to (a) largest increase, (b) intermediate
% increase and (c) largest decrease from 1950s to 2016.
%
% Author: Constantino Carlos Reyes-Aldasoro
%--------------------------------------------------------------------------
%
% This m-file is part of a series of queries on PubMed to investigate the number of
% entries related to Cancer and other conditions. The manuscript has been submitted
% for publication in PLOS ONE
%--------------------------------------------------------------------------
%     These files are distributed as free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, version 3 of the License.
%
%     These files are  distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
%
% The author shall not be liable for any errors or responsibility for the accuracy,
% completeness, or usefulness of any information, or method in the content, or for
% any actions taken in reliance thereon.
%--------------------------------------------------------------------------

close all
cd('C:\Users\sbbk034\OneDrive - City, University of London\Documents\GitHub\TumourMicroenvironmentModels\CODE')
%%
clear all

%% Find out the occurrence of different terms related to cancer AND pathology AND keywords:

allF                    = '%5BAll%20Fields%5D'; % all fields code
%allF2                    = '%5BMeSH%20Terms%5D'; % all fields code
basicURL                = 'https://www.ncbi.nlm.nih.gov/pubmed/?term=';

yearsAnalysis           = 2000:2023;                            
KW_TME            =  strcat('%20AND%20((%22cancer%20microenvironment%22)%20OR%20(%22tumor%20microenvironment%22)%20OR%20(%22tumour%20microenvironment%22))');
KW_Dates                = strcat('%20AND%20(',num2str(yearsAnalysis(1)),':',num2str(yearsAnalysis(end)),'[dp])');

keywords={  'Animal model','Mouse model','Rat model','Zebrafish model','Xenograft model','In vivo model','Mice model',...%'model disease'
            'In vitro model','Tumor on a chip','Microfluidic model','3D Bioprinting','Organ on a chip','Organoid model','Spheroid model',...             %'3D model',...
            'Mechanistic Model','Scoring model','Prediction model','Risk model','Integrative model','Mathematical model','Prognostic model',...
            'In silico model','Computational model','Deep Learning model','Machine Learning model','Convolutional Neural Network','Agent-based model',''};
colormap3 =[[0.8 0 0]+rand(7,3)/10;...
            [0 0.6 0]+rand(7,3)/10;...             % [0.5 0.5 0.5];...
            [0 0.2 0.8]+rand(7,3)/10;...
            [0.6 0.3 0.0]+rand(6,3)/10];         
                       
numKeywords = numel(keywords);                       
keywords2 ={'Bladder','Bone','Bowel','Brain','Breast','Cervical','Colon','Colorectal','Gastric','Intestinal','Kidney','Leukaemia','Liver','Lung','Lymphoma',...
    'Melanoma','Mouth','Ovarian','Pancreas','Pituitary','Prostate','Sarcoma','Stomach','Testicular','Thyroid','Uterus','Uterine',''};
numKeywords2 = numel(keywords2);     
%% Iterate over pubmed
%clear entries_per_KW
% First Loop, over the Models:
for index_kw=1%:numKeywords
    kw=keywords{index_kw};
    
    urlAddress          = strcat(basicURL,'%20%28%22',strrep(kw,' ','%20'),'%22%29',KW_TME,KW_Dates);
    disp(index_kw)
    PubMedURL                           = urlread(urlAddress);
        % This is to read the counts per year
        % location_init   = strfind(PubMedURL,'yearCounts');
        % location_fin    = strfind(PubMedURL,'startYear');
        % PubMedURL2      = strrep(PubMedURL(location_init+14:location_fin-11),' ','');
        % PubMedURL2      = strrep(PubMedURL2,'"','');
        % PubMedURL2      = strrep(PubMedURL2,']','');
        % PubMedURL2      = strrep(PubMedURL2,'[','');
        % years_tokens    = split(PubMedURL2,',');
        % %num_entries   = str2num(cell2mat(years_tokens(2:2:end)));
        % for index_year=1:2:numel(years_tokens)
        %     val_year    = str2double(years_tokens{index_year});
        %     num_entries = str2double(years_tokens{index_year+1});
        %     entries_per_KW(index_kw,round((val_year)-(yearsAnalysis(1)-1))) = num_entries;
        % end
        % This reads the total counts (all years)  AND DOES NOT ADD TO THE
        % SAME AS ABOVE!
        location_init       = strfind(PubMedURL,'totalResults: parseInt("');
        location_fin        = strfind(PubMedURL,'itemsPerPage: parseInt("');
        PubMedURL3          = strrep(PubMedURL(location_init+24:location_fin-15),' ','');
        totEntries_per_KW(index_kw,1)   = str2double(PubMedURL3);
        
        % second loop over the organs

        for index_kw2=1:numKeywords2
            kw2=keywords2{index_kw2};
            urlAddress          = strcat(basicURL,kw2,'%20AND%20','%20%28%22',strrep(kw,' ','%20'),'%22%29',KW_TME,KW_Dates);
            PubMedURL                           = urlread(urlAddress);
            location_init       = strfind(PubMedURL,'totalResults: parseInt("');
            location_fin        = strfind(PubMedURL,'itemsPerPage: parseInt("');
            PubMedURL4          = strrep(PubMedURL(location_init+24:location_fin-15),' ','');
            totEntries_per_KW(index_kw,1+index_kw2)   = str2double(PubMedURL4);
        end


end
%years         = str2num(cell2mat(years_tokens(1:2:end)));     
      
%%
totEntries_per_KW2=totEntries_per_KW(1:end-1,2:end-1);
totEntries_per_KW2(isnan( totEntries_per_KW2))=0;

[~,index_model]=sort(sum(totEntries_per_KW2,2),'descend');
[~,index_organ]=sort(sum(totEntries_per_KW2,1),'descend');
%%
h01=figure(7);
h01.Position = [100  100  700  410];
h1 = subplot(1,1,1);
hB= bar3(2+totEntries_per_KW2(index_model,index_organ)');
axis tight

h1.XTick=1:numKeywords;
h1.XTickLabel=keywords(index_model);
h1.XTickLabelRotation=270;
h1.YTick=1:numKeywords2;
h1.YTickLabel=keywords2(index_organ);
h1.YTickLabelRotation=270;
colormap(colormap3(index_model,:))
axis normal

h1.View=[+48 30];
h1.Position     = [ 0.05    0.34    0.92   0.65];
h1.FontSize = 8.7;
%%

filename = '../Figures/Fig_F_ModelsOrgans_1.png';
print('-dpng','-r400',filename)
%%

h01=figure(8);
h01.Position = [100  100  700  410];
h1 = subplot(1,1,1);
hB= bar3(2+totEntries_per_KW2(index_model,index_organ)');
%axis tight

h1.XTick=1:numKeywords;
h1.XTickLabel=keywords(index_model);
h1.XTickLabelRotation=270;
h1.YTick=1:numKeywords2;
h1.YTickLabel=keywords2(index_organ);
h1.YTickLabelRotation=270;
colormap(colormap3(index_model,:))
axis normal

h1.View=[+48 30];


h1.FontSize = 10.7;
h1.Position     = [ 0.06    0.26    0.92   0.74];
 h1.XLim=[0.6 11.5];
 h1.YLim=[0.6 9.5];
 h1.ZLim= [0   485];
%%
filename = '../Figures/Fig_G_ModelsOrgans_2.png';
print('-dpng','-r400',filename)

%%
figure
h1=gca;
hB= bar3(1+totEntries_per_KW2(:,:)');
axis tight

h1.XTick=1:numKeywords;
h1.XTickLabel=keywords(:);
h1.XTickLabelRotation=270;
h1.YTick=1:numKeywords2;
h1.YTickLabel=keywords2(:);
h1.YTickLabelRotation=270;




%%
entries_per_group(1,:)   = sum(entries_per_KW(1:7,:));
entries_per_group(2,:)   = sum(entries_per_KW(8:14,:));
entries_per_group(3,:)   = sum(entries_per_KW(15:22,:));
entries_per_group(4,:)   = sum(entries_per_KW(23:27,:));
colormap4 =[[0.8 0 0]+rand(1,3)/10;...
            [0 0.6 0]+rand(1,3)/10;...             % [0.5 0.5 0.5];...
            [0 0.2 0.8]+rand(1,3)/10;...
            [0.6 0.3 0.0]+rand(1,3)/10]; 
totals_per_group          = sum(entries_per_group,2);
%% Display as bar chart
h01=figure(1);
h20=gca;

allEntries_KW = sum(entries_per_KW(1:end-1,:),2);
[entries_all,index_all]=sort(allEntries_KW,'ascend');
h21=bar(allEntries_KW(index_all(end:-1:1)));
%h21=bar(allEntries_KW(index_all(end:-1:1))/sum(entries_per_KW(end,:)));
h20.XTick=1:numKeywords-1;
h20.XTickLabel=keywords(index_all(end:-1:1));
h20.XTickLabelRotation=270;
%h20.FontSize = 11;
h20.FontSize=10;
h20.YLabel.FontSize=14;

h20.YLabel.String='Num. Entries in PubMed';
h01.Position = [100  100  700  410];
h20.Position     = [ 0.09    0.45    0.9   0.52];
h20.FontName='Arial';
h20.XLim=[0.25 numKeywords-0.25];
h20.YLim=[0.5*min(entries_all) 1.2*max(entries_all)];
h20.YScale = 'log';

grid on
 h21.FaceColor = 'flat';
for i = 1:numKeywords-1
    h21.CData(i,:) = colormap3(index_all(numKeywords-i),:);
    h20.XTickLabel{i} = [sprintf('\\color[rgb]{%f,%f,%f}%s',colormap3(index_all(numKeywords-i),:)) h20.XTickLabel{i}];
end
%%
hLegend = annotation(h01,'textbox',...
    [0.64 0.74 0.33 0.2],...
    'String',{  strcat('Model Organisms:',32,32,32,32,32,32,32,32,32,num2str(totals_per_group(1))),...
                strcat('Mathematical models:',32,32,32,num2str(totals_per_group(3))),...
                strcat('In Vitro models:',32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,num2str(totals_per_group(2))),...
                strcat('Computational models:',32,32,32,num2str(totals_per_group(4)))},...
    'FitBoxToText','off');

hBox_MO=annotation(h01,'rectangle',[0.91 0.89 0.05 0.03],'FaceColor',colormap3(1,:));
hBox_Ma=annotation(h01,'rectangle',[0.91 0.85 0.05 0.03],'FaceColor',colormap3(8,:));
hBox_IV=annotation(h01,'rectangle',[0.91 0.81 0.05 0.03],'FaceColor',colormap3(15,:));
hBox_Co=annotation(h01,'rectangle',[0.91 0.77 0.05 0.03],'FaceColor',colormap3(22,:));

%%
filename = '../Figures/Fig_A_DifferentModels.png';
print('-dpng','-r400',filename)

%% Display as ribbons per model
%[entries_all,index_all]=sort(allEntries_KW,'descend');


%numYears        = numel(years);
numYears        = round((val_year)-yearsAnalysis(1)-1);
initialYear     = 1;
h02              = figure(22);
h1              = gca;
h11             = ribbon(1+entries_per_KW(index_all(end:-1:1),1:end-1)');
h1.YTick        = (1:5:numYears);
h1.YTickLabel   = years(1:5:end);
%h1.YLim         = [initialYear numYears+1];
h1.XTick        = (1:numKeywords);
h1.XTickLabel   = keywords(index_all(end:-1:1));
%h1.XLim         = [1 numKeywords];
%h1.ZLim         = [0 max(max(entries_per_KW(1:end-1,initialYear:end)))];
h1.XTickLabelRotation=270;
h1.View         = [ -355 15];
h1.FontSize     = 10;
axis tight
h1.ZLabel.String='Num. Entries in PubMed';
h1.ZLabel.FontSize=12;
h1.YLabel.String='Years';
h1.YLabel.FontSize=12;
h02.Position = [100  100  700  410];
h1.Position     = [ 0.11    0.47    0.78    0.50];
h1.ZScale = 'log';
%colormap3 = 0.8*jet(numKeywords-1);
%colormap3 = 0.8*rand(numKeywords-1,3);
colormap (colormap3(index_all(end:-1:1),:))
for i = 1:numKeywords-1
    h1.XTickLabel{i} = [sprintf('\\color[rgb]{%f,%f,%f}%s',colormap3(index_all(numKeywords-i),:)) h1.XTickLabel{i}];
end
%%
filename = '../Figures/Fig_B_DifferentModels.png';
%print('-dpng','-r400',filename)
%% Display as ribbons per group 


h03              = figure(23);
h3              = gca;

h33             = ribbon(1+entries_per_group');

h3.YTick        = (1:5:numYears);
h3.YTickLabel   = years(1:5:end);
%h3.YLim         = [initialYear numYears+1];


h3.XTick        = (1:4);
h3.XTickLabel   = {'Model organism','In vitro model','Mathematical model','Computational model'};
%h3.XLim         = [1 numKeywords];
%h3.ZLim         = [0 max(max(entries_per_KW(1:end-1,initialYear:end)))];
h3.XTickLabelRotation=0;
h3.View         = [ 63 31];
h3.FontSize     = 10;
axis tight
h3.ZLabel.String='Num. Entries in PubMed';
h3.ZLabel.FontSize=12;
h3.YLabel.String='Years';
h3.YLabel.FontSize=12;

h03.Position = [100  100  700  410];
h3.Position     = [ 0.1449    0.0973    0.8094    0.8727];
h3.ZScale = 'log';
%colormap3 = 0.8*jet(numKeywords-1);
%colormap3 = 0.8*rand(numKeywords-1,3);
colormap (colormap4)


 for i = 1:4
     h3.XTickLabel{i} = [sprintf('\\color[rgb]{%f,%f,%f}%s',colormap4(i,:)) h3.XTickLabel{i}];
 end



 h3.ZScale='log';

%%
filename = '../Figures/Fig_C_DifferentModels.png';
print('-dpng','-r400',filename)

%% Obtain relative number of entries

% First, relative to all entries of the year without the keyword
entries_per_KW_rel  = entries_per_KW(1:numKeywords-1,:)./...
                        (1+repmat(entries_per_KW(numKeywords,:),[numKeywords-1 1]));
% Second, relative to the entries of the keywords                    
entries_per_KW_rel2 = entries_per_KW(1:numKeywords-1,:)./...
                        (repmat(sum(entries_per_KW(1:end-1,:)),[numKeywords-1 1]));

%% Display as relative metrics
h03              = figure(3);
h2              = subplot(211);
h22             = ribbon(entries_per_KW_rel2(index_all,:)');
h2.YTick        = (1:5:numYears);
h2.YTickLabel   = years(1:5:end);
%h2.YLim         = [initialYear numYears+1];
h2.XTick        = (1:numKeywords);
h2.XTickLabel   = keywords(index_all);
%h2.XLim         = [1 numKeywords];
%h2.ZLim         = [0 max(max(entries_per_KW_rel2(:,initialYear:end)))];
h2.XTickLabelRotation=270;
h2.View         = [ 170   30];
h2.FontSize     = 10;
axis tight
%h2.ZLabel.String='Entries/Keyword Total';
h2.ZLabel.String='Rel. Num. Entries';
h2.ZLabel.FontSize=14;
h2.YLabel.String='Years';
h2.YLabel.FontSize=14;
%h03.Position = [100  100  700  410];

h03.Position = [100  100  700  410];

%h2.XTickLabel=[];
h2.Position     = [ 0.11    0.32    0.8605    0.65];

%h3.Position     = [ 0.11    0.26    0.8605    0.35];
% h3.FontName='Arial';
filename = 'Fig_B_TrendsTechniquesYears.png';
%print('-dpng','-r400',filename)
h2.YLabel.FontSize=12;
% h3.YLabel.FontSize=12;
h2.ZLabel.FontSize=11;
% h3.ZLabel.FontSize=11;
h2.ZLabel.Position = [ 28.5769    0.1747    0.1823];
% h3.ZLabel.Position = [22.6    0.5034    0.0265];
%%
% for i = 1:numKeywords-1
%     h2.XTickLabel{i} = [sprintf('\\color[rgb]{%f,%f,%f}%s',colormap3(i,:)) h2.XTickLabel{i}];
% end

