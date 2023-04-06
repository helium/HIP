# HIPxx: Minimum Onboarding Fee

- Author(s): @mawdegroot, @Maxgold91 <!-- your GitHub @username -->
- Start Date: 2023-04-03 <!-- fill me in with today's date, YYYY-MM-DD -->
- Category: economic <!-- economic, technical, meta -->
- Original HIP PR: <!-- leave this empty; maintainer will fill in ID of this pull request -->
- Tracking Issue: <!-- leave this empty; maintainer will create a discussion issue -->

## Summary

This HIP proposes to set a minimum onboarding fee for Hotspots in the subDAO structure. This HIP also proposes that Hotspots for which the minimum onboarding fee has not been burned are not eligible for rewards from the subDAO. The minimum onboarding fee will be set to $5 and can be changed via a governance procedure.

<!-- Read the content requests in all sections before starting to write any section. -->

## Motivation

A minimum onboarding fee is necessary to:

1. Stop subDAOs from arbitrarily onboarding Hotspots. 
2. And prevents nuisance attacks against subDAOs and the Helium DAO. 

HIP51 has described the onboarding of Hotspots but has not made this explicit. Hotspots for which the minimum onboarding fee has not been burnt are not eligible for rewards. SubDAOs attempting to bypass this requirement will be subject to slashing.


## Stakeholders

All network participants.

## Deployment Impact

The migration to Solana requires every Hotspot to be onboarded to every subDAO individually, as HIP51 intended. Existing Hotspots for which no onboarding fee has been burnt to a specific subDAO will have to rectify this to continue earning rewards for a subDAO.
