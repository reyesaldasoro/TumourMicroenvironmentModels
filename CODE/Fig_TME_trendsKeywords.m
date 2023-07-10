k1 = [1 4 18];   %grow  k1 = [1 4 18 20]; 
k2=[19 31 33]; % grow small k2=[19 31 33 36]; 
k3 = [11 24 29 ]; % decrease k3 = [21 22 24 29 ];
k4 = [5 6  16]; %steady k4 = [5 6 9 16];

h1=figure(14);
h411                = subplot(411);
h411a               = plot(entries_per_KW_rel2(k1,1:end)');
h1L                 = legend(keywords(k1),'Location','northwest');

h411a(1).LineWidth=2;h411a(3).LineWidth=2;
h411a(1).Color='b';         h411a(2).Color='m';         h411a(3).Color='k';         %h411a(4).Color=0.6*[1 1 1];
h411a(1).LineStyle = ':';   h411a(2).LineStyle = '-';   h411a(3).LineStyle = '--'; %  h411a(4).LineStyle = '-';
grid on;axis tight

h412                = subplot(412);
h412a                = plot(entries_per_KW_rel2(k2,1:end)');
h2L                 = legend(keywords(k2),'Location','northwest');
h412a(1).LineWidth=2;h412a(3).LineWidth=2;
h412a(1).Color='b';         h412a(2).Color='m';         h412a(3).Color='k';        % h412a(4).Color=0.6*[1 1 1];
h412a(1).LineStyle = '-';   h412a(2).LineStyle = '-';   h412a(3).LineStyle = '--';%   h412a(4).LineStyle = '-';
grid on;axis tight


h413                = subplot(413);
h413a                = plot(entries_per_KW_rel2(k3,1:end)');
h3L                 = legend(keywords(k3),'Location','northwest');
h413a(1).LineWidth=2;h413a(3).LineWidth=2;
h413a(1).Color='b';         h413a(2).Color='m';         h413a(3).Color='k';        % h413a(4).Color=0.6*[1 1 1];
h413a(1).LineStyle = ':';   h413a(2).LineStyle = '-';   h413a(3).LineStyle = '--';%   h413a(4).LineStyle = '-';
grid on;axis tight

h414                = subplot(414);
h414a                = plot(entries_per_KW_rel2(k4,1:end)');
h4L                 = legend(keywords(k4),'Location','northwest');


h414a(1).LineWidth=2;h414a(3).LineWidth=2;
h414a(1).Color='b';         h414a(2).Color='m';         h414a(3).Color='k';         %h414a(4).Color=0.6*[1 1 1];
h414a(1).LineStyle = ':';   h414a(2).LineStyle = '-';   h414a(3).LineStyle = '--'; %  h414a(4).LineStyle = '-';
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
filename = 'Fig_3B_TrendsKeywordsYears.png';
print('-dpng','-r400',filename)