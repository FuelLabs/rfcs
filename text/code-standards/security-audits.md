# Security Auditing

All CI pipelines should use [cargo audit](https://rustsec.org/) to check
for any known vulnerabilities in the dependency graph. If the audit fails, the
build should fail until fixed.

If for some reason it's not feasible to avoid the audit error by patching
dependencies, audit exceptions may be added to `.cargo/audit.toml`. When
tagging a release, any exceptions in this file at the time should be noted
and/or approved by the tech leads or security team.
