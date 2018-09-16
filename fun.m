function error = fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn)
%x           个体
%inputnum   输入层节点数 14
%outputnum  输出层节点数 3
%net         网络
%inputn     训练输入数据
%outputn    训练输出数据
%error      个体适应度值
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

tmp=[0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1];
out=[0 1;];
net=newff(tmp,out,7,{},'traingd');%构建网络

net.trainParam.goal=0.00001;  %设定训练误差
net.trainParam.epochs=100; %设定最大训练步数;
net.trainParam.show=10; %每间隔100步显示一次训练结果
net.trainParam.lr=0.05; %学习速率0.05
net.trainParam.lr_inc = 1.05;
%网络权值赋值
net.iw{1,1}=reshape(w1,hiddennum,inputnum);%隐层权值
net.lw{2,1}=reshape(w2,outputnum,hiddennum);%输出层权值
net.b{1}=reshape(B1,hiddennum,1);%隐层阈值
net.b{2}=B2;%输出层阈值
%网络训练
disp('start training');
[net]=train(net,inputn,outputn);  %训练网络
disp('finish traning');


%计算误差
ann=sim(net,inputn);
disp('finish sim');
error=sum(abs(ann-outputn));
disp(error);