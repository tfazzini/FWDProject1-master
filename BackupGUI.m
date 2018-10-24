function varargout = BackupGUI(varargin)
% BACKUPGUI MATLAB code for BackupGUI.fig
%      BACKUPGUI, by itself, creates a new BACKUPGUI or raises the existing
%      singleton*.
%
%      H = BACKUPGUI returns the handle to a new BACKUPGUI or the handle to
%      the existing singleton*.
%
%      BACKUPGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BACKUPGUI.M with the given input arguments.
%
%      BACKUPGUI('Property','Value',...) creates a new BACKUPGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BackupGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BackupGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BackupGUI

% Last Modified by GUIDE v2.5 24-Oct-2018 11:13:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BackupGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @BackupGUI_OutputFcn, ...
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


% --- Executes just before BackupGUI is made visible.
function BackupGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BackupGUI (see VARARGIN)

% Choose default command line output for BackupGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BackupGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BackupGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
aeroFile = get(hObject,'String');
handles.aeroFile = aeroFile;
guidata(hObject,handles);

try
    aero = readAeroExcel(handles.aeroFile);
    fprintf('Loaded Aerodynamics');
    handles.aero = aero;
    guidata(hObject,handles);
    set(hObject,'BackgroundColor','green')
catch aeroError
    errorMessage = ['Unable to open file ''',handles.aeroFile,'.txt''.'];
    errorMessage2 = ['Unable to open file ''',handles.aeroFile,'''.'];
    if strcmp(aeroError.message,errorMessage) == 1 || strcmp(aeroError,errorMessage2) == 1
        set(hObject,'BackgroundColor','red')
        fprintf('Incorrect Aero File\n')
        f = errordlg('Aero File not Found','File Error');
        handles.aero.K1 = 1/(pi*handles.aero.AR*handles.aero.e);
        guidata(hObject,handles);
    end
end

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
missionFile = get(hObject,'String');
handles.missionFile = missionFile;
guidata(hObject,handles);

try
    input = getInput(handles.missionFile);
    fprintf('Loaded Mission\n');
    handles.input = input;
    guidata(hObject,handles);
    set(hObject,'BackgroundColor','green')
catch missionError
    errorMessage = ['Unable to open file ''',handles.missionFile,'.txt''.'];
    errorMessage2 = ['Unable to open file ''',handles.missionFile,'''.'];
    if strcmp(missionError.message,errorMessage) == 1 || strcmp(missionError,errorMessage2) == 1
        set(hObject,'BackgroundColor','red')
        fprintf('Incorrect Mission File\n')
        f = errordlg('Mission File not Found','File Error');
    end
end

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
reqFile = get(hObject,'String');
handles.reqFile = reqFile;
guidata(hObject,handles);

try
    reqs = readReqExcel(handles.reqFile);
    fprintf('Loaded Constraints\n');
    handles.reqs = reqs;
    guidata(hObject,handles);
    set(hObject,'BackgroundColor','green')
catch reqError
    errorMessage = ['Unable to open file ''',handles.reqFile,'.txt''.'];
    errorMessage2 = ['Unable to open file ''',handles.reqFile,'''.'];
    set(hObject,'BackgroundColor','red')
    if strcmp(reqError.message,errorMessage) == 1 || strcmp(reqError,errorMessage2) == 1
        fprintf('Incorrect Constraint File\n')
        f = errordlg('Constraint File not Found','File Error');
    end
end

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CLmax = str2double(get(hObject,'String'));
handles.aero.CLmax = CLmax;
guidata(hObject,handles);
if isnan(CLmax) == 0
    set(hObject,'BackgroundColor','green')
else
    set(hObject,'BackgroundColor','red')   
end

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CLalpha = str2double(get(hObject,'String'));
handles.aero.CLalpha = CLalpha;
guidata(hObject,handles);
if isnan(CLalpha) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CL0 = str2double(get(hObject,'String'));
handles.aero.CL0 = CL0;
guidata(hObject,handles);
if isnan(CL0) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CD0 = str2double(get(hObject,'String'));
handles.aero.CD0 = CD0;
guidata(hObject,handles);
if isnan(CD0) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CDR_TO = str2double(get(hObject,'String'));
handles.aero.CDR_TO = CDR_TO;
guidata(hObject,handles);
if isnan(CDR_TO) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
CDR_Land = str2double(get(hObject,'String'));
handles.aero.CDR_Land = CDR_Land;
guidata(hObject,handles);
if isnan(CDR_Land) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
K2 = str2double(get(hObject,'String'));
handles.aero.K2 = K2;
guidata(hObject,handles);
if isnan(K2) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
AR = str2double(get(hObject,'String'));
handles.aero.AR = AR;
guidata(hObject,handles);
if isnan(AR) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
e = str2double(get(hObject,'String'));
handles.aero.e = e;
guidata(hObject,handles);
if isnan(e) == 0
    set(hObject,'BackgroundColor','green')
    else
    set(hObject,'BackgroundColor','red') 
end

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
fprintf('Button Pushed\n')
try
    handles.aeroFile;
catch noAeroFile
    errorMessage = 'Reference to non-existent field ''aeroFile''.';
    if strcmp(noAeroFile.message,errorMessage) == 1
        fprintf('No Aero Input File\n')
        try
            handles.aero.K1 = 1/(pi*handles.aero.AR*handles.aero.e);
            guidata(hObject,handles);
        catch noAero
            erMsg = 'Reference to non-existent field ''aero''.';
            if strcmp(noAero.message,erMsg) == 1
                f = errordlg('Enter Aerodynamic Data','File Error');
            end
        end
    end
end

try
    handles.missionFile;
catch noMissionFile
    errorMessage = 'Reference to non-existent field ''missionFile''.';
    if strcmp(noMissionFile.message,errorMessage) == 1
        fprintf('No Mission Input File\n')
        f = errordlg('Mission File not Found','File Error');
    end
end

try
    handles.reqFile;
catch noReqFile
    errorMessage = 'Reference to non-existent field ''reqFile''.';
    if strcmp(noReqFile.message,errorMessage) == 1
        fprintf('No Constraint Input File\n')
        f = errordlg('Constraint File not Found','File Error');
    end
end

handles.aero
handles.reqs

runSizeSynthesis(handles.reqs,handles.aero)
%runSizeSynthesis(handles.reqs,handles.aero,handles.input)
