# HIP26: Payment Notes

- Author(s): @cvolkernick
- Start Date: 2021-01-24
- Category: Technical
- Original HIP PR: <https://github.com/helium/HIP/pull/117>
- Tracking Issue: <https://github.com/helium/HIP/issues/125>

# Summary

This proposal suggests the addition of a new option for the Helium wallet PAY command: an optional
(likely length/size restricted) alphanumeric memo/note field included with a wallet-to-wallet HNT
payment transaction.

# Motivation

There have been ongoing asks within the community for some time now regarding means to contact
neighboring gateway owners; evidence of this demand can be found throughout the community discord in
various channels. The ask typically centers around the coordination of gateway optimization, or
other performance issues, but also has been expressed as a means to create ties with local networks
and cooperate with other hosts / owners in a way that benefits the growth & development of the
overall network. There have also been use cases stated around this such as simple notations of
payments to others, either for accounting / documentation purposes (e.g. what was the payment for)
-- similar to existing payment solutions such as Venmo.

# Stakeholders

- Anyone using the Helium wallet in any capacity will be affected by this change -- individuals,
  orgs, etc. -- whether through the wallet CLI or app UI.

Feedback and discussion on this change will be solicited & heard through the existing HIP discussion
channel(s) (primarily Discord, in the respective channel), and as usual through any git repo
commentary.

# Detailed Explanation

The changes as proposed should require only that an additional flag or subcommand be added, and
allow a fixed-size alphanumeric text field (string) to be included along with payment. Payment could
be nothing but the network fee required to send the necessary data packet size over the network, or
any normal payment figure. This is what enables users to attach notes to payments describing what
the payment was for, etc. It also consequentially enables one wallet to send messages of a fixed
length to another wallet, for a price. (Note in principle this dissuades spamming etc as you have to
pay per message to send, and through UX design etc., messages are not required to be acknowledged or
may be blocked/filtered entirely.

This could potentially also allow group broadcasts of messages as well (e.g. group
messaging/announcements broadcasting, etc.) by using multipayments (payments issued to multiple
wallets in a single transaction), which is already supported.

# Drawbacks

In the existing / past debates over this change, it has been argued that the ability to message
hotspot owners might enable forms of harrassment and/or present privacy concerns; however, because
the contact is initiated through the owner address (which is already publicly available
information), there is no implied correlation with owner PII -- it is for all intents and purposes
anonymous contact that the recipient is not obligated to acknowledge or respond to. There are also
other UX measures that could be employed to prevent harrassment / spam concerns. Address books also
aid in UX ease of use, such that they allow users to operate with saved contact data, rather than
long random strings of characters which can easily be subject to copy errors, and allow for
whitelisting/blacklisting.

# Rationale and Alternatives

It has been also considered, as a rule of thumb, whether this kind of service application could
equally or better be served by a third party ("off-chain") service. The key advantage that on-chain
support here, is that it provides native support as each wallet on the chain is inherently in the
same shared ecosystem / community. An argument or demonstration of an equivalent ability to
accomplish the same outcome off-chain is also welcome and can be presented in the discussion phase
of this proposal.

# Unresolved Questions

- Can the same goal be accomplished as effectively through other means?
- What size might payment text size be limited to & what is the added overhead to existing payment
  tx?
- Any other drawbacks or benefits?
- Would validators further expand the capacity to loosen text/data payload size restrictions without
  significant overhead?

# Deployment Impact

Change would be deployed through a combination of an additional flag/subcommand on the existing
wallet CLI pay command, and any UX changes in the Helium app and elsewhere deemed necessary /
beneficial. Documentation would need to be updated to reflect the new pay subcommand/flag and limits
on size, etc. Additional data payload / traffic would be implied. Perhaps creates an immediate use
case / standin for data traffic on the network without any additional changes or equipment
(sensors).

# Success Metrics

Noteworthy changes would include additional overhead in terms of data sent over the network as part
of these additional payment transactions. Generally feedback from the Helium community would be
solicited as to whether the new functionality was proving to be helpful and/or whether there were
drawbacks in performance or user experience that result from the new abilities. It would also be of
note to monitor performance of the network (blocktimes etc) to ensure that the performance was not
significantly overall.
