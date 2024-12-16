#!/bin/bash

tests:put input <<EOF
# @name Deprecated Command Example
# @description Demonstrates the new detailed deprecation notice.

# @deprecated from v2.4
# @replacement my:new-command
# @eol v3.0
my:legacy-command() {
    echo "This is a legacy command."
}
EOF

tests:put expected <<EOF
# Deprecated Command Example

## Overview

Demonstrates the new detailed deprecation notice.

## Index

* [my:legacy-command](#mylegacy-command)

### my:legacy-command

> [!WARNING]
> **Deprecation Notice:**  
>  
> The \`my:legacy-command\` command has been **deprecated** as of **v2.4** and will be removed entirely in **v3.0**.  
>  
> **What does this mean?**  
> - The \`my:legacy-command\` command will continue to be available until its end-of-life. 
>   After that date, it will no longer be accessible. 
>   However, you can use \`my:new-command\`, which offers improved functionality and better performance.  
>  
> **Removal Timeline:**  
> - Deprecated in: v2.4  
> - Planned removal: v3.0

EOF

assert
