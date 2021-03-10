function jigsawu()
%% ����ʽ
Mark_A= rand_pic();%��ӛ����y
drawpic(Mark_A);
 
global Mark;%Mark��ӛ���
Mark=Mark_A;
set(gcf,'windowButtonDownFcn',@ButtonDownFcn);%�c�������{��ButtonDownFcn��ʽ
 
function ButtonDownFcn(src,event)
%% ���{�����������c���¼��l���r�{��
pt=get(gca,'CurrentPoint');%�����c������
xpos=pt(1,1);
ypos=pt(1,2);
   
col = ceil(xpos/100);
row = ceil(ypos/100);
 
global Mark; %׃����
 
if(col <= 3 && col >0)&&(row <= 3 && row > 0)   
    Mark=shiftjig(Mark,row,col);
    
    drawpic(Mark)%show jigsaw
    
    order = [1 2 3;4 5 6;7 8 0];
    zt = abs(Mark-order);%���^���
    if sum(zt(:))==0
        F=imread('ntut-cover.jpg');
        image=imresize(F,[300 300]);
        imshow(image) 
        msgbox('You did a good job ,��ϲ����ɣ�����','Success','warn') 
        pause(1);
       % close all 
    end
else
    return
end
 
function Mark=shiftjig(Mark,row,col)
 
    num = Mark(row,col);%���λ���������һ��
    if (row > 1)&&(Mark(row-1,col)==0)%Mark(row-1,col)0���λ��
        Mark(row-1,col) = num;
        Mark(row,col) = 0;
    end
    if (row < 3)&&(Mark(row+1,col)==0)
        Mark(row+1,col) = num;
        Mark(row,col) = 0;
    end
    if (col > 1)&&(Mark(row,col-1)==0)
        Mark(row,col-1) = num;
        Mark(row,col) = 0;
    end
    if (col < 3)&&(Mark(row,col+1)==0)
        Mark(row,col+1) = num;
        Mark(row,col) = 0;
    end
   
 
 
function y = rand_pic()
%% �Y���S�C���ɼ��[��
y =[1,2,3;4,5,6;7,8,0];
 
for i = 1:360
    row=randi([1,3]);
    col=randi([1,3]);
    y=shiftjig(y,row,col);
end
 
 
 
function x = choose(image,index)
%% 
if index > 0 
    % Ӌ��row��column
    row=fix((index-1)/3);
    column=mod(index-1,3);
    % �ָ��ƴ�D�K�Y��
    x=image(1+row*100:100*(row+1),1+column*100:100*(column+1),:);
else
    x=uint8(255*ones(100,100,3));%ƴ�D�K0���
end

function drawpic(A)
F=imread('ntut-cover.jpg');
origin = imresize(F,[300 300]);
image=origin;
 
% ��ƴ�D�xֵ
for row=1:3
    for col=1:3
    image(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=choose(origin,A(row,col));
    end
end
imshow(image)
