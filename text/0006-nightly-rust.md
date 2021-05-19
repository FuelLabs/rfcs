- Feature Name: nightly-rust
- Start Date: 2021-05-19
- RFC PR: [fuel-labs/rfcs#0006](https://github.com/FuelLabs/rfcs/pull/0006)
- Issue: [fuel-labs/rfcs#0005](https://github.com/FuelLabs/rfcs/issues/0005)

# Summary
[summary]: #summary

Rust uses the release train strategy for its release cycle and benefits from a highly robust regressions test codebase. This way, the stable toolchain flags the API stability and not the functionality stability. For libraries under heavy development such as ours, the API is per nature prone to change. API stability brings small or no benefit compared to the benefits provided by the nightly features.

# Motivation
[motivation]: #motivation

As opposed to normal agile flows, the release train stable cycle relies on longer iterations. This means any codebase developed under stable will be, by definition, outdated.

Traditionally, the libraries are developed under nightly in the Rust ecosystem, and only after the first major release do they consider switching to stable. The most classic example is Rocket - a four years old project that only recently is targetting stable.

The main misconception about nightly regards the meaning of stable for Rust. Quoting the Rust book:

```
Rust uses a technique called “feature flags” to determine what features are enabled in a given release. If a new feature is under active development, it lands on master, and therefore, in nightly, but behind a feature flag.
```
[link](https://doc.rust-lang.org/book/appendix-07-nightly-rust.html)

This means that features under development are protected in nightly and not available in stable. These features rely on compiler directives and cannot ever be used by accident. The implication of that is we have a reflection of stable as a subset of nightly where we do not have any unstable features flag. Hence, nightly ultimately supersede stable.

The main advantage of nightly is we have our codebase updated for upcoming major - and important - changes in the Rust environment. The next major change is the [2021 release](https://blog.rust-lang.org/2021/05/11/edition-2021.html) that brings many benefits - especially the [new resolver scheme](https://doc.rust-lang.org/cargo/reference/resolver.html#feature-resolver-version-2).

Besides that, nightly also makes available several small helpers that are very unlikely to contain inner instabilities such as [is_sorted](https://doc.rust-lang.org/std/primitive.slice.html#method.is_sorted). These helpers can significantly improve the coding efficiency without importing additional libraries or reimplementing classical algorithms.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

!! TBD !!

Explain the proposal as if it was already included in the product and you were teaching it to another developer. That generally means:

- Introducing new named concepts.
- Explaining the feature largely in terms of examples.
- Explaining how programmers should *think* about the feature, and how it should impact the way they use or contribute to Fuel. It should explain the impact as concretely as possible.
- If applicable, provide sample error messages, deprecation warnings, or migration guidance.
- If applicable, describe the differences between teaching this to existing Fuel programmers and new Fuel programmers.

For implementation-oriented RFCs (e.g. for compiler internals), this section should focus on how compiler contributors should think about the change, and give examples of its concrete impact. For policy RFCs, this section should provide an example-driven introduction to the policy, and explain its impact in concrete terms.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

!! TBD !!

This is the technical portion of the RFC. Explain the design in sufficient detail that:

- Its interaction with other features is clear.
- It is reasonably clear how the feature would be implemented.
- Corner cases are dissected by example.

The section should return to the examples given in the previous section, and explain more fully how the detailed proposal makes those examples work.

# Drawbacks
[drawbacks]: #drawbacks

By using nightly we need to pay extra attention during the PR reviews to evaluate trade-offs when using unstable features.

Also, there is a chance the used features will have their API reworked, and this will imply code update. This may lead to the need of freezing the CI versions to some specific release while these updates are not done.

The language tooling of Rust is well known to be very unstable with nightly. This impacts mainly `rustfmt` and `rls - Rust Language Server`. The community created [this panel](https://rust-lang.github.io/rustup-components-history/) to keep track of the available tools.

# Rationale and alternatives
[rationale-and-alternatives]: #rationale-and-alternatives

!! TBD !!

- Why is this design the best in the space of possible designs?
- What other designs have been considered and what is the rationale for not choosing them?
- What is the impact of not doing this?

# Prior art
[prior-art]: #prior-art

!! TBD !!

Discuss prior art, both the good and the bad, in relation to this proposal.
A few examples of what this can include are:

- For language, client, forc, interpreter, network, wallet, and compiler proposals: Does this feature exist in other programming languages and what experience have their community had?
- For process policy, coding standards and community proposals: Is this done by some other team or community and what were their experiences with it?
- For other teams: What lessons can we learn from what other communities have done here?
- Papers: Are there any published papers or great posts that discuss this? If you have some relevant papers to refer to, this can serve as a more detailed theoretical background.

This section is intended to encourage you as an author to think about the lessons from other projects, provide readers of your RFC with a fuller picture.
If there is no prior art, that is fine - your ideas are interesting to us whether they are brand new or if it is an adaptation from other languages.

Note that while precedent set by other languages or projects is some motivation, it does not on its own motivate an RFC.
Please also take into consideration that Fuel sometimes intentionally diverges from common language features.

# Unresolved questions
[unresolved-questions]: #unresolved-questions

!! TBD !!

- What parts of the design do you expect to resolve through the RFC process before this gets merged?
- What parts of the design do you expect to resolve through the implementation of this feature before stabilization?
- What related issues do you consider out of scope for this RFC that could be addressed in the future independently of the solution that comes out of this RFC?

# Future possibilities
[future-possibilities]: #future-possibilities

!! TBD !!

Think about what the natural extension and evolution of your proposal would
be and how it would affect the language and project as a whole in a holistic
way. Try to use this section as a tool to more fully consider all possible
interactions with the project and language in your proposal.
Also consider how this all fits into the roadmap for the project
and of the relevant sub-team.

This is also a good place to "dump ideas", if they are out of scope for the
RFC you are writing but otherwise related.

If you have tried and cannot think of any future possibilities,
you may simply state that you cannot think of anything.

Note that having something written down in the future-possibilities section
is not a reason to accept the current or a future RFC; such notes should be
in the section on motivation or rationale in this or subsequent RFCs.
The section merely provides additional information.
