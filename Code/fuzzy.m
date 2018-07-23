function varargout = fuzzy(varargin)
% FUZZY M-file for fuzzy.fig
%      FUZZY, by itself, creates a new FUZZY or raises the existing
%      singleton*.
%
%      H = FUZZY returns the handle to a new FUZZY or the handle to
%      the existing singleton*.
%
%      FUZZY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FUZZY.M with the given input arguments.
%
%      FUZZY('Property','Value',...) creates a new FUZZY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fuzzy_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fuzzy_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fuzzy

% Last Modified by GUIDE v2.5 29-Jan-2011 00:27:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fuzzy_OpeningFcn, ...
                   'gui_OutputFcn',  @fuzzy_OutputFcn, ...
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


% --- Executes just before fuzzy is made visible.
function fuzzy_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fuzzy (see VARARGIN)

% Choose default command line output for fuzzy
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fuzzy wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fuzzy_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnFuzzyReasoning.
function btnFuzzyReasoning_Callback(hObject, eventdata, handles)
global FireStation GasStatin OpenArea Hospital SHPbuild
% hObject    handle to btnFuzzyReasoning (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x_cent,y_cent] = Centroid;
House=[x_cent;y_cent]';
xlim([0 6000])
ylim([0 6000])
for ii=1:size(House,1)
    for jj=1:size(FireStation,1)
    Dist_FireStation(ii,jj)=Distance([House(ii,1),House(ii,2)],[FireStation(jj,1),FireStation(jj,2)]);
    end
end
for ii=1:size(House,1)
    for jj=1:size(GasStatin,1)
    Dist_GasStatin(ii,jj)=Distance([House(ii,1),House(ii,2)],[GasStatin(jj,1),GasStatin(jj,2)]);
    end
end
for ii=1:size(House,1)
    for jj=1:size(OpenArea,1)
    Dist_OpenArea(ii,jj)=Distance([House(ii,1),House(ii,2)],[OpenArea(jj,1),OpenArea(jj,2)]);
    end
end
for ii=1:size(House,1)
    for jj=1:size(Hospital,1)
    Dist_Hospital(ii,jj)=Distance([House(ii,1),House(ii,2)],[Hospital(jj,1),Hospital(jj,2)]);
    end
end
fis = readfis('vulnerability.fis');
for ii=1:size(House,1)
    Cost(ii)=evalfis([min(Dist_FireStation(ii,:)) min(Dist_GasStatin(ii,:)) min(Dist_OpenArea(ii,:)) min(Dist_Hospital(ii,:))], fis);
end
 
    for ii = 1:12
        hold on
        X=SHPbuild(ii).X;Y=SHPbuild(ii).Y;
        X = X(1:length(X)-1);
        Y = Y(1:length(Y)-1);
        if  0 <=Cost(ii)&&Cost(ii)<= 10  %--Risk is very Low
           fill(X,Y,[0,0,1.0])  %  Painting white
      
        elseif  10 <=Cost(ii)&&Cost(ii)<= 20  %--Risk is  Low
             fill(X,Y,[0,0,1.0])  %  Painting yellow
        
        elseif  20 <=Cost(ii)&&Cost(ii)<= 30  %--Risk is Average
             fill(X,Y,[0,0,1.0])  %  Painting green
            
        elseif  30<=Cost(ii)&&Cost(ii)<= 40  %--Risk is High
             fill(X,Y,[0,1,0])  %  Painting Red
            
        elseif  40<=Cost(ii)&&Cost(ii)<= 50
             fill(X,Y,[0,1,0])   %  Painting purple
             
       elseif  50 <=Cost(ii)&&Cost(ii)<= 60
             fill(X,Y,[1,1,0])
             
       elseif  60 <=Cost(ii)&&Cost(ii)<= 70
             fill(X,Y,[1,1,0])
             
       elseif  70 <=Cost(ii)&&Cost(ii)<= 80
             fill(X,Y,[1,0,0])
             
       elseif  80 <=Cost(ii)&&Cost(ii)<= 90
             fill(X,Y,[1,0,0])
             
       elseif  90 <=Cost(ii)&&Cost(ii)<= 100
             fill(X,Y,[1,0,0])
        end
    end
    xlim([0 6000])
ylim([0 6000])        
 colorbar('YTickLabel',{'Very Low','                ','            ','Average','                  ','               ','High','                   ','                ','     ','Very High'})


 [Cost Index]=sort(Cost)
 House=House(Index,:);


function txtFireStation_Callback(hObject, eventdata, handles)
% hObject    handle to txtFireStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtFireStation as text
%        str2double(get(hObject,'String')) returns contents of txtFireStation as a double


% --- Executes during object creation, after setting all properties.
function txtFireStation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtFireStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtHouse_Callback(hObject, eventdata, handles)
% hObject    handle to txtHouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtHouse as text
%        str2double(get(hObject,'String')) returns contents of txtHouse as a double


% --- Executes during object creation, after setting all properties.
function txtHouse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtHouse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtGasStation_Callback(hObject, eventdata, handles)
% hObject    handle to txtGasStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtGasStation as text
%        str2double(get(hObject,'String')) returns contents of txtGasStation as a double


% --- Executes during object creation, after setting all properties.
function txtGasStation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtGasStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtOpenarea_Callback(hObject, eventdata, handles)
% hObject    handle to txtOpenarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtOpenarea as text
%        str2double(get(hObject,'String')) returns contents of txtOpenarea as a double


% --- Executes during object creation, after setting all properties.
function txtOpenarea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtOpenarea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function txtHospital_Callback(hObject, eventdata, handles)
% hObject    handle to txtHospital (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtHospital as text
%        str2double(get(hObject,'String')) returns contents of txtHospital as a double


% --- Executes during object creation, after setting all properties.
function txtHospital_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtHospital (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global SHPbuild
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

SHPbuild = uigetfile('*.shp','Select build shape file');
SHPbuild = shaperead(SHPbuild)
mapshow(SHPbuild)


% --- Executes on button press in btn_FireStation.
function btn_FireStation_Callback(hObject, eventdata, handles)
global FireStation
% hObject    handle to btn_FireStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[x y]=ginput(1);
text(x,y,'F');
[row,col]=size(FireStation);
FireStation(row+1,1) = x;
FireStation(row+1,2)= y;

% --- Executes on button press in btnGasStation.
function btnGasStation_Callback(hObject, eventdata, handles)
global GasStatin
% hObject    handle to btnGasStation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(1);
text(x,y,'G');
[row,col]=size(GasStatin);
GasStatin(row+1,1) = x;
GasStatin(row+1,2)= y;

% --- Executes on button press in btnOpenArea.
function btnOpenArea_Callback(hObject, eventdata, handles)
global OpenArea
% hObject    handle to btnOpenArea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(1);
text(x,y,'O');
[row,col]=size(OpenArea);
OpenArea(row+1,1) = x;
OpenArea(row+1,2)= y;

% --- Executes on button press in btnHospital.
function btnHospital_Callback(hObject, eventdata, handles)
% hObject    handle to btnHospital (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Hospital
% hObject    handle to btn_municipality (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x y]=ginput(1);
text(x,y,'H');
[row,col]=size(Hospital);
Hospital(row+1,1) = x;
Hospital(row+1,2)= y;
