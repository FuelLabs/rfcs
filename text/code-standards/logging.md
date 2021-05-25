# Logging

Logging should be done using the [tracing library](https://docs.rs/tracing/)
to ensure consistent log output from all bins and libs.

| Level | When to use |
|---|---|
| ERROR | Designates very serious errors. |
| WARN | Designates hazardous situations. |
| INFO | Designates useful information. |
| DEBUG | Designates lower priority information. |
| TRACE | Designates very low priority, often extremely verbose, information. |
