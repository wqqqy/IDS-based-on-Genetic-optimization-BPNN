function error = fun(x,inputnum,hiddennum,outputnum,net,inputn,outputn)
%x           ����
%inputnum   �����ڵ��� 14
%outputnum  �����ڵ��� 3
%net         ����
%inputn     ѵ����������
%outputn    ѵ���������
%error      ������Ӧ��ֵ
w1=x(1:inputnum*hiddennum);
B1=x(inputnum*hiddennum+1:inputnum*hiddennum+hiddennum);
w2=x(inputnum*hiddennum+hiddennum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum);
B2=x(inputnum*hiddennum+hiddennum+hiddennum*outputnum+1:inputnum*hiddennum+hiddennum+hiddennum*outputnum+outputnum);

tmp=[0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1;0 1];
out=[0 1;];
net=newff(tmp,out,7,{},'traingd');%��������

net.trainParam.goal=0.00001;  %�趨ѵ�����
net.trainParam.epochs=100; %�趨���ѵ������;
net.trainParam.show=10; %ÿ���100����ʾһ��ѵ�����
net.trainParam.lr=0.05; %ѧϰ����0.05
net.trainParam.lr_inc = 1.05;
%����Ȩֵ��ֵ
net.iw{1,1}=reshape(w1,hiddennum,inputnum);%����Ȩֵ
net.lw{2,1}=reshape(w2,outputnum,hiddennum);%�����Ȩֵ
net.b{1}=reshape(B1,hiddennum,1);%������ֵ
net.b{2}=B2;%�������ֵ
%����ѵ��
disp('start training');
[net]=train(net,inputn,outputn);  %ѵ������
disp('finish traning');


%�������
ann=sim(net,inputn);
disp('finish sim');
error=sum(abs(ann-outputn));
disp(error);