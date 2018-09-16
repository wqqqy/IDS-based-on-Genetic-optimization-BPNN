function ret=Cross(pcross,lenchrom,chrom,sizepop,bound)
% pcorss   交叉概率
% lenchrom 染色体
% chrom    染色体群
% sizepop  种群规模
% ret     交叉后的染色体
 for i=1:sizepop  % 随机选择两个染色体进行交叉
     pick=rand(1,2);
     while prod(pick)==0
         pick=rand(1,2);
     end
     index=ceil(pick.*sizepop);
     % 交叉概率决定是否进行交叉
     pick=rand;
     while pick==0
         pick=rand;
     end
     if pick>pcross
         continue;
     end
         % 随机选择交叉位
         pick=rand;
         while pick==0
             pick=rand;
         end
         pos=ceil(pick.*sum(lenchrom)); %随机选择进行交叉的位置
         pick=rand; %交叉开始
         v1=chrom(index(1),pos);
         v2=chrom(index(2),pos);
         chrom(index(1),pos)=pick*v2+(1-pick)*v1;
         chrom(index(2),pos)=pick*v1+(1-pick)*v2; %交叉结束
 end
ret=chrom;
 