# HIP 108: Mobile Hotspot Suspension Framework

- Author(s): [@zer0tweets](https://github.com/zer0tweets)
- Start Date: 2024-01-27
- Category: Meta, Governance
- Original HIP PR: [#886](https://github.com/helium/HIP/pull/886)
- Tracking Issue: [#887](https://github.com/helium/HIP/issues/887)
- Vote Requirements: veMOBILE Holders

## Summary

This proposal outlines the duties and guidelines for MOBILE hotspot vendors (CBRS and Wi-Fi) as it relates to suspending hotspots engaging in counterproductive and/or malicious activity on the MOBILE network. 

## Motivation

As the network continues to grow, more and more hotspots are engaging in various types of nefarious activities aimed at farming MOBILE POC rewards. This HIP proposes a framework that can be used by hotspot vendors and the community to suspend such hotspots. 

## Stakeholders

- MOBILE hotspot operators (both CBRS and Wi-Fi)
- MOBILE hotspot vendors

## Detailed Explanation

To preclude proliferation of counterproductive and/or malicious hotspot installs aimed at farming MOBILE POC rewards, any vendor of MOBILE hotspots (either CBRS or Wi-Fi) certified by the Helium Foundation is required to police and temporarily suspend and/or disable a hotspot that such vendor has reasonable evidence to assume is part taking in an activity that is hurting the community.

## Criteria Guidelines for Suspension of Hotspot by a Vendor
A foundation approved hotspot vendor must monitor its fleet of hotspots and exercise reasonable judgment to determine which hotspots are engaging in counterproductive and/or malicious activity. Common examples of such counterproductive and malicious activity may include:

 
-   Deployments in locations highly unlikely to ever produce data usage, yet optimized to harvest maximum POC by covering huge swaths of land i.e. 436H radios with a majority of hexes covering water, urban fields, mountains etc. generally exceeding 2200 coverage points per radio (50th percentile)
-   Creating harmful RF interference through artificial density i.e. more than 1 gateway with a total of 5 or more radios within a 200m radius inside an urbanized area 
-   Radios engaging in data milking i.e. 30+ subscriber accounts registered to a single entity pushing data through a single hotspot at rates atypical of regular usage patterns  
-   Any hotspot purposefully misrepresenting its coverage by using any means to fake an asserted location or misrepresentation of reality in CPI submission i.e. China IP addresses, fake photoshopped images in CPI submission, radio does not exist in CPI location etc.
    
## Suspension Process
Upon discovery of any activity described above, a hotspot vendor is to follow the steps exactly as prescribed:

-   Temporarily suspend hotspots engaging in malicious activity (by revoking CPI registration and/or disabling the firmware of the malicious hotspot) such that it can no longer earn POC rewards
-   In conjunction with such suspension, publish the details of the hotspot (link in explorer and any evidence of malicious activity like fake CPI pictures, pictures of actual location with no hotspot, data milking statistics etc.) to a public #POC-Scammers channel 
-   Make a reasonable effort to notify the suspended party (use CPI registration email, hotspot purchase email etc.) and provide a link to the public discord post with evidence of temporary suspension  
-   Owner of suspended hotspot along with any member of the Helium community can freely express opinion and either object or support the published suspension
  
## Process Suspension Removal
-   At any point following the suspension, an affected hotspot hosts has the ability to cure and submit evidence of having fixed the deployment to the hotspot vendor   
-   Initially (right after the guidelines outlined here have been voted) a hotspot vendor can exercise its own reasonable judgment based on the public objections or support for the published, suspended hotspot, whether the hotspot should be unsuspended. Should a vendor act unfairly, the community has the right to penalize a vendor by voting to slash it’s staked MOBILE or voting to outright ban the hotspot vendor from the community   
-   No longer than 2 months following the acceptance of these guidelines via a community vote, Helium Foundation and Nova will collaborate to build an extension of the modular voting system to make it possible to vote whereby any mildly controversial hotspot suspension case can be formalized as community vote. Hotspots in question to remain suspended only if 67%+ of the votes are in favor of the suspension

## Drawbacks

This proposal assumes that hotspot vendors are trustworthy and capable actors that can exercise reasonable judgement to suspend the hotspots. As we add new vendors, the history shows that this assumption may not always hold true. Furthermore, there are a number of gray areas when it comes to "reasonable judgement." Inevitably, some of the suspensions will be deemed controversial by the community. 


## Deployment Impact

Current proposal does not require any changes on the blockchain side, but will require for Nova and Helium Foundation to collaborate and implement a voting system (as part of the existing modular governance setup) to allow approved vendors put up suspended hotspots to a vote. 

## Success Metrics

This HIP will be considered a success if MOBILE hotspot vendors have been successful in reducing the number of malicious activity on the network. 
