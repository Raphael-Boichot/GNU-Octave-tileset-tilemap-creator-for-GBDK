clc;
clear;
close all;
a=imread("Test_image.png");
figure('Position',[100 100 1100 700]);
subplot(1,2,1)
imshow(a)
[height, width, ~]=size(a);
unique_tiles=-1*ones(8,8);
a=a(:,:,1);
palette=unique(a);
if length(palette)>4
    msgbox('The color number is up to 4, results are unpredictable !');
end

Black=palette(1);
Dgray=palette(2);
Lgray=palette(3);
White=palette(4);

hor_tile=width/8;
vert_tile=height/8;
tile=0;
H=1;
L=1;
H_tile=1;
L_tile=1;

%this part searches for unique tiles and their positions
disp('Searching for unique tiles');
total_tiles=hor_tile*vert_tile;
for x=1:1:hor_tile
    for y=1:1:vert_tile
        tile=tile+1;
        b=a((H:H+7),(L:L+7));
        [h_uni,l_uni,p_uni]=size(unique_tiles);

        skip=0;
        if tile==1 %first tile is always unique
            skip=1;
            unique_tiles(:,:,1)=b;
            [~,~,pos]=size(unique_tiles);% get the rank in the pixel tileset
            Tile_map(H_tile,L_tile)=pos;% fills the tilemap
        end
        if skip==0;
            flag=0;
            pos_identical=0;
            for m=1:1:p_uni %search in the whole existing tileset for matching
                if unique_tiles(:,:,m)==b
                    pos_identical=m;
                    flag=1; %it's a known tile, skip it !
                end
            end
            if flag==0 %it's a new tile, keep it !
                unique_tiles(:,:,end+1)=b;
                [~,~,pos]=size(unique_tiles);% get the rank in the pixel tileset
                Tile_map(H_tile,L_tile)=pos;% fills the tilemap
            end
            if flag==1
                Tile_map(H_tile,L_tile)=pos_identical;
            end
        end
        hold on
        if flag==1
            plot([L-1/2,L-1/2+8], [H-1/2,H-1/2+8] ,'r')
            plot([L-1/2+8,L-1/2], [H-1/2,H+8-1/2] ,'r')
            text(L+1,H+3,dec2hex(pos_identical-1),'Color','magenta','FontSize',8)
        else
            rectangle('Position',[L-1/2 H-1/2 8 8],'EdgeColor','g')
            text(L+1,H+3,dec2hex(pos-1),'Color','magenta','FontSize',8)
            title(['Number of unique tiles: ', num2str(pos)])
        end
        hold off
        L=L+8;
        L_tile=L_tile+1;
        if L>=width
            L=1;
            L_tile=1;
            H=H+8;
            H_tile=H_tile+1;
        end
    end
end
drawnow

%this part creates a C file for tilemap
Tile_map=Tile_map-1;
disp('Tilemap building');
[height, width, ~]=size(Tile_map);
fid2 = fopen('Tilemap.c','w');
fprintf(fid2,'unsigned char tilemap[] =');
fprintf(fid2, '\r\n');
fprintf(fid2,'{');
fprintf(fid2, '\r\n');

for i=1:1:height
    for j=1:1:width
        word=['0x',num2str(dec2hex(Tile_map(i,j),2))];
        fprintf(fid2,word);
        if not(i==height&&j==width)
            fprintf(fid2,',');
        end
    end
    fprintf(fid2, '\r\n');
end

fprintf(fid2,'};');
fclose(fid2);

%this part creates a C file for tileset in 2BPP Game Boy tile format
%(default palette)
disp('Tileset building');
fid = fopen('Tileset.c','w');
fprintf(fid,'unsigned char tileset[] =');
fprintf(fid, '\r\n');
fprintf(fid,'{');
fprintf(fid, '\r\n');
[~,null,pos]=size(unique_tiles);

for p=1:1:pos
    b=unique_tiles(:,:,p);
    if not(p==1)
        fprintf(fid,',');
        fprintf(fid, '\r\n');
    end
    for i=1:8
        for j=1:8
            if b(i,j)==Lgray;  V1(j)=('1'); V2(j)=('0');end
            if b(i,j)==Dgray;  V1(j)=('0'); V2(j)=('1');end
            if b(i,j)==White;  V1(j)=('0'); V2(j)=('0');end
            if b(i,j)==Black;  V1(j)=('1'); V2(j)=('1');end
        end
        O1=['0x',num2str(dec2hex(bin2dec(V1),2),2)];
        O2=['0x',num2str(dec2hex(bin2dec(V2),2),2)];
        fprintf(fid,O1);
        fprintf(fid,',');
        if (i==8 && j==8)
            fprintf(fid,O2);
        end
        if not(i==8 && j==8)
            fprintf(fid,O2);
            fprintf(fid,',');
        end
    end
end

fprintf(fid, '\r\n');
fprintf(fid,'};');
fclose(fid);

disp('Displaying the unique tiles as image');
H=1;
L=1;
memory=0;
memory_width=128;

for p=1:1:pos
    b=unique_tiles(:,:,p);
    memory((H:H+7),(L:L+7))=b;
    L=L+8;
    if L>=memory_width
        L=1;
        H=H+8;
    end
end

subplot(1,2,2)
hold on
imshow(uint8(memory));
tiles_lacking=ceil((memory_width-L)/8);

H=1;
L=1;
for p=1:1:pos
    rectangle('Position',[L-1/2 H-1/2 8 8],'EdgeColor','g')
    text(L+1,H+3,dec2hex(p-1),'Color','magenta','FontSize',8)
    L=L+8;
    if L>=memory_width
        L=1;
        H=H+8;
    end
end

for p=1:1:tiles_lacking
    rectangle('Position',[L-1/2 H-1/2 8 8],'FaceColor','y')
    L=L+8;
    if L>=memory_width
        L=1;
        H=H+8;
    end
end
hold off

title('VRAM')
drawnow

saveas(gcf,'Output.png');
disp('Normal termination');
