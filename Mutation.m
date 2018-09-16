function ret=Mutation(pmutation,lenchrom,chrom,sizepop,num,maxgen,bound)
% pmutation 变异概率
% lenchrom  染色体长度
% chrom   染色体群
% sizepop 种群规模
% opts 异方法的选择
% pop  当前种群的进化代数和最大的进化代数信息
% bound 每个个体取值范围
% maxgen 最大迭代次数
% num  当前迭代次数
% ret 变异后的染色体
for i=1:sizepop   
    pick=rand;
    while pick==0
        pick=rand;
    end
    index=ceil(pick*sizepop);
    % 变异概率决定该轮循环是否进行变异
    pick=rand;
    if pick>pmutation
        continue;
    end
        % 变异位置
        pick=rand;
        while pick==0     
            pick=rand;
        end
        pos=ceil(pick*sum(lenchrom));%随机选择了染色体变异的位置
        pick=rand; %变异开始    
        fg=(rand*(1-num/maxgen))^2;
        if pick>0.5
            chrom(i,pos)=chrom(i,pos)+(bound(pos,2)-chrom(i,pos))*fg;
        else
            chrom(i,pos)=chrom(i,pos)-(chrom(i,pos)-bound(pos,1))*fg;
        end   %变异结束
end
ret=chrom;