function ret=Mutation(pmutation,lenchrom,chrom,sizepop,num,maxgen,bound)
% pmutation �������
% lenchrom  Ⱦɫ�峤��
% chrom   Ⱦɫ��Ⱥ
% sizepop ��Ⱥ��ģ
% opts �췽����ѡ��
% pop  ��ǰ��Ⱥ�Ľ������������Ľ���������Ϣ
% bound ÿ������ȡֵ��Χ
% maxgen ����������
% num  ��ǰ��������
% ret ������Ⱦɫ��
for i=1:sizepop   
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);
    % ������ʾ�������ѭ���Ƿ���б���
    pick=rand;
    if pick>pmutation
        continue;
    end
        % ����λ��
        pick=rand;
        while pick==0     
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));%���ѡ����Ⱦɫ������λ��
        pick=rand; %���쿪ʼ    
        fg=(rand*(1-num/maxgen))^2;
        if pick>0.5
            chrom(i,pos)=chrom(i,pos)+(bound(pos,2)-chrom(i,pos))*fg;
        else
            chrom(i,pos)=chrom(i,pos)-(chrom(i,pos)-bound(pos,1))*fg;
        end   %�������
end
ret=chrom;