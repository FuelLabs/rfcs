- Feature Name: native-multi-token
- Start Date: 2023-04-30
- RFC PR: [fuel-labs/rfcs#17](https://github.com/FuelLabs/rfcs/pull/17)
- Issue: [fuel-labs/rfcs#18](https://github.com/FuelLabs/rfcs/issues/18)

# Summary
[summary]: #summary

This proposal introduces multi-token support to the Fuel blockchain, similar to the ERC-1155 token standard in Ethereum. This change will enable contracts to manage multiple token types, providing greater flexibility and functionality for developers and users.

# Motivation
[motivation]: #motivation

Currently, the Fuel blockchain has a native token system where each contract address has an associated token. This limits the capabilities of developers, as they can only create one token per contract. By implementing multi-token support, Fuel can provide a more greater functionality for developers, allowing them to create more complex and feature-rich applications. This change will also allow for better interoperability with other blockchains and projects that utilize multi-token systems, such as ERC-1155 in Ethereum, aswell as allow developers to create native NFTs.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

With the implementation of multi-token support, developers will be able to create contracts that manage multiple token aswell as create NFTs. Developers can access this extended functionality from the new module in the std library, `std::multitoken`.

For example, a game developer could create a single contract to manage multiple in-game assets, such as weapons, armor, and currency. Players could then trade, sell, or purchase these assets using a single contract, rather than needing to interact with multiple contracts for each asset type.

This may involve updating existing contracts or creating new ones that take advantage of the new features.

Example:

```rust
contract;

use std::{
    multitoken::{
        mint_to_address,
        transfer_to_address,
        balance_of,
        total_supply,
    },
};

abi MultiTokenContract {
    fn mint(sub_id: u64, amount: u64, recipient: Address);
    fn transfer(sub_id: u64, amount: u64, recipient: Address);
    fn balance_of(sub_id: u64, owner: Address) -> u64;
    fn total_supply(sub_id: u64) -> u64;
}

impl MultiTokenContract for Contract {
    fn mint(sub_id: u64, amount: u64, recipient: Address) {
        mint_to_address(sub_id, amount, recipient);
    }

    fn transfer(sub_id: u64, amount: u64, recipient: Address) {
        transfer_to_address(sub_id, amount, recipient);
    }

    fn balance_of(sub_id: u64, owner: Address) -> u64 {
        balance_of(sub_id, owner)
    }

    fn total_supply(sub_id: u64) -> u64 {
        total_supply(sub_id)
    }
}
```

In this example, the contract includes functions for minting, transferring, querying balances, and checking the total supply of a specific token type, as specified by the `sub_id` parameter.

The `sub_id` is used along with the `ContractId` of the currently executing contract to get an `AssetId` with the following pseudocode: `asset_id = sha256((contract_id, sub_id))` 

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

To implement ERC-1155 multi-token support, we will extend the standard library with a new module, std::multitoken. This module will provide all the functions seen in the std::token module, such as mint, burn, transfer, balance_of, and total_supply. Each of these functions will take an additional sub_id parameter of type u64 to specify which token type is being acted upon.

Contracts will be updated to use the new std::multitoken module for handling multiple tokens. The original std::token will change its underlying implementation to always use the 0 sub_id. This implementation will make it so all the previous contracts using the token module will not have any breaking changes, and will also ensure theres a simpler single token api available for simple applications which only need 1 token, whilst still functioning under the same standard.

# Drawbacks
[drawbacks]: #drawbacks

Having two modules for multi-token and single-token functions might be confusing. If the token module is replaced with the new functionality of multi-tokens then simple contracts which only need one token may be burdened with having to deal with adding a 0 sub_id to all their function calls. It would also break all contracts using the token module.

# Rationale and alternatives
[rationale-and-alternatives]: #rationale-and-alternatives

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?

- Implementing an ERC-1155 type multi token contract in Sway would be bad for standardisation of tokens, and would be account based rather than UTXO, hence would not be parallelisable
- Creating multiple contracts for each token could be plausible for small number of tokens, but would be hard to manage with a larger number of tokens
- Not implementing multi-tokens would mean projects like bridges would have to deploy a new contract for every token they bridge over. Bridging over erc1155 tokens from ethereum would be a hard task.


# Prior art
[prior-art]: #prior-art

ERC-1155 is a widely used and accepted token standard in the Ethereum ecosystem. The addition of multi-token support to the Fuel VM builds upon the success and lessons learned from the Ethereum community. The implementation proposed in this RFC is inspired by the design and implementation of the ERC-1155 standard and aims to provide similar functionality and benefits to the Fuel VM.

# Unresolved questions
[unresolved-questions]: #unresolved-questions

- Are there any performance or security concerns that need to be addressed during the implementation of this feature?
- Are there any additional functions or features that should be considered for inclusion in the `std::multitoken` module?
- Should the token module in the standard library have an updated api or should a new module with a new multi-token api be made?

# Future possibilities
[future-possibilities]: #future-possibilities

The implementation of ERC-1155 multi-token support opens up several future possibilities for the Fuel VM:

- The introduction of non-fungible tokens (NFTs) with unique properties and metadata, allowing for the creation of digital art, collectibles, and other unique assets.
- The development of more advanced and feature-rich decentralized applications (dApps) that take advantage of the increased versatility provided by multi-token support.
- Improved cross-chain compatibility and integration with other blockchain platforms and ecosystems that utilize ERC-1155 tokens.
