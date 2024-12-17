#!/bin/bash
# @file test/testcases/footer.test.sh
# @description Test case for verifying the footer variable in Shdocfile.

# Prepare input script
tests:put input <<EOF
# @name Footer Test
# @description This function tests the Shdocfile footer.
footer_function() {
    echo "Testing footer"
}
EOF

# Prepare Shdocfile with footer configuration
tests:put Shdocfile <<EOF
footer=This is a footer text.
EOF

# Updated expected output with correct anchor format
tests:put expected <<EOF
# Footer Test

## Overview

This function tests the Shdocfile footer.

## Index

* [footer_function](#footerfunction)

### footer_function

This function tests the Shdocfile footer.

---
This is a footer text.
EOF

# Run shdoc and compare output
tests:eval "./shdoc input > actual_output"
tests:assert-no-diff expected actual_output
