function ret=Code(lenchrom,bound)
% lenchrom  Ⱦɫ��
% bound   ������ȡֵ��Χ
% ret    Ⱦɫ��ı���ֵ
pick=rand(1,length(lenchrom));
ret=bound(:,1)'+(bound(:,2)-bound(:,1))'.*pick; %ʵ������