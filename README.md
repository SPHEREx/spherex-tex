# spherex-tex

**SPHEREx TeX document resources and Docker environment.**

Contents:

- [How to compile a document with Docker](#how-to-compile-a-document-with-docker)
- [spherex class reference](#spherex-class-reference)
  - [spherex document class and options](#spherex-documentclass-and-options)
  - [Preamble commands](#preamble-commands)
  - [Title page](#title-page)
  - [Macros](#macros)
- [BibTeX bibliography](#bibtex-bibliography)

## How to compile a document with Docker

To compile a document using the Docker image and the default SPHEREx Makefiles:

```sh
docker run -v `pwd`:/workspace -w /workspace ghcr.io/spherex/spherex-tex:latest sh -c 'make'
```

[Learn more about Docker and how to install it.](https://www.docker.com/products/docker-desktop)

## spherex class reference

`spherex-tex` provides a custom class, named `spherex`, for formatting TeX documents. This section describes the commands and options that are provided by the `spherex` class.

### spherex document class and options

Use the `spherex` class through the `\documentclass` command:

```tex
\documentclass[MS]{spherex}
```

In this example, the `MS` option shows that the document is a _module specification_ (see below).

#### Document category options

Each SPHEREx document category has a corresponding option:

| Option | Document category     | Example                       |
| ------ | --------------------- | ----------------------------- |
| RQ     | Requirements          | `\documentclass[RQ]{spherex}` |
| PM     | Project Management    | `\documentclass[PM]{spherex}` |
| MS     | Module Specification  | `\documentclass[MS]{spherex}` |
| DP     | Data Products         | `\documentclass[DP]{spherex}` |
| TN     | Technical Note        | `\documentclass[TN]{spherex}` |
| IF     | Interface             | `\documentclass[IF]{spherex}` |
| TR     | Test/Technical Report | `\documentclass[TR]{spherex}` |
| RV     | Review Materials      | `\documentclass[RV]{spherex}` |
| OP     | Operations Procedures | `\documentclass[OP]{spherex}` |

### Preamble commands

`spherex` provides several commands that you can use in the preamble (before `\begin{document}`) to set metadata that appears in the document's title and header/footer.

#### \spherexHandle

The document's handle. For example:

```tex
\spherexHandle{SSDC-MS-000}
```

See also: [`\thehandle`](#thehandle) macro.

#### \version

This command specifies the document's version:

```tex
\version{1.0}
```

See also: [`\theversion`](#theversion) macro.

#### \docDate

This command specifies the publication date in `YYYY-MM-DD` format:

```tex
\docDate{2021-01-01}
```

In the SPHEREx document templates, the `\docDate` is automatically set from Git metadata. However, you can override that date by setting the date with this command _after_ the `\input{meta}` line in the preamble.

#### \title and \shortTitle

For most document categories, use the `\title` command to set the documents title. You can optionally also set an abbreviated title with the `\shortTitle` command that is used in page headers:

```tex
\title{Technical note title}
\shortTitle{Short Title}
```

#### \spherexlead

This command specifies the document's SPHEREx lead author:

```tex
\spherexlead[email=galileo@example.com]{Galileo Galilei}
```

#### \ipaclead

This command specifies the document's IPAC lead author:

```tex
\ipaclead[email=galileo@example.com]{Galileo Galilei}
```

#### \interfacepartner

This command specifies the document's interface partner (for SSDC-IF documents):

```tex
\interfacepartner{ABC}
```

#### \author and \person

Aside from the lead authors (`\ipaclead` and `\spherexlead`), authors are specified with the `\author` command. Each author is on a separate line (using `\\`) and marked-up with a `\person` command:

```tex
\author{
  \person[email=galileo@example.com]{Galileo~Galilei} \\
  \person{Isaac~Newton}
}
```

You can optionally set an author's email address with the `email` keyword option.

#### \approved

This command provides metadata about the document's approval:

```tex
\approved{2021-01-01}{Edwin Hubble}
```

The first argument is the date of approval (`YYYY-MM-DD` format).

The second argument is the approver's name.

#### \modulename

For module specification (`MS`) documents, this command sets the name of the module:

```tex
\modulename{Example Module}
```

**This command replaces the standard `\title` command for setting the document's title in MS documents.**

See also: [`\themodulename`](#themodulename) macro.

#### \pipelevel

For module specification (`MS`) documents, this command sets the pipeline level:

```tex
\pipelevel{L2}
```

See also: [`\thepipelevel`](#thepipelevel) macro.

#### \diagramindex

For module specification (`MS`) documents, this command sets the diagram index:

```tex
\diagramindex{13}
```

See also: [`\thediagramindex`](#thediagramindex) macro.

#### \difficulty

For module specification (`MS`) documents, this command sets the "difficulty" metadata:

```tex
\difficulty{Low}
\difficulty{Medium}
\difficulty{High}
\difficulty{Unassigned}
```

See also: [`\thedifficulty`](#thedifficulty) macro.

### Title page

The title page is generated by the `\maketitle` command, which you should include right after the `\begin{document}` command. The `spherex` class customizes the appearance of the title page based on the document category and the available metadata.

### dochistory

The \dochistory environment creates a table with a document's change history.
Within the `dochistory` environment, you can add individual change records with the `\addtohist` command:

```tex
\begin{dochistory}
\addtohist{0.1}{2020-01-01}{Initial draft.}{Galileo Galilei}
\addtohist{1.0}{2021-01-01}{Initial accepted version.}{Galileo Galilei}
\end{dochistory}
```

The arguments to the `\addtohist` command are:

1. Version
2. Date
3. Description of change
4. Responsible persons

### Macros

The `spherex` class provides common macros. See the bottom of the [spherex.cls](./texmf/tex/latex/spherex/spherex.cls) source for a listing.

#### \thediagramindex

Use the `\thediagramindex` macro to print the pipeline module's diagram index, which is set in the preamble by the [`\diagramindex`](#diagramindex) command.

#### \thedifficulty

Use the `\thedifficulty` macro to print the pipeline module's difficulty level, which is set in the preamble by the [`\difficulty`](#difficulty) command.

#### \thehandle

Use the `\thehandle` macro to print the document's handle, which is set in the preamble by the [`\spherexhandle`](#spherexhandle) command.

#### \themodulename

Use the `\themodulename` macro to print the pipeline module name, which is set in the preamble by the [`\modulename`](#modulename) command.

#### \thepipelevel

Use the `\thepipelevel` macro to print the pipeline module's level, which is set in the preamble by the [`\pipelevel`](#pipelevel) command.

#### \theversion

Use the `\theversion` macro to print the document's version, which is set in the preamble by the [`\version`](#version) command.

## BibTeX bibliography

spherex-tex includes a centrally maintained BibTeX file for the SPHEREx project: [texmf/bibtex/bib/spherex.bib](./texmf/bibtex/bib/spherex.bib). To use this bibliography from documents, include:

```tex
\bibliography{spherex}
```

## Developer guide

When adding or removing files from the [texmf](./texmf) directory, also update the [texmf/ls-R](./texmf/ls-R) file:

```sh
mktexlsr --verbose texmf
```

The [test](./test) directory contains sample documents that are configured to compile using the locally-cloned texmf directory.
You can compile all test documents:

```sh
cd test
./test.sh
```
