function ret=Cross(pcross,lenchrom,chrom,sizepop,bound)
% pcorss   �������
% lenchrom Ⱦɫ��
% chrom    Ⱦɫ��Ⱥ
% sizepop  ��Ⱥ��ģ
% ret     ������Ⱦɫ��
 for i=1:sizepop  % ���ѡ������Ⱦɫ����н���
     pick=rand(1,2);
     while prod(pick)==0
         pick=rand(1,2);
     end
     index=ceil(pick.*sizepop);
     % ������ʾ����Ƿ���н���
     pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>pcross
         continue;
     end
         % ���ѡ�񽻲�λ
         pick=rand;
         while pick==0
             pick=rand;
         end
         pos=ceil(pick.*sum(lenchrom)); %���ѡ����н����λ��
         pick=rand; %���濪ʼ
         v1=chrom(index(1),pos);
         v2=chrom(index(2),pos);
         chrom(index(1),pos)=pick*v2+(1-pick)*v1;
         chrom(index(2),pos)=pick*v1+(1-pick)*v2; %�������
 end
ret=chrom;
 