im=imread('Test_image.png');
im=im(:,:,1);
palette=unique(im)
if length(palette)>4
    msgbox('The color number is up to 4, results are unpredictable !');
end
[height,width,null]=size(im);
flag=0;
for i=1:1:height
    for j=1:1:width
        if im(i,j)==128;im(i,j)=170;
            flag=1;
        end
    end
end
imwrite(im,'Test_image.png');
if flag==1
    disp('A color has been swapped')
else
    disp('No color has been changed')
end
