# HIP 69: Hot Air Balloon Telecommunication subDAO
- Author: [@helium_lord](https://twitter.com/helium_lord?lang=en)
- Start Date: 1785-06-15
- Category: Economic, Technical, Balloonatic
- Original PR: https://github.com/helium/HIP/pull/429
- Tracking Issue: https://github.com/helium/HIP/issues/295
- Status: Draft

## Summary
In [HIP 51: Helium DAOs](https://github.com/helium/HIP/blob/main/0051-helium-dao.md), a general structure for onboarding new Decentralized Network Protocols (DNPs) to the broader Helium Network was introduced. HIP 69 will follow this model.

## Stakeholders
This proposal impacts all current and future participants in the Helium IoT Community as well as owners and operators of hot-air powered flying machines.

## ROZ subDAO Core Components
We proposed in HIP 51 that each DNP subDAO operate as a sovereign economics and governance layer. The ROZ subDAO has five core functions.

1. **BTU Curve** 
2. **Proof-of-Airworthiness**
3. **Governance** 
4. **Treasury Reserve ROZ Market Making Curve**
5. **Initial Distribution**

### BTU (British Thermal Unit) Curve
There will be a max supply of 500,000,000 ROZ. The ROZ subDAO handles all ROZ emissions, rewards, and operations. The economic responsibilities around this involve managing the token issuance and distribution. Token issuance (mining) is determined by the BTU reading measured from an operator's balloon. In essence, the higher the BTU reading, the higher you'll go.
![display](https://github.com/helium-lord/HIP/blob/main/0069-hot-air-balloon-communication/BTU-CURVE-CHART.jpg)

### Proof-of-Airworthiness Specification
Hardware operating on the subDAO shall have no asserted physical location, rather an asserted height to ensure the vessel has reached the minimum viable altitude. Before onboarding an operator to the network, a “certificate of airworthiness” must be submitted to ensure that their balloon is safe for flight. These certificates are issued at no cost by CASA (Civil Aviation Safety Authority) and must be updated once per year for continued participation in the ROZ subDAO. Failure to prove the airworthiness of your balloon can result in lost rewards and in certain cases tragic death over the English Channel. 

### Governance
The ROZ Network is under the control of the subDAO. We propose that veROZ governance is constructed in a manner identical to veHNT governance as specified in HIP51. Under this model,  users can choose to delegate their lockup power in veROZ to all subDAO governance proposals. Proposals are assessed using majority and quorum thresholds defined in veROZ terms, initially proposed to be 69% and 100M ROZ respectively.

### Treasury Reserve ROZ Market Making Curve 
SubDAOs have full control over the prices at which the subDAO treasury provides quotes to holders of DNT who wish to redeem their holdings for underlying HNT. ROZ tokens are redeemable for HNT based on the equation:

![display](https://github.com/helium-lord/HIP/blob/main/0069-hot-air-balloon-communication/equation1.png)

### Initial Distribution
10% (50,000,000) of the total supply of ROZ will be airdropped to all active helium wallets based on the Rozière System of Wealth Creation:

* 1-9 HNT - Rich: 25% (12,500,000 ROZ)
* 10-99 HNT - Wealthy: 20% (10,000,000 ROZ)
* 100-999 HNT - Elite: 15% (7,500,000 ROZ)
* 1,000-9999 HNT - Nobles: 10% (5,000,000 ROZ)
* 10,000-99999 HNT - Lords: 5% (2,500,000 ROZ)
* 100,000-999999 HNT - Kings: 2.5% (1,250,000 ROZ)
* 1,000,000-∞ HNT - Gods: 1.25% (625,000 ROZ)

The token distribution is setup such that the new wealth is created in wallets with the least HNT. 
