# Code Standards

- Feature Name: N/A
- Start Date: 2021-05-19
- RFC PR: [fuel-labs/rfcs#0004](https://github.com/FuelLabs/rfcs/pull/4)
- Issue: N/A

## Summary

[summary]: #summary

The RFC establishes initial code standards for the FuelVM project. The code
standards specify recommended default behaviors across the codebase. This will
include best practices and stylistic preferences of the core team to ensure
consistency and quality.

## Motivation

[motivation]: #motivation

Code standards are a useful tool to improve maintainability and accessibility
of the code. They also provide the team a set of consistent standards that
can be used to evaluate code submissions.

## Guide-level explanation

[guide-level-explanation]: #guide-level-explanation

Code standards live in the RFC repo, since they can be considered as an
appendix to this RFC. These standards may be replicated to other locations for
ease of access, but the version here will be considered the source of truth.

For future changes to the code standard, make a new RFC explaining the change
along with the actual proposed changes to the code standards chapter
of this mdbook.

## Drawbacks

[drawbacks]: #drawbacks

Debating code standards can lead to bikeshedding and distract developers from
their tasks.

However, this may be offset by sticking to commonly established standards and
by asserting that these are meant to be defaults that can be deviated from on
a case-by-case basis if justified.

## Rationale and alternatives

[rationale-and-alternatives]: #rationale-and-alternatives

Using an RFC process to manage code style and standards
[has been done](https://rust-lang.github.io/rfcs/2436-style-guide.html)
by the rust-lang team.

As far as specific standards, Rust has
[API design guidelines](https://rust-lang-nursery.github.io/api-guidelines/).

## Unresolved questions

[unresolved-questions]: #unresolved-questions
