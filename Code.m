function ret=Code(lenchrom,bound)
% lenchrom  染色体
% bound   变量的取值范围
% ret    染色体的编码值
pick=rand(1,length(lenchrom));
ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %实数编码