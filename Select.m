function ret=Select(individuals,sizepop)
% individuals  ��Ⱥ��Ϣ
% sizepop      ��Ⱥ��ģ
% ret          ѡ��������Ⱥ
fitness1=10./individuals.fitness; %individuals.fitnessΪ������Ӧ��ֵ
%����ѡ�����
sumfitness=sum(fitness1);
sumf=fitness1./sumfitness; 
%�������̶ķ�ѡ���¸���
index=[];
for i=1:sizepop   %ת����sizepop��
    pick=rand;
    while pick==0   
        pick=rand;       
    end
    for i=1:sizepop   
        pick=pick-sumf(i);       
        if pick<0       
            index=[index i];           
            break; 
        end  %Ѱ����������䣬�˴�ת����ѡ����Ⱦɫ��i
    end
end
%����Ⱥ
individuals.chrom=individuals.chrom(index,:);   %individuals.chromΪ��Ⱥ�и���
individuals.fitness=individuals.fitness(index);
ret=individuals;