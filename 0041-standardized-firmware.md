# HIP Template

- Author(s): @flixxx
- Start Date: 2021-10-22
- Category: meta
- Original HIP PR: 
- Tracking Issue: 

# Summary

Intends to standardize firmware across all makers to avoid stranded devices in the event of a maker pulling out of the project.

# Motivation

As we onboard more makers, the inevitable truth is that some will stop supporting the project and cease to provide necessary firmware upgrades to support the network. The impact is that it can leave thousands of devices and hotspot owners stranded and further deteriotate the network coverage.


# Stakeholders

* Makers

* This should be an open discussion between dewi and the maker community.

# Detailed Explanation
[detailed-explanation]: #detailed-explanation

- A core firmware compatible for all makers, managed by helium and deployed by the makers with a specified deadline
- If a maker is no longer supporting the project, the helium team can push updates to those specific devices
- The makers must put forth their requirements of the firmware capabilities and build their software or customisation via a docker container or other alternative. They will have an opportunity to make refinements to their software and ensure compatibility

# Drawbacks

- Helium would be responsible for firmware compatibility across all the makers

# Rationale and Alternatives

As makers go through the approval process, the assessment will include the ability to support the hardware they are proposing and once approve the firmware will include the necessary support if required.

This will ensure that hardware will not become obsolete because of a maker stepping away from the project.

# Unresolved Questions

- Makers input
- Makers requirement (to support their dashboards for eample)


# Deployment Impact

- Extensive testing would be required to ensure that such a massive firmware change does not impact the functionality of the existing devices
- Some existing dashboards or customizations by makers may cease to work

# Success Metrics
[success-metrics]: #success-metrics

What metrics can be used to measure the success of this design?

- Centralized firmware: If/when a maker closes shop, the existing devices will continue to operate and get the necessary updates
