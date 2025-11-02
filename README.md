# UofG Stats Book Quarto Template

This document explains how to install, set up, and customize the UofGStats book Quarto template.  

---

## Table of Contents

- [Installation](#installation)  
  - [Option 1: Clone the repository](#option-1-clone-the-repository)  
  - [Option 2: Use the Quarto template](#option-2-use-the-quarto-template)  
- [Setting up your chapters](#setting-up-your-chapters)  
- [Adding resources](#adding-resources)  
  - [Global resources](#global-resources)  
  - [Chapter-specific resources](#chapter-specific-resources)  
- [Customizing colours and boxes](#customizing-colours-and-boxes)  
  - [1. Default colours and box types](#1-default-colours-and-box-types)  
  - [2. Dark-mode colours](#2-dark-mode-colours)  
- [Template colours and styles for HTML and PDF](#template-colours-and-styles-for-html-and-pdf)  

---

## Installation

You can set up this template in one of two ways: by cloning the repository directly, or by using Quarto’s built-in template system.

### Option 1: Clone the repository

If you want a full copy of the project structure, you can clone the repository:

```bash
git clone https://github.com/UofGStats/booktemplate.git
```

After cloning, remove the existing Git history and links to the original repository:

```bash
rm -rf .git
git init
```

This ensures your new project starts clean, without any connection to the source repository.

### Option 2: Use the Quarto template

To create a new project from the template using Quarto:

1. Open your preferred editor — **RStudio**, **Positron**, or **VS Code**.  
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

---

## Adding resources

### Global resources

Files needed for **every chapter** should go in the `resources/` folder at the root of your project. Reference these files directly from your `.qmd` files without needing `../` in the path, for example:

```markdown
![Example Image](resources/example-image.png)
```

### Chapter-specific resources

Files used only for a single chapter can be placed in the same folder as the `.qmd` file (or subfolders). Reference them as usual:

```markdown
![Local Image](figures/local-figure.png)
```

---

## Customizing colours and boxes

The template provides colored “numbered boxes” that can be customized for light and dark modes.

### 1. Default colours and box types

Edit `_numbered-boxes.yml` to define:

- Colours for each box type  
- Names of box types  
- Which box types are available  

Documentation: [custom-numbered-blocks repository](https://github.com/ute/custom-numbered-blocks)

### 2. Dark-mode colours

Edit `themes/dark-styles-boxes.scss`. Each box type needs an `@include` call, using colours defined at the top of the file.

---

## Template colours and styles for HTML and PDF

### For HTML

The template separates styling based on purpose and mode:

- **UofG colours**: `themes/_colours.scss`  
- **Light-mode styles**: `themes/light-styles.css`  
- **Dark-mode styles**: `themes/dark-styles.css`  
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

