# UofGStats Book Quarto Template

This document explains how to install, set up, and customize the UofGStats book Quarto template.  

**Warning**: This template contains python code as well as R code. If you don't have python installed and don't wish to use it, make sure to check out the advice on [how to disable python](#disabling-python).

---

## Table of Contents

- [Installation](#installation)  
  - [Option 1: Clone the repository using the Github Template](#option-1-use-the-github-template-recommended)  
  - [Option 2: Use the Quarto template function (only for a public repo)](#option-2-use-the-quarto-template-this-only-works-if-the-repository-is-public)  
- [Setting up your chapters](#setting-up-your-chapters)  
- [Adding resources](#adding-resources)
- [Customizing colours and boxes](#customizing-colours-and-boxes)  
  - [1. Default colours and box types](#1-default-colours-and-box-types)  
  - [2. Dark-mode colours](#2-dark-mode-colours)  
- [Template colours and styles for HTML and PDF](#template-colours-and-styles-for-html-and-pdf)  
- [Python](#python)
  - [Disabling Python](#disabling-python)
  - [Using Python](#using-python)


---

## Installation

You can set up this template in one of two ways: by cloning the template repository directly, or by using Quarto’s built-in template system (the latter only works if we make the repo public).

The recommended route to use this template is to use Github's `Use this template` functionality. Then you get your own version of this repository for your own notes, not linked to the template.

### Option 1: Use the GitHub Template (recommended)

1. Go to the [template repository on GitHub](https://github.com/UofGStats/booktemplate).  
2. Find and click the `Use this template` button, then “Create a new repository”.  
3. Choose a name for your new project and click **Create repository**.

This will generate a new repository with the same structure, **without copying the Git history** from the template.

Once created, clone your new repository locally:

```bash
git clone https://github.com/<your-username>/<your-new-repo>.git
cd <your-new-repo>
```

### Option 1b: Clone the repository (not recommended unless you want to propose changes to the template)

If you want a full copy of the project structure, you can clone the repository:

```bash
git clone https://github.com/UofGStats/weektemplate.git
```

After cloning, remove the existing Git history and links to the original repository:

```bash
rm -rf .git
git init
```

This ensures your new project starts clean, without any connection to the source repository.

### Option 2: Use the Quarto template (This only works if the repository is Public)

To create a new project from the template using Quarto:

1. Open your preferred editor - **RStudio**, **Positron**, or **VS Code**.  
2. Decide where you want to store your book materials.  
3. Open a **terminal** in the *parent folder* of that location.  

Then run:

```bash
quarto use template UofGStats/booktemplate
```

The automatic installation of extensions can sometimes be unreliable. To ensure all required extensions are installed correctly, run:

```bash
quarto add ute/custom-numbered-blocks
quarto add UofGStats/acc-tools
quarto add quarto-ext/fontawesome
quarto add quarto-ext/latex-environment
```

Optional extensions (install if needed):

```bash
# For invisible text
quarto add david-hodge/invis

# For embedding external content via iframes
quarto add david-hodge/iframe
```

---

## Setting up your chapters

All chapters should be placed in the root of the project folder. We recommend naming them sequentially, for example:

```
Week1.qmd
Week2.qmd
Week3.qmd
```

Each `.qmd` file should begin with a level-1 heading (a line starting with `#`) to provide a chapter title and enable automatic numbering in the output:

```markdown
# Introduction to Regression
```

All chapters will be rendered together into a single HTML or PDF output.

You can give them descriptive names instead like `Introduction.qmd` and `Regression.qmd`, but then you should ensure you specify their rendering order in the `_quarto.yml` file.

You **will want** to edit the `_quarto.yml` section describing the `chapters:` anyway.

### Customized features

Although all chapters are rendered into a single book or website, each chapter can have custom options. For example, you may wish to use the `UofGStats/acc-tools` global code toggle button only in chapters which use both R and Python. 

At the top of the chapter file, add:
```markdown
---
filters:
  - acc-tools
  
acc-tools:
  global-toggle: false
---
```

This disables the global toggle button for this chapter while still loading the other `acc-tools` features.

Full documentation for `acc-tools` is available at [https://github.com/UofGStats/acc-tools](https://github.com/UofGStats/acc-tools)

---

## Adding resources

It's highly recommended that all files that chapters need be placed in the `resources/` folder at the root of your project. To help manage a large number of resources, you can create subfolders inside `resources/`. For example, you could group them by type (e.g., `images`, `data`, `figures`) or by chapter (e.g., `week1`, `week2`). How you organize them is up to you.

Reference these files directly from your `.qmd` files remembering they live inside `resources/`, for example:

```markdown
![Example Image](resources/images/example-image.png)
```

This approach keeps all resources centralized while allowing flexible organization for larger projects.

---

## Customizing colours and boxes

The template provides coloured “numbered boxes” that can be customized for light and dark modes. These are from an extension created by Ute Hahn:

Full documentation: [custom-numbered-blocks repository](https://github.com/ute/custom-numbered-blocks)

### 1. Default colours and box types

Edit `_numbered-boxes.yml` to define:

- Colours for each box type  
- Names of box types  
- Which box types are available  

I've added a fairly long list of sample box types and colours but you're welcome to change them, or just not use them.

### 2. Dark-mode colours

Edit `themes/dark-styles-boxes.scss`. Each box type needs an `@include` call, using colours defined at the top of the file.

*It's possible a future version of this extension will do away with the need to control light and dark mode colours in different places. Indeed if you fully disable the dark mode then you only need one.*

### Usage

These coloured boxes are created in your notes with standard Quarto syntax. You create a box with syntax like this:

```markdown
:::{.Example}
Contents goes here
:::
```
The name `.Example` refers to the name `Example` defined in the above documents. You can also add a custom title to the box as usual with a `##` line at the stop. Full documentation for use of these boxes is linked above.

---

## Template colours and styles for HTML and PDF

### For HTML

The template separates styling based on purpose and mode:

- **UofG colours**: `themes/_colours.scss`  
- **Light-mode styles**: `themes/light-styles.scss`  
- **Dark-mode styles**: `themes/dark-styles.scss`  
- **Global styles (both modes)**: `themes/global-styles.scss`  

Use these files to customize HTML typography, spacing, colours, and other visual elements while keeping light and dark modes separate.

### For PDF

Some elements of the PDF output are carried over automatically from HTML styles. Unsupported elements can be customized by supplementing the TeX preamble. The file `include-in-header.tex` is the global additional preamble, and you can add any additional LaTeX commands here.

### LaTeX macros

To customize LaTeX commands and macros while keeping things consistent:

- Inspect `resources/latex/mymacros.sty` to see the macros used for HTML display.  
- Any commands defined there should also be duplicated inside `include-in-header.tex` for PDF output, since HTML and PDF rendering use separate pipelines.  

This approach ensures your LaTeX macros work consistently across HTML and PDF outputs.

Note that only macros compatible with MathJax can be rendered in HTML output.


## Python

This template contains both R and Python code. So you have two options, follow the instructions below to ensure R can see Python (via the `reticulate` package).

Or, if you just want to disable python globally and test out the template then [Disabling Python](#disabling-python) is for you!

### Disabling Python

A file called `nopython.Rprofile` comes with the template. You just need to rename this file to `.Rprofile` (or add its contents to your existing `.Rprofile` file if you're using one for other purposes).

Once you have renamed `nopython.Rprofile` to `.Rprofile` when you render all python blocks will be set to `eval: false` and all r blocks with the label `reticulate-setup` will also be set to `eval: false`.

### Using Python

 So if you don't have Python installed on your system already then you will need to do that first. Once you do, install the `reticulate` package in R, and finally look for any of the code blocks that look like this:

`````markdown
```{r}
#| label: reticulate-setup
#| echo: fenced
library(reticulate)
#These next two lines need to run ONCE on your machine
#reticulate::virtualenv_create("r-quarto")
#reticulate::py_install(c("pandas","seaborn","matplotlib","numpy"), envname = "r-quarto")
reticulate::use_virtualenv("r-quarto", required = TRUE)
```
`````
Note the instructions in the block say that you will need to **once** run the two commented lines of code to setup a Python environment for your code to use. So **uncomment them**, **run them**, then **comment them again** and all should work.

Naturally this will need running on any new machine you work on. If using RStudio and `reticulate` struggles to find Python, there's a menu **Tools** -- **Global Options** -- **Python** menu to assist.

---
