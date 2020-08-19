addpath('F:\');
addpath(genpath('F:\dti\packages')); %Adding required NIfTI Packages

prompt1 = 'Please enter the path to the NIfTI folder: '; %Allows user to enter path to NIfTI folder with functional, T1 and fieldmap .nii files
NIfTI_Path = input(prompt1,'s');

prompt2 = 'Please enter the name of the BIDS folder you wish to create: '; %Allows user to enter name of the BIDS folder to be created
BIDS_Folder_Path = input(prompt2,'s');

prompt3 = 'Please enter the name of the base folder to store BIDS folders in: '; %Enter basepath
Basepath = input(prompt3,'s');

prompt4 = 'Please enter participant label: ';
Participant_Label = input(prompt4,'s');

cd(Basepath);
mkdir(BIDS_Folder_Path); %Creates BIDS folder in a meta folder which is RADC_Bids in this case, can change

cd(sprintf('%s/%s', Basepath, BIDS_Folder_Path)); %CD to new BIDS folder

%Creating particpant.json
participant.bmi = '20';
participant.education = '1';
participant_json = jsonencode(participant);

fid = fopen('particpant.json', 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, participant_json, 'char');
fclose(fid);

%Creating dataset_description.json


dataset.ReferencesAndLinks = {''};
dataset.DatasetDOI = '';
dataset.Funding = '';
dataset.Name = '';
dataset.License = '';
datset.BIDSVersion = '1.2.0';
dataset.Authors = {''};
dataset.Acknowledgments = '';
dataset.HowToAcknowledge = '';
dataset_json = jsonencode(dataset);

fid = fopen('dataset_description.json', 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, dataset_json, 'char');
fclose(fid);

%Creating README.txt
fid=fopen('README.txt','w');
text = 'Add any details and instructions';
fprintf(fid,[text]);
fclose(fid);

%Creating Empty Folder Structures
mkdir('sourcedata');
mkdir('derivatives');
mkdir('code');

%Generating subject folder for scans and .json files
subject_folder = sprintf('sub-%s',Participant_Label);
mkdir(subject_folder);

BIDS_subject = sprintf('%s/%s/%s',Basepath,BIDS_Folder_Path,subject_folder)
cd(BIDS_subject);
mkdir('func');
mkdir('anat');
mkdir('fmap');

func_folder = sprintf('%s/func', BIDS_subject);

%Name of func file in original database
prompt5 = 'Name of BOLD file: ';
BOLD_file = input(prompt5,'s');

%copying and renaming file into BIDS folder
copyfile(sprintf('%s/%s',NIfTI_Path,BOLD_file),sprintf('%s/sub-%s_task-rest_bold.nii.gz',func_folder,Participant_Label));

cd(func_folder);

%Extracting func .json information from NIfTI header
Func_header = niftiRead(sprintf('%s/sub-%s_task-rest_bold.nii.gz',func_folder,Participant_Label));
TR = Func_header.pixdim(4);

%Creating func .json file
func_json_name = sprintf('%s/sub-%s_task-rest_bold.json',func_folder,Participant_Label);

%prompt

%parameters with the comment MODIFY attached are those with values only present in DICOM headers, not NIfTI.
%Manually Modify in script as required if not using for RADC 
func.Modality = 'MR';
func.MagneticFieldStrength = 3;%%MODIFY
func.Manufacturer = 'Seimens'; %%MODIFY
func.EchoTime = 0.03; %%MODIFY
func.RepetitionTime = TR;
%YET TO ADD SLICE TIMING

func_json = jsonencode(func);

fid = fopen(func_json_name, 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, func_json, 'char');
fclose(fid);

%Working on Anat folder in BIDS structure
struc_folder = sprintf('%s/anat', BIDS_subject);

%Name of Structural file in original database
prompt6 = 'Name of Structural file: ';
T1_file = input(prompt6,'s');
copyfile(sprintf('%s/%s',NIfTI_Path,T1_file),sprintf('%s/sub-%s_T1w.nii.gz',struc_folder,Participant_Label));

% %Extracting struc .json information from NIfTI header
% Struc_header = niftiRead(sprintf('%s/sub-%s_T1w.nii.gz',struc_folder,Participant_Label));
% TR_T1 = Struc_header.pixdim(4);

cd(struc_folder);
%Creating struc .json file
struc_json_name = sprintf('%s/sub-%s_T1w.json',struc_folder,Participant_Label);

struc.Modality = 'MR';
struc.EchoTime = 0.03; %%MODIFY
struc.MagneticFieldStrength =3; %%MODIFY
%YET TO ADD SLICE TIMING

struc_json = jsonencode(struc);

fid = fopen(struc_json_name, 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, struc_json, 'char');
fclose(fid);

