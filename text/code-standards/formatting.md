# Formatting

All Rust projects should follow the same formatting standard. This standard is
to be documented in a `rustfmt.toml` file in the top level of each project.
See below for an example of the default values for the file.

```toml
fn_args_layout = "Tall"
hard_tabs = false
match_arm_leading_pipes = "Never"
max_width = 100
merge_derives = true
remove_nested_parens = true
reorder_imports = true
reorder_modules = true
tab_spaces = 4
use_field_init_shorthand = false
use_small_heuristics = "Default"
use_try_shorthand = false
```