function ret=Select(individuals,sizepop)
% individuals  种群信息
% sizepop      种群规模
% ret          选择后的新种群
fitness1=10./individuals.fitness; %individuals.fitness为个体适应度值
%个体选择概率
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness; 
%采用轮盘赌法选择新个体
index=[];
for i=1:sizepop   %转轮盘sizepop次
    pick=rand;
    while pick==0   
        pick=rand;       
    end
    for i=1:sizepop   
        pick=pick-sumf(i);       
        if pick<0       
            index=[index i];           
            break; 
        end  %寻找落入的区间，此次转轮盘选中了染色体i
    end
end
%新种群
individuals.chrom=individuals.chrom(index,:);   %individuals.chrom为种群中个体
individuals.fitness=individuals.fitness(index);
ret=individuals;