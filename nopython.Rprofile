# Rename this file to .Rprofile to make it run before
# any rendering happens.

# Hard-coded value: to disable python rendering
disable_python = TRUE

# This sets eval: false on all python chunks and also..
# an r chunk called 'reticulate-setup'

# If you want to change this to read disable_python from a
# global environment variable then you can use Quarto
# profiles, or you can set a variable value in a file
# called _environment and place it at the project root
# then use this line of code to read it
# disable_python <- as.logical(Sys.getenv("DISABLE_PYTHON", "FALSE"))

message("\n--- Python execution control ---\n",
        "--- Loading from .Rprofile file ---\n\n",
        "disable_python = ", disable_python, "\n",
        if (isTRUE(disable_python)) 
          "** Python and reticulate-setup chunks will NOT be evaluated. **\n"
        else 
          "** NO edits being made to Python evaluation. **\n")


knitr::opts_hooks$set(engine = function(options) {
  if (isTRUE(disable_python) &&
      (options$engine == "python" ||
       (tolower(options$engine) == "r" && identical(options$label, "reticulate-setup")))) {
    
    message(paste("\nNot evaluating chunk:", options$label))
    options$eval <- FALSE
  }
  
  options
})

