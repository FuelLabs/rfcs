- Feature Name: Multi-sig bundle support at the protocol level
- Start Date: 2023-04-20
- RFC PR: [fuel-labs/rfcs#0000](https://github.com/FuelLabs/rfcs/pull/0000)
- Issue: [fuel-labs/<PROJECT>#0000](https://github.com/FuelLabs/<PROJECT>/issues/0000)

# Summary
[summary]: #summary

Allow signed and multi-signed bundles as valid groups of transactions that can be executed as normal transactions but cannot be unbundled. Either the *entire* bundle must be signed by all addresses that produce a transaction, or multiple seperately signed transactions can be bundled together by a signature from a single address.

# Motivation
[motivation]: #motivation

There are several security risks assosciated with giving someone access to signed transactions before execution on chain. A malicious user could frontrun or backrun transactions to potentially exploit transactions. This means that a non-validator extracting MEV through traditional means would have to trust the validator to not unbundle the sent bundles and exploit the searcher's transactions.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

A signed bundle is a group of transactions that has signatures for multiple transactions all at once and no seperate signatures for seperate transactions. It allows users to execute multiple transactions sequentially and atomically (all or nothing), meaning no one can pick out individual transactions to exploit them. It also allows users to bypass per tx max gas limits by executing multiple transactions sequentially and atomically.

A user can bundle multiple different users seperately signed transactions into a single bundle and submit it by signing the entire bundle, or multiple users can sign the entire bundle at once, or any combination or the two.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

The transactions included in the bundle would execute as normally in VMs, except in the case any single transaction reverts, in which case the bundle would be dropped and not executed on chain.

There would be four main kinds of bundles:

- Single signer bundle: Multiple transactions, all originating from the same signer
- Multi signer bundle: Multiple transactions, originating from multiple addresses, signed by all the involved parties
- Single signer bundle including seperately signed transactions: Multiple transactions, some originating from the bundle signer, and some transactions seperately signed by third parties
- Multi signer bundle including seperately signed transactions: Multiple transactions, some originating from the bundle signer**s**, and some transactions seperately signed by third parties

The bundles would be accepted at the protocol level and would have no effect at the VM level.

# Drawbacks
[drawbacks]: #drawbacks

MEV extraction benefits would transfer to the user instead of validators, which could reduce the revenue for validators

# Rationale and alternatives
[rationale-and-alternatives]: #rationale-and-alternatives

- The alternatives such as Flashbots on Ethereum and Jito on Solana heavily rely on the validator not exploiting the bundles they recieve. This has proven to not be an effective strategy as validators can be anonymous and have a direct economic incentive to exploit transactions submitted to them.
- There was a [script design](https://github.com/FuelLabs/sway-rfcs/pull/26) considered but it would have been to complicated to implement compared to this proposal
- Not implementing this feature would eventually result in a auction such as flashbots emerging which has the above mentioned downsides.

# Prior art
[prior-art]: #prior-art

Flashbots on Ethereum pioneered the concept of bundles, validators that support flashbots would have a seperate private mempool run by the flashbots team, where searchers could submit their bundles, and bundles which "bid" the highest amount for any mempool transaction would have their bundle included on chain. With the bid being sent to the validator. In this situation, both the validator and the flashbots team are trusted with the signed transactions of the searchers which can be unbundled from the submitted bundles and thus exploited. 

There is also a problem of "Uncle-Bandit attacks" on Ethereum. Even if neither the validator or the flashbots team would have exploited your txs via unbundling, if your accepted bundle ended up in a block that gets uncled, anyone can take the transactions from the uncled block and easily exploit them, since there is no concept of bundles outside of flashbots, after a bundle has been included in an uncled block they are just seperate signed transactions that anyone can take and include in their new bundles.

# Unresolved questions
[unresolved-questions]: #unresolved-questions

What should be the ideal behaviour if one of the transactions in the bundle reverts? Should the entire bundle be dropped? Or should the entire bundle's transactions revert? There is also an option of reverting ALL the transactions of the signer which has the reverting transaction. There are pros and cons to each.

- If the entire bundle is dropped, another bundle can easily extract MEV from a tx in the bundle that did not revert. (If the bundle would have reverted the transaction that would have normally been includable in new bundles, would now suddenly be a duplicate transaction that is invalid)
- If the entire bundle is reverted, it would reduce potential spam from people who would spam reverting bundles that would otherwise get dropped. However there are other ways to prevent spam from affecting the validators so this is not that much of an issue.
- If only the transactions from the signer of the reverting txs are reverted, the signer of the reverting txs would be safe from any adverse effects and the other signers can have their transactions go through without the other reverts affecting them


# Future possibilities
[future-possibilities]: #future-possibilities

These sorts of bundles could unlock new types of MEV which route revenue to the users instead of validators. For examples, a wallet could add a feature which allows users to auction out their own orderflow. A user could signal their intent to sell BTC by signing a tx for a BTC -> USD swap, then the wallet could automatically recognise this and sent out an unsigned tx intent to searchers, who could bid on the right to use the intent in their bundle. Winning bid recieves a signature for their bundle which the searcher can use to extract MEV. Auction proceedings go to the user as the user is the only person with the power to fulfill the intent, as they have the keys to sign the bundle. Neither the user nor the searcher make any security assumptions as there is no unbundling risk to the searchers and the user can inspect the bid scripts and reject any scripts that result in a loss to the user, (by detecting frontrunning or other harmful forms of MEV).
