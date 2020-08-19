This folder contains the following data:

1. The Sub-Folder 'Scripts' contains two scripts:

a. Automate.m: This is a MATLAB script that can be used to run dcm2bids + fmriprep for multiple subjects in one go. It requires at least MATLAB 2017b or higher to run. Comments within the script will guide you in changing the data paths as required, before running. Additionally, for the final fmriprep command, customize the command as required (presence or absence of fieldmap correction etc.)

b. Nifti2Bids: This script has been designed to arrange NIFTI structured fMRI and T1 image files into the BIDS structure, when DICOMS are not available. Given that NIfTI headers simply do not contain certain parameters, some parameters have to be entered manually. These have been highlighted with comments. However, given that we have both RADC and ADNI Data available in the DICOM format, this is required only for a small set of RADC subjects who only have NIfTI data.

2. Common Errors in use of fmriprep: This is a list of errors I encountered in my use of fmriprep, and details of how these can be avoided or resolved.

3. dcm2bids + fmriprep - Step by Step Instructions: This is a detailed documentation that indicates how to use both of these tools, for a variety of customizations (absence of slice timing data, fieldmap correction in the presence or absence of fieldmaps etc.). It also details quirks of both the ADNI and RADC databases, with regard to the use of these tools. As this tutorial proceeds step by step, I recommend trying it stepwise for one subject, for various customizations, before using the Automate.m script to run multiple subjects in a go.

4.  dcm2bids + fmriprep Tutorial Slides: This contains the tutorial slides I presented in the lab meeting. It is particularly useful for getting a quick idea of why we are using these tools, the steps involved, the challenges presented, and screenshots of outputs at each stage.

5. fmriprep Tutorial Supplementary Material: This contains explanations for the slides we weren't able to cover in the tutorial - particularly, all the steps fmriprep performs are explained in detail, and some links for assessing the generated output have been provided.

6. Important Links: This contains a set of important links in the use of dcm2bids - Installation, relevant papers, official documentation, and forums to raise queries.

7. Troubleshooting_GoogleDoc: This contains screenshots of error messages encountered by Nabarun and Yadnesh, as they tried the pipeline out, and comments resolving these errors (comments are at the end of the document). The PDF contains a link to the goole doc, where you can also post issues you encounter, that haven't been addressed previously - in both this document and the common errors document.

8. Visualizing Different Modalities in FSLVIEW: This document describes how to use FSL's fslview visualizer to open up scans, and see what they look like. It also has samples images of each different modality the pipeline requires - BOLD, T1, magnitude fieldmap images, and the phase difference fieldmap image, to help distinguish between modalities for beginners.