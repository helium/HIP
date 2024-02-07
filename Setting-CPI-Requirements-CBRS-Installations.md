# Setting-CPI-Requirements-CBRS-Installations

- Author(s): @mrfizzy99
- Start Date: 2024/02/07
- Category: Technical
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->
- Vote Requirements: Current veMOBILE Holders

## Summary

This HIP aims to set CPI (Certified Professional Installer) requirements for CBRS deployments to better the installation quality and knowledge of the deployers for the CBRS network. 
Every new cbrs deployment and/or re-authorization of a cbrs radios, and will require a CPI identification number when submitting for SAS registration.

## Motivation

- Improving the quality of CBRS installs
- Improving the knowledge of the ones deploying CBRS. 

## Stakeholders

- CBRS Radios and Deployers 

## Detailed Explanation

In order to get CPI certified, you must take a short online course that would take no longer than a day.  
These courses can be taken at the following sites:

https://www.federatedwireless.com/services/certified-professional-installer/

https://www.coursera.org/learn/google-cbrs-cpi-training

The CPI ID would be an additoanl required text field as part of the SAS authorization.


## Drawbacks

- Less deployments of CBRS due to a lack of knowledge or willingness to take the CPI Training Courses.  

## Rationale and Alternatives

Many newcomers in this ecosystem have little understanding of CBRS and SAS, and requring all deployers to go through the CBRS training program to get their CPI certification will directly impact the quality and knowledge of the ones that are actually doing to installations.    

## Unresolved Questions

- How Nova Labs will use this information to better SAS authorization.  

## Deployment Impact

Current SAS authorization would not be effected. However if a re-CPI is required for those units either by means of moving the units or deviation of the GPS, a CPI ID will be required as part of the resubmitting for SAS registration. 


## Success Metrics

- Higher quality installs of CBRS units.
- Less CPI rejections due to not understanding what is required.
  
  
