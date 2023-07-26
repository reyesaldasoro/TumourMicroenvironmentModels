
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


%% Find out the occurrence of different terms related to cancer AND pathology AND keywords:
clear all
allF                    = '%5BAll%20Fields%5D'; % all fields code
%allF2                    = '%5BMeSH%20Terms%5D'; % all fields code
basicURL                = 'https://www.ncbi.nlm.nih.gov/pubmed/?term=';

yearsAnalysis           = 2000:2023;                            
KW_TME            =  strcat('%20AND%20((%22tumor%20microenvironment%22)%20OR%20(%22tumour%20microenvironment%22))%20AND%20(model)');
KW_Dates                = strcat('%20AND%20(',num2str(yearsAnalysis(1)),':',num2str(yearsAnalysis(end)),'[dp])');
%%
keywords={ 'Macrophage','Pathways','Metabolism','Immune cells','Extracellular Matrix','Modulation','Proliferation',...
           'Therapeutic','Signalling','Oncogene','Hypoxia','Neutrophil','Stem cells','Crosstalk','Epigenetic',...
           'Migration','Metastasis','T cells','B cells','Target','Leukocytes','Dendritic cells','Stromal cells',...
           'Endothelial cells','Killer cells','Adipocytes','Stellate cells','Mitochondria','Angiogenesis',...
           'Fibroblast','Transcriptomics','Inflammation','Chemoresistance','Invasion','Survival','Extracellular vesicle','Cytokine','Pre-metastatic niche',...
           'Focal adhesion','Kinase','Integrin','Macroenvironment','Blood vessels','Anti-vascular',''};               
                       
numKeywords = numel(keywords);                       
   
%% Iterate over pubmed
%clear entries_per_KW
for index_kw=1:numKeywords
    kw=keywords{index_kw};
    
    urlAddress          = strcat(basicURL,'%20%28%22',strrep(kw,' ','%20'),'%22%29',KW_TME,KW_Dates);
    disp(index_kw)
    PubMedURL                           = urlread(urlAddress);

        location_init   = strfind(PubMedURL,'yearCounts');
        location_fin    = strfind(PubMedURL,'startYear');
        PubMedURL2      = strrep(PubMedURL(location_init+14:location_fin-11),' ','');
        PubMedURL2      = strrep(PubMedURL2,'"','');
        PubMedURL2      = strrep(PubMedURL2,']','');
        PubMedURL2      = strrep(PubMedURL2,'[','');
        years_tokens    = split(PubMedURL2,',');
        %num_entries   = str2num(cell2mat(years_tokens(2:2:end)));
        
        for index_year=1:2:numel(years_tokens)
            val_year    = str2double(years_tokens{index_year});
            num_entries = str2double(years_tokens{index_year+1});
            entries_per_KW(index_kw,round((val_year)-(yearsAnalysis(1)-1))) = num_entries;
        end
end
years         = str2num(cell2mat(years_tokens(1:2:end)));     
 
%% Obtain relative number of entries

% First, relative to all entries of the year without the keyword
entries_per_KW_rel  = entries_per_KW(1:numKeywords-1,:)./...
                        (1+repmat(entries_per_KW(numKeywords,:),[numKeywords-1 1]));
% Second, relative to the entries of the keywords                    
entries_per_KW_rel2 = entries_per_KW(1:numKeywords-1,:)./...
                        (repmat(sum(entries_per_KW(1:end-1,:)),[numKeywords-1 1]));


%%
k1                  = [1 4 18];   %grow  k1 = [1 4 18 20]; 
k2                  = [19 31 33]; % grow small k2=[19 31 33 36]; 
k3                  = [11 24 29 ]; % decrease k3 = [21 22 24 29 ];
k4                  = [5 6  16]; %steady k4 = [5 6 9 16];

h1=figure(14);
h411                = subplot(411);
h411a               = plot(entries_per_KW_rel2(k1,1:end)');
h1L                 = legend(keywords(k1),'Location','northwest');

h411a(1).LineWidth=2;h411a(3).LineWidth=2;
h411a(1).Color='b';         h411a(2).Color='m';         h411a(3).Color='k';         %h411a(4).Color=0.6*[1 1 1];
h411a(1).LineStyle = ':';   h411a(2).LineStyle = '-';   h411a(3).LineStyle = '-.'; %  h411a(4).LineStyle = '-';
grid on;axis tight

h412                = subplot(412);
h412a                = plot(entries_per_KW_rel2(k2,1:end)');
h2L                 = legend(keywords(k2),'Location','northwest');
h412a(1).LineWidth=2;h412a(3).LineWidth=2;
h412a(1).Color='b';         h412a(2).Color='m';         h412a(3).Color='k';        % h412a(4).Color=0.6*[1 1 1];
h412a(1).LineStyle = '-';   h412a(2).LineStyle = '-';   h412a(3).LineStyle = '-.';%   h412a(4).LineStyle = '-';
grid on;axis tight


h413                = subplot(413);
h413a                = plot(entries_per_KW_rel2(k3,1:end)');
h3L                 = legend(keywords(k3),'Location','northwest');
h413a(1).LineWidth=2;h413a(3).LineWidth=2;
h413a(1).Color='b';         h413a(2).Color='m';         h413a(3).Color='k';        % h413a(4).Color=0.6*[1 1 1];
h413a(1).LineStyle = ':';   h413a(2).LineStyle = '-';   h413a(3).LineStyle = '-.';%   h413a(4).LineStyle = '-';
grid on;axis tight

h414                = subplot(414);
h414a                = plot(entries_per_KW_rel2(k4,1:end)');
h4L                 = legend(keywords(k4),'Location','northwest');


h414a(1).LineWidth=2;h414a(3).LineWidth=2;
h414a(1).Color='b';         h414a(2).Color='m';         h414a(3).Color='k';         %h414a(4).Color=0.6*[1 1 1];
h414a(1).LineStyle = ':';   h414a(2).LineStyle = '-';   h414a(3).LineStyle = '-.'; %  h414a(4).LineStyle = '-';
grid on;axis tight

%
h411.Position  = [0.1 0.78 0.87 0.19 ];
h412.Position  = [0.1 0.53 0.87 0.19 ];
h413.Position  = [0.1 0.28  0.87 0.19 ];
h414.Position  = [0.1 0.04 0.87 0.19 ];

%
numYears        = numel(years);
h411.XTick        = (3:4:numYears);
h412.XTick        = (3:4:numYears);
h413.XTick        = (3:4:numYears);
h414.XTick        = (3:4:numYears);
h411.XTickLabel   = [];
h412.XTickLabel   = [];
h413.XTickLabel   = [];
h414.XTickLabel   = years(3:4:end);
% h411.XTick        = (3:4:numYears);
% h411.XTickLabel   = years(3:4:end);
% h412.XTick        = (3:4:numYears);
% h412.XTickLabel   = years(3:4:end);
% h413.XTick        = (3:4:numYears);
% h413.XTickLabel   = years(3:4:end);
% h414.XTick        = (3:4:numYears);
% h414.XTickLabel   = years(3:4:end);

h411.YLabel.String='';
h412.YLabel.String=strcat('Relative Number of Entries in PubMed');h412.YLabel.FontSize=16;
h413.YLabel.String='';
h414.YLabel.String='';

h411.Title.String='(a)';h411.Title.FontSize=12;
h412.Title.String='(b)';h412.Title.FontSize=12;
h413.Title.String='(c)';h413.Title.FontSize=12;
h414.Title.String='(d)';h414.Title.FontSize=12;

% h411.YLabel.String=strcat('Relative. Num. of',10,' Entries in PubMed');h411.YLabel.FontSize=10;
% h412.YLabel.String=strcat('Relative Number of Entries in PubMed');h412.YLabel.FontSize=10;
% h413.YLabel.String=strcat('Relative. Num. of',10,' Entries in PubMed');h413.YLabel.FontSize=10;
% h414.YLabel.String=strcat('Relative. Num. of',10,' Entries in PubMed');h414.YLabel.FontSize=10;
h412.YLabel.Position=[-0.09 0 -1];

%
%h411.YLabel.Position(1) = -0.09;
h412.YLabel.Position(1) = -0.09;
%h413.YLabel.Position(1) = -0.09;
%h414.YLabel.Position(1) = -0.09;

h1.Position = [ 40 140 700 600];

h412.YLabel.Position=[-0.5 0 -1];
h411.FontSize=11;
h412.FontSize=11;
h413.FontSize=11;
h414.FontSize=11;

h1L.BoxFace.ColorData   = uint8(255*[1 1 1 0.75]');
h1L.BoxFace.ColorType   = 'truecoloralpha';
h2L.BoxFace.ColorData   = uint8(255*[1 1 1 0.75]');
h2L.BoxFace.ColorType   = 'truecoloralpha';
h3L.BoxFace.ColorData   = uint8(255*[1 1 1 0.75]');
h3L.BoxFace.ColorType   = 'truecoloralpha';
h4L.BoxFace.ColorData   = uint8(255*[1 1 1 0.75]');
h4L.BoxFace.ColorType   = 'truecoloralpha';


%%
filename = 'Fig_3C_TrendsKeywordsYears.png';
print('-dpng','-r400',filename)