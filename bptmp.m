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
bpnet=newff(tmp,out,7,{},'traingd');%��������
bpnet.trainParam.goal=0.00001;  %�趨ѵ�����
bpnet.trainParam.epochs=100; %�趨���ѵ������;
bpnet.trainParam.show=10; %ÿ���100����ʾһ��ѵ�����
bpnet.trainParam.lr=0.05; %ѧϰ����0.05
bpnet.trainParam.lr_inc = 1.05;
[bpnet]=train(bpnet,xi,yo);  %ѵ������

%%%%%%%%%%%%%%%�Ŵ��㷨��ʼ
maxgen=30;                          %��������
sizepop=20;                         %��Ⱥ��ģ
pcross=[0.8];                       %�������
pmutation=[0.1];                    %�������

inputnum=14;%��������
hiddennum=7;%���������
outputnum=1;%��������

numsum=inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum;%�ڵ�����
lenchrom=ones(1,numsum);%���峤��  

bound=[-2*ones(numsum,1) 2*ones(numsum,1)];%���ݷ�Χ[-2 2]
individuals=struct('fitness',zeros(1,sizepop), 'chrom',[]);%����Ⱥ��Ϣ����Ϊһ���ṹ��

avgfitness=[];%ƽ����Ӧ��
bestfitness=[];%�����Ӧ��
bestchrom=[];%��Ӧ����õĸ���

for i=1:sizepop
    %�������һ����Ⱥ
    individuals.chrom(i,:)=Code(lenchrom,bound); 
    xx=individuals.chrom(i,:);
    %������Ӧ��
    %%%%%% netѵ���õ����� inputn����� outputn�����
    individuals.fitness(i)=fun(xx,inputnum,hiddennum,outputnum,bpnet,xi,yo);   %Ⱦɫ�����Ӧ��
end
[bestfitness bestindex]=min(individuals.fitness);%����õ�Ⱦɫ��
bestchrom=individuals.chrom(bestindex,:);  %��õ�Ⱦɫ��
avgfitness=sum(individuals.fitness)/sizepop; %Ⱦɫ���ƽ����Ӧ��
trace=[avgfitness bestfitness];% ��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
for i=1:maxgen
    %ѡ��
    individuals=Select(individuals,sizepop);
    avgfitness=sum(individuals.fitness)/sizepop;
    %����
    individuals.chrom=Cross(pcross,lenchrom,individuals.chrom,sizepop,bound);
    %����
    individuals.chrom=Mutation(pmutation,lenchrom,individuals.chrom,sizepop,i,maxgen,bound);
    %������Ӧ��
    for j=1:sizepop
        xx=individuals.chrom(j,:); 
        individuals.fitness(j)=fun(xx,inputnum,hiddennum,outputnum,bpnet,xi,yo);   %Ⱦɫ�����Ӧ�� 
    end
    %�ҵ���С�������Ӧ�ȵ�Ⱦɫ�弰��������Ⱥ�е�λ��
    [newbestfitness,newbestindex]=min(individuals.fitness);
    [worestfitness,worestindex]=max(individuals.fitness);
    % ������һ�ν�������õĸ���
    if bestfitness>newbestfitness
        bestfitness=newbestfitness;
        bestchrom=individuals.chrom(newbestindex,:);
    end
    individuals.chrom(worestindex,:)=bestchrom;
    individuals.fitness(worestindex)=bestfitness;   
    avgfitness=sum(individuals.fitness)/sizepop;
    trace=[trace;avgfitness bestfitness]; %��¼ÿһ����������õ���Ӧ�Ⱥ�ƽ����Ӧ��
end
figure(1);
[r c]=size(trace);
subplot(1,2,1);
plot([1:r]',trace(:,1),'b--');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('ƽ����Ӧ��');
subplot(1,2,2);
plot([1:r]',trace(:,2),'r*');
title(['��Ӧ������  ' '��ֹ������' num2str(maxgen)]);
xlabel('��������');ylabel('�����Ӧ��');


%��Ȩֵ��ֵ������

xx=bestchrom;
w1=xx(1:inputnum*hiddennum);
B1=xx(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=xx(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=xx(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);
bpnet.iw{1,1}=reshape(w1,hiddennum,inputnum);%����Ȩֵ
bpnet.lw{2,1}=reshape(w2,outputnum,hiddennum);%�����Ȩֵ
bpnet.b{1}=reshape(B1,hiddennum,1);%������ֵ

bpnet.trainParam.goal=0.00001;  %�趨ѵ�����
bpnet.trainParam.epochs=100; %�趨���ѵ������;
bpnet.trainParam.show=10; %ÿ���100����ʾһ��ѵ�����
bpnet.trainParam.lr=0.05; %ѧϰ����0.05
bpnet.trainParam.lr_inc = 1.05;

%����ѵ��
disp('start training');
[bpnet]=train(bpnet,xi,yo);  %ѵ������
disp('finish traning');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�Ŵ��㷨���ӵ�����



%y2=sim(bpnet,x);    %�������
%p=[0 1 1 1 1032 0 0 0 511 511 0.00 0.00 1.00 255];
p=[0 1 1 1 219 0 0 0 6 6 0.00 0.00 1.00 39;
   0 1 1 1 141 0 0 0 12 17 0.00 0.00 1.00 12];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55ͳ������
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


%%%%%%%%%%%%%%%�����©����
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
sprintf('������ %3.3f%%',(100 *  (900 - hitNum1) / 900))
sprintf('������� %3.3f%%',(100 * (900 - hitNum2) / 900))
sprintf('©������ %3.3f%%',100 * hitNum2 / 900)






