function varargout = PixelMarker(varargin)
% PixelMarker MATLAB code for PixelMarker.fig
%      PixelMarker, by itself, creates a new PixelMarker or raises the existing
%      singleton*.
%
%      H = PixelMarker returns the handle to a new PixelMarker or the handle to
%      the existing singleton*.
%
%      PixelMarker('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PixelMarker.M with the given input arguments.
%
%      PixelMarker('Property','Value',...) creates a new PixelMarker or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PixelMarker_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PixelMarker_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PixelMarker

% Last Modified by GUIDE v2.5 02-Feb-2018 00:45:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PixelMarker_OpeningFcn, ...
                   'gui_OutputFcn',  @PixelMarker_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before PixelMarker is made visible.
function PixelMarker_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PixelMarker (see VARARGIN)

% ��ʼ��ȫ�ֱ���
global points;  
global tmp;
global pointHandles;%cell
global count;
global img;
global fid;

fid = -1;
img = -1;
points = [];  
tmp = [];
pointHandles = {};%cell
count = 1;

% Choose default command line output for PixelMarker
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PixelMarker wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axes2,'visible','off'); %����������
% set(gcf,'CloseRequestFcn','closereq'); %���ùرջص�
% ����ͼ��
% h = handles.figure1; %��������
% newIcon = javax.swing.ImageIcon('icon.jpg');
% figFrame = get(h,'JavaFrame'); %ȡ��Figure��JavaFrame��
% figFrame.setFigureIcon(newIcon); %�޸�ͼ��

% --- Outputs from this function are returned to the command line.
function varargout = PixelMarker_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --------------------------------------------------------------------
function Open_Callback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
import matlab.io.*;
global img;
global width;
global height;

hold off;
axes(handles.axes2);  
[filename,pathname]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg;*.tif;*.fits'},'Select an image',...  
                'C:');  
str=[pathname filename];  
if isequal(filename,0)||isequal(pathname,0)  
    warndlg('Please select a picture first!','Warning');  
    return;  
elseif filename(end-3:end)=='fits'  
    img = fitsread(str);
    fptr = fits.openFile(str);
    imgSize = fits.getImgSize(fptr);
    height = imgSize(1);
    width = imgSize(2);
    % ���ҷ�ת�����·�ת
    img = imrotate(img,180);
    img = img(:, end:-1:1);
    imshow(img,[]);
else
    img = imread(str);     
    imshow(img);        
end 
hold on;


% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global points;  
global tmp;
global fid;
global img;

% �Ϸ���У��
if img == -1
    errordlg('Please select a picture first!','Error');
    return;
end

% ��һ�α���ʱ���������ļ�
if fid == -1
    % ָ������·�����ļ���
    [FileName,PathName] = uiputfile({'*.txt'},...  
                                     'Save Plots','Untitled');  
    fileStr = [PathName FileName];
    % �Ϸ���У��
    if FileName==0  
        return;  
    else  
        fid = fopen(fileStr,'wt');  
    end
end

set(handles.figure1,'Name','PixelMarker'); % ���ı���

% �����ǵ�����
if ~isempty(points) %���������α�����Ч����ֹ�ظ���¼
    points = tmp;
    points = unique(points,'rows');% ȥ���ظ���
    [row, col] = size(points);
    for i = 1:row
        for j = 1:col
            fprintf(fid, '%g\t', points(i,j));
        end
        fprintf(fid, '\n');
    end
    tmp = points;
    points = [];
end

% --------------------------------------------------------------------
function Open_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Open_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Save_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Save_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Undo_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Undo_Callback(hObject, eventdata, handles);

% --------------------------------------------------------------------
function Undo_Callback(hObject, eventdata, handles)
% hObject    handle to Undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global points;  
global tmp;
global pointHandles;
global count;
global fid;
global img;

% �Ϸ���У��
if img == -1
    errordlg('Please select a picture first!','Error');
    return;
elseif fid == -1 && isempty(points)
    errordlg('Invalid Operation!','Error');% �Ƿ�����ͼƬ��δ����Ǿͳ���
    return;
end

set(handles.figure1,'Name','PixelMarker*'); % ���ı���

if ~isempty(pointHandles)
    if count > 1 && ~isempty(pointHandles)
        delete(pointHandles{count-1}); % ɾ����һ��plot�ı��
        count = count - 1;
        if count <= 1
            count = 1;
        end
    end
end
if isempty(points)
    offset = length(num2str(tmp(end,:)))+2;
    fseek(fid,-1 * offset,1);
    % ������һ��
    for i=1:offset
        fprintf(fid,' ');
    end
    fseek(fid,-1 * offset,1);
end
if ~isempty(tmp)
    tmp(end,:) = [];
end

% --------------------------------------------------------------------
function Mark_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to Mark (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global width;
global height;
global pointHandles;
global count;
global points;
global tmp;
global img;

% �Ϸ���У��
if img == -1
    errordlg('Please select a picture first!','Error');
    return;
end

set(handles.hintText,'string','��ESC�������');
set(handles.figure1,'Name','PixelMarker*'); % ���ı���

while(1)
    pause(0.1);
    % ��ESC�������
    if strcmpi(get(gcf,'CurrentCharacter'),char(27)) %��esc�˳�
        set(gcf,'CurrentCharacter','~');
        set(handles.hintText,'string','');
        break;
    end
    [x,y,button] = ginput(1);
    % ����ͼ��߽粻������
    if x < 0 || x > width || y < 0 || y > height
        return;
    end
    if button == 1 %�����������ű��
        x = round(x);
        y = round(y);
        pointHandles(count) = {plot(x,y,'r+')};
        points = [points;[x,y]];
        tmp = points;
        if count > 3 % ֻ����3�λ��˵���
            count = 3;
            pointHandles{1} = pointHandles{2};
            pointHandles{2} = pointHandles{3};
            pointHandles{3} = pointHandles{4};
        end
        count = count + 1;
    end
end

% ----------------------------------------------------------------
function Exit_Callback(hObject, eventdata, handles)
if  isequal(questdlg('Quit or not?','Quit','Yes', 'No' ...
        , 'Yes'), 'Yes')
    closereq;
    delete(hObject);
end

% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
Exit_Callback(hObject, eventdata, handles);
