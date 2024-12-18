# shdoc-advanced

shdoc-advanced is a documentation generator for bash/zsh/sh for generating API documentation in Markdown from
shell scripts source.

shdoc-advanced parses [annotations](#features) in the beginning of a given file and alongside function
definitions, and creates a markdown file with ready to use documentation.

## Index

* [Example](#example)
* [Annotations](#annotations)
* [Usage](#usage)
* [Installation](#installation)
* [More examples](#examples)
* [License](#license)

## Example

<table border="0">
 <tr>
    <td style="vertical-align: top">

Generate documentation with the following command:
~~~bash
$ shdoc < lib.sh > doc.md
~~~

_Source_ [examples/readme-example.sh](examples/readme-example.sh)<br />
_Output_: [examples/readme-example.md](examples/readme-example.md)<br/><br/>
~~~bash
#!/bin/bash
# @file libexample
# @brief A library that solves some common problems.
# @description
#     The project solves lots of problems:
#      * a
#      * b
#      * c
#      * etc

# @description My super function.
# Not thread-safe.
#
# @example
#    echo "test: $(say-hello World)"
#
#
# @option -h | --help Display help.
# @option -v<value> | --value=<value> Set a value.
#
# @arg $1 string A value to print
#
# @stdout Output 'Hello $1'.
#   It hopes you say Hello back.
# @stderr Output 'Oups !' on error.
#   It did it again.
#
# @exitcode 0 If successful.
# @exitcode 1 If an empty string passed.
#
# @see validate()
# @see [shdoc-advanced](https://github.com/MediaEase/shdoc-advanced).
say-hello() {
    if [[ ! "$1" ]]; then
        echo "Oups !" >&2
        return 1;
    fi

    echo "Hello $1"
}
~~~


</td>
<td>

~~~markdown
# libexample

A library that solves some common problems.

## Overview

The project solves lots of problems:
* a
* b
* c
* etc

## Index

* [say-hello](#say-hello)

### say-hello

My super function.
Not thread-safe.

#### Example

```bash
echo "test: $(say-hello World)"
```

#### Options

* **-h** | **--help**

  Display help.

* **-v\<value\>** | **--value=\<value\>**

  Set a value.

#### Arguments

* **$1** (string): A value to print

#### Exit codes

* **0**: If successful.
* **1**: If an empty string passed.

#### Output on stdout

* Output 'Hello $1'.
  It hopes you say Hello back.

#### Output on stderr

* Output 'Oups !' on error.
  It did it again.

#### See also

* [validate()](#validate)
* [shdoc-advanced](https://github.com/MediaEase/shdoc-advanced).

~~~

</td>
</tr></table>


## Features

### `@name`

A name of the project, used as a title of the doc. Can be specified once in the beginning of the
file.

**Example**

```bash
#!/bin/bash
# @name MyLibrary
```

### `@file`

Identical to [@name](#name).

### `@brief`

A brief line about the project. Can be specified once in the beginning of the file.<br>

**Example**
```bash
#!/bin/bash
# @brief A library to solve a few problems.
```

### `@description`

A multiline description of the project/section/function.
* Can be specified once for the whole file in the beginning of the file.
* Can be specified once for a section of the file. See [@section](#section).
* Can be specified once for on top of a function definition.

**Example**
```bash
#!/bin/bash
# @description A long description of the library.
# Second line of the project description.

# @description My super function.
# Second line of my super function description.
function super() {
    ...
}
```

### `@section`

The name of a section of the file. Can be used to group functions.

**Example**
```bash
# @section My utilities functions
# @description The following functions can be used to solve problems.
```

### `@example`

A multiline example of the function usage. Can be specified only alongside the function definition.
You can have as many @example you want.

**Example**
```bash
# @example
#    echo "test: $(say-hello World)"
say-hello() {
    ...
}
```

### `@option`

A description of an option expected to be passed while calling the function.
Can be specified multiple times to describe any number of arguments.
If an option argument is expected, it must be specified between `<` and `>`

**Example**

```bash
# @description Says hi to a given person.
# @option -h A short option.
# @arg --value=<value> A long option with argument.
# @arg -v<value> | --value <value> A long option with short option alternative.
say-hello() {
    ...
}
```

### `@arg`

A description of an argument expected to be passed while calling the function.
Can be specified multiple times to describe any number of arguments.

**Example**

```bash
# @description Says hi to a given person.
# @arg $1 string A person's name.
# @arg $2 string Message priority.
say-hello() {
    ...
}
```

### `@noargs`

A note that the function does not expect any arguments to be passed.

**Example**

```bash
# @description Says 'hello world'.
# @noargs
say-hello-world() {
    ...
}
```

### `@set`

A description of a global variable that is set while calling the function.
Can be specified multiple times to describe any number of variables

**Example**

```bash
# @description Sets hello to the variable REPLY
# @set REPLY string Greeting message.
set-hello() {
    ...
}
```

### `@exitcode`

Describes an expected exitcode of the function.
Can be specified multiple times to describe all possible exitcodes and their conditions.

**Example**

```bash
# @description Says 'hello world'.
# @exitcode 0 If successful.
# @exitcode 1 If world is gone.
say-hello-world() {
    ...
}
```

### `@stdin`

The expected input to the function call from `stdin` (usually the terminal or command line)

**Example**

```bash
# @description Asks name.
# @stdin The users name from the terminal/command line.
say-hello-world() {
    ...
}
```

### `@stdout`

An expected output of the function call.

**Example**

```bash
# @description Says 'hello world'.
# @stdout A path to a temporary file with the message.
say-hello-world() {
    ...
}
```

### `@stderr`

An expected output of the function call on `/dev/stderr`.

**Example**

```bash
# @description Says 'hello world'.
# @stderr A error message when world is not available.
say-hello-world() {
    ...
}
```

### `@see`

Create a link on the given function in the "See Also" section.

**Example**

```bash
# @see say-hello
# @see text with [markdown link](./other-file#other-function)
say-hello-world() {
    ...
}
```

### `@internal`

When you want to skip documentation generation for a particular function, you can specify this
`@internal` tag.
It allows you to have the same style of doc comments across the script and keep internal
functions hidden from users.

**Example**

```bash
# @internal
show-msg() {
    ...
}
```

### `@deprecated`

The `@deprecated` annotation marks a function as deprecated and adds a deprecation notice to the generated documentation. Additional annotations like `@replacement` and `@eol` can specify a replacement function and the end-of-life date/version.

**Example**

```bash
# @description This function is deprecated.
# @deprecated from 1.0.0
# @replacement new-function
# @eol 2.0.0
deprecated-function() {
    ...
}
```

**Output**

This function is deprecated.

> [!WARNING]
> **Deprecation Notice:**  
> The `deprecated-function` command has been **deprecated** as of **1.0.0** and will be removed entirely in **2.0.0**.  
> **Replacement:** Use `new-function` instead.

### `@alias`

The `@alias` annotation allows defining an alternative name for a function. The alias is used in the generated documentation instead of the original function name.

## Example

```bash
# @description Function to greet a user.
# @alias greet
say-hello() {
    echo "Hello!"
}
```

**Output**
```bash
### greet

Function to greet a user.
```

### Github Alerts

The GitHub alerts feature enhances your documentation by adding specific callouts or highlights in the form of annotated blocks. These callouts can be used to emphasize important information, provide warnings, tips, or even draw attention to specific issues.

Supported annotations:
- `@note` – General notes or observations.
- `@tip` – Useful tips or suggestions.
- `@important` – Highlights crucial information.
- `@warning` – Warns the user of potential issues or important considerations.
- `@caution` – Alerts users to proceed carefully.

## Example

```bash
# @description Processes a sensitive operation.
# @warning Ensure you have a backup before proceeding.
# @caution This function can overwrite important data if used incorrectly.
process-sensitive-operation() {
    echo "Processing..."
}
```

**Output**
```
### process-sensitive-operation

Processes a sensitive operation.
```
> [!WARNING]
> **Warning:** Ensure you have a backup before proceeding.

> [!CAUTION]
> **Caution:** This function can overwrite important data if used incorrectly.

# Configuration Reference

The `Shdocfile` allows you to customize the behavior of `shdoc-advanced`. It is a simple configuration file where you can set options to enhance the generated documentation.

## Supported Options

### `version_in_name`

Controls whether the version of the script is appended to its title in the generated documentation. The version is extracted from the `@version` annotation.

**Example Shdocfile**

```bash
version_in_name=true
```

**Input script**
```bash
# @file my_script.sh
# @version 2.3.1
```
**Generated Output**
`# my_script.sh (v2.3.1)`

If `version_in_name` is not set or is `false`, the title does not include the version:
`# my_script.sh`

**Generated Output**
`# my_script.sh (v2.3.1)`

### `footer`

Adds a footer at the end of the generated documentation. This is useful for branding or providing additional context.

**Example Shdocfile**

```bash
footer=Generated using shdoc-advanced v1.8.0
```

**Generated Output**
```bash
---
Generated using shdoc-advanced v1.8.0
```

If `footer` is not set, no footer will be added.


## Usage

To generate documentation, `shdoc-advanced` expects a shell script with comments on stdin and will produce markdown as stdout.

```bash
$ shdoc < your-shell-script.sh > doc.md
```

### Version

The `version` or `v` flag provides a quick way to print the current version of `shdoc-advanced`.

Usage:

```bash
$ shdoc version
1.8.0

$ shdoc v
1.8.0
```


## Installation

### Using Git

> [!NOTE]
> shdoc-advanced requires gawk: `apt-get install gawk`

```bash
git clone --recursive https://github.com/MediaEase/shdoc-advanced
cd shdoc
sudo make install
```

## Examples

See example documentation on:

* [tests.sh](https://github.com/reconquest/tests.sh/blob/master/REFERENCE.md)
* [coproc.bash](https://github.com/reconquest/coproc.bash/blob/master/REFERENCE.md)

# LICENSE

MIT
