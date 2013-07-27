function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 06-Jul-2013 12:36:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in launch_button.
function launch_button_Callback(hObject, eventdata, handles)
% hObject    handle to launch_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% We get the user input from the GUI

 N=str2double(get(handles.grid_size_input,'String'));
% h=str2double(get(handles.spatial_step_input,'String'));
% dt=str2double(get(handles.temporal_step_input,'String'));
% fluence=str2double(get(handles.spatial_step_input,'String'));
% freq=str2double(get(handles.laser_freq_input,'String'));
% Ce=str2double(get(handles.Ce_input,'String'));
% v_e_ph=str2double(get(handles.v_input,'String'));
% Ke=str2double(get(handles.Ke_input,'String'));
% g=str2double(get(handles.g_input,'String'));



%We call the solving function which returns the computed values

Resol_2Temp

%We plot the values in their respective axis

surfc(handles.Temp,Te,[0:10:N])
hold on
surfc(handles.Temp,Tr,[0:10:N])



function grid_size_input_Callback(hObject, eventdata, handles)
% hObject    handle to grid_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of grid_size_input as text
%        str2double(get(hObject,'String')) returns contents of grid_size_input as a double


% --- Executes during object creation, after setting all properties.
function grid_size_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grid_size_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function spatial_step_input_Callback(hObject, eventdata, handles)
% hObject    handle to spatial_step_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of spatial_step_input as text
%        str2double(get(hObject,'String')) returns contents of spatial_step_input as a double


% --- Executes during object creation, after setting all properties.
function spatial_step_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spatial_step_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temporal_step_input_Callback(hObject, eventdata, handles)
% hObject    handle to temporal_step_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temporal_step_input as text
%        str2double(get(hObject,'String')) returns contents of temporal_step_input as a double


% --- Executes during object creation, after setting all properties.
function temporal_step_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temporal_step_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fluence_input_Callback(hObject, eventdata, handles)
% hObject    handle to fluence_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fluence_input as text
%        str2double(get(hObject,'String')) returns contents of fluence_input as a double


% --- Executes during object creation, after setting all properties.
function fluence_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fluence_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in solid_list.
function solid_list_Callback(hObject, eventdata, handles)
% hObject    handle to solid_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns solid_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from solid_list

function laser_freq_input_Callback(hObject, eventdata, handles)
% hObject    handle to laser_freq_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of laser_freq_input as text
%        str2double(get(hObject,'String')) returns contents of laser_freq_input as a double


% --- Executes during object creation, after setting all properties.
function laser_freq_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to laser_freq_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function solid_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to solid_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
datas=load_listbox_datas
set(handles.solid_list,'String',datas.Solids.name)


function datas=load_listbox_datas
datas=importdata('solids.mat')
datas.Solids.name




% --- Executes on button press in load_s_param.
function load_s_param_Callback(hObject, eventdata, handles)
% hObject    handle to load_s_param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% We start the popup showing which parameters were set
GUI_s_load


function Ce_input_Callback(hObject, eventdata, handles)
% hObject    handle to Ce_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ce_input as text
%        str2double(get(hObject,'String')) returns contents of Ce_input as a double


% --- Executes during object creation, after setting all properties.
function Ce_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ce_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ke_input_Callback(hObject, eventdata, handles)
% hObject    handle to Ke_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ke_input as text
%        str2double(get(hObject,'String')) returns contents of Ke_input as a double


% --- Executes during object creation, after setting all properties.
function Ke_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ke_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function v_input_Callback(hObject, eventdata, handles)
% hObject    handle to v_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of v_input as text
%        str2double(get(hObject,'String')) returns contents of v_input as a double


% --- Executes during object creation, after setting all properties.
function v_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to v_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g_input_Callback(hObject, eventdata, handles)
% hObject    handle to g_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g_input as text
%        str2double(get(hObject,'String')) returns contents of g_input as a double


% --- Executes during object creation, after setting all properties.
function g_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in save_set.
function save_set_Callback(hObject, eventdata, handles)
% hObject    handle to save_set (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in load_sets.
function load_sets_Callback(hObject, eventdata, handles)
% hObject    handle to load_sets (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in check_reflectivity.
function check_reflectivity_Callback(hObject, eventdata, handles)
% hObject    handle to check_reflectivity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_reflectivity


% --- Executes on button press in check_dielectric.
function check_dielectric_Callback(hObject, eventdata, handles)
% hObject    handle to check_dielectric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_dielectric


% --- Executes on button press in check_temperature.
function check_temperature_Callback(hObject, eventdata, handles)
% hObject    handle to check_temperature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of check_temperature


% --- Executes on button press in save_data.
function save_data_Callback(hObject, eventdata, handles)
% hObject    handle to save_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
