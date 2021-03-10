function jigsawu()
%% 主函式
Mark_A= rand_pic();%標記順序打亂
drawpic(Mark_A);
 
global Mark;%Mark標記矩陣
Mark=Mark_A;
set(gcf,'windowButtonDownFcn',@ButtonDownFcn);%點擊滑鼠調用ButtonDownFcn函式
 
function ButtonDownFcn(src,event)
%% 回調函數，滑鼠點擊事件發生時調用
pt=get(gca,'CurrentPoint');%滑鼠點擊坐標
xpos=pt(1,1);
ypos=pt(1,2);
   
col = ceil(xpos/100);
row = ceil(ypos/100);
 
global Mark; %變量聲明
 
if(col <= 3 && col >0)&&(row <= 3 && row > 0)   
    Mark=shiftjig(Mark,row,col);
    
    drawpic(Mark)%show jigsaw
    
    order = [1 2 3;4 5 6;7 8 0];
    zt = abs(Mark-order);%比較矩陣
    if sum(zt(:))==0
        F=imread('ntut-cover.jpg');
        image=imresize(F,[300 300]);
        imshow(image) 
        msgbox('You did a good job ,恭喜您完成！！！','Success','warn') 
        pause(1);
       % close all 
    end
else
    return
end
 
function Mark=shiftjig(Mark,row,col)
 
    num = Mark(row,col);%鼠标位置与号码牌一致
    if (row > 1)&&(Mark(row-1,col)==0)%Mark(row-1,col)0矩陣位置
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
%% 資料隨機生成及擺放
y =[1,2,3;4,5,6;7,8,0];
 
for i = 1:360
    row=randi([1,3]);
    col=randi([1,3]);
    y=shiftjig(y,row,col);
end
 
 
 
function x = choose(image,index)
%% 
if index > 0 
    % 計算row及column
    row=fix((index-1)/3);
    column=mod(index-1,3);
    % 分割出拼圖塊資料
    x=image(1+row*100:100*(row+1),1+column*100:100*(column+1),:);
else
    x=uint8(255*ones(100,100,3));%拼圖塊0矩陣
end

function drawpic(A)
F=imread('ntut-cover.jpg');
origin = imresize(F,[300 300]);
image=origin;
 
% 對拼圖賦值
for row=1:3
    for col=1:3
    image(1+(row-1)*100:100*row,1+(col-1)*100:100*col,:)=choose(origin,A(row,col));
    end
end
imshow(image)
