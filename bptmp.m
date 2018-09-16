load test
load abnormal
load normal


x=test';
%c=mapminmax(x,0,1);
%x=c;
y=zeros(1,5000);
for i=1:5000
    y(i)=1;
end
xi=mapminmax(x, 0, 1);
yo=mapminmax(y, 0, 1);
tmp=[0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1];
out=[0 1;];
bpnet=newff(tmp,out,7,{},'traingd');%构建网络
bpnet.trainParam.goal=0.00001;  %设定训练误差
bpnet.trainParam.epochs=100; %设定最大训练步数;
bpnet.trainParam.show=10; %每间隔100步显示一次训练结果
bpnet.trainParam.lr=0.05; %学习速率0.05
bpnet.trainParam.lr_inc = 1.05;
[bpnet]=train(bpnet,xi,yo);  %训练网络

%%%%%%%%%%%%%%%遗传算法开始
maxgen=30;                          %进化代数
sizepop=20;                         %种群规模
pcross=[0.8];                       %交叉概率
pmutation=[0.1];                    %变异概率

inputnum=14;%输入层个数
hiddennum=7;%隐含层个数
outputnum=1;%输出层个数

numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;%节点总数
lenchrom=ones(1,numsum);%个体长度  

bound=[-2*ones(numsum,1) 2*ones(numsum,1)];%数据范围[-2 2]
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);%将种群信息定义为一个结构体

avgfitness=[];%平均适应度
bestfitness=[];%最佳适应度
bestchrom=[];%适应度最好的个体

for i=1:sizepop
    %随机产生一个种群
    individuals.chrom(i,:)=Code(lenchrom,bound); 
    xx=individuals.chrom(i,:);
    %计算适应度
    %%%%%% net训练好的网络 inputn输入层 outputn输出层
    individuals.fitness(i)=fun(xx,inputnum,hiddennum,outputnum,bpnet,xi,yo);   %染色体的适应度
end
[bestfitness bestindex]=min(individuals.fitness);%找最好的染色体
bestchrom=individuals.chrom(bestindex,:);  %最好的染色体
avgfitness=sum(individuals.fitness)/sizepop; %染色体的平均适应度
trace=[avgfitness bestfitness];% 记录每一代进化中最好的适应度和平均适应度
for i=1:maxgen
    %选择
    individuals=Select(individuals,sizepop);
    avgfitness=sum(individuals.fitness)/sizepop;
    %交叉
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    %变异
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    %计算适应度
    for j=1:sizepop
        xx=individuals.chrom(j,:); 
        individuals.fitness(j)=fun(xx,inputnum,hiddennum,outputnum,bpnet,xi,yo);   %染色体的适应度 
    end
    %找到最小和最大适应度的染色体及它们在种群中的位置
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % 代替上一次进化中最好的个体
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;   
    avgfitness=sum(individuals.fitness)/sizepop;
    trace=[trace;avgfitness bestfitness]; %记录每一代进化中最好的适应度和平均适应度
end
figure(1);
[r c]=size(trace);
subplot(1,2,1);
plot([1:r]',trace(:,1),'b--');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('平均适应度');
subplot(1,2,2);
plot([1:r]',trace(:,2),'r*');
title(['适应度曲线  ' '终止代数＝' num2str(maxgen)]);
xlabel('进化代数');ylabel('最佳适应度');


%将权值赋值给网络

xx=bestchrom;
w1=xx(1:inputnum*hiddennum);
B1=xx(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=xx(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=xx(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);
bpnet.iw{1,1}=reshape(w1,hiddennum,inputnum);%隐层权值
bpnet.lw{2,1}=reshape(w2,outputnum,hiddennum);%输出层权值
bpnet.b{1}=reshape(B1,hiddennum,1);%隐层阈值

bpnet.trainParam.goal=0.00001;  %设定训练误差
bpnet.trainParam.epochs=100; %设定最大训练步数;
bpnet.trainParam.show=10; %每间隔100步显示一次训练结果
bpnet.trainParam.lr=0.05; %学习速率0.05
bpnet.trainParam.lr_inc = 1.05;

%网络训练
disp('start training');
[bpnet]=train(bpnet,xi,yo);  %训练网络
disp('finish traning');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%遗传算法增加的内容



%y2=sim(bpnet,x);    %输出数据
%p=[0 1 1 1 1032 0 0 0 511 511 0.00 0.00 1.00 255];
p=[0 1 1 1 219 0 0 0 6 6 0.00 0.00 1.00 39;
   0 1 1 1 141 0 0 0 12 17 0.00 0.00 1.00 12];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55统计误报率
 %a1=mapminmax(test,0,1);
% p1=a1'
 p1=normal';
 pp=mapminmax(p1, 0, 1);
r1=sim(bpnet,pp);

%display(r');

[s1 , s2] = size( r1 ) ;
hitNum1 = 0 ;
for i = 1 : s2
    if(r1(i)>=0.8 && r1(i)<=1.2)
        hitNum1 = hitNum1 + 1 ; 
    end
end


%%%%%%%%%%%%%%%检测率漏报率
 %a2=mapminmax(wubao,0,1);
 %p2=a2'
 p2=abnormal';
 pp2=mapminmax(p2, 0, 1);
r2=sim(bpnet,pp2);

%display(r');
[s1 , s2] = size( r2 ) ;
hitNum2 = 0 ;
for i = 1 : s2
    if(r2(i)>=0.8 && r2(i)<=1.2)
        hitNum2 = hitNum2 + 1 ; 
    end
end
sprintf('误报率是 %3.3f%%',(100 *  (900 - hitNum1) / 900))
sprintf('检测率是 %3.3f%%',(100 * (900 - hitNum2) / 900))
sprintf('漏报率是 %3.3f%%',100 * hitNum2 / 900)






