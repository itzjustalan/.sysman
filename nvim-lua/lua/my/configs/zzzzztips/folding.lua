--[[

The 'foldmethod' option (abbreviated to 'fdm') is local to each window. It determines what kind of folding applies in the current window. Possible values are:

manual – folds must be defined by entering commands (such as zf)
indent – groups of lines with the same indent form a fold
syntax – folds are defined by syntax highlighting
expr – folds are defined by a user-defined expression
marker – special characters can be manually or automatically added to your text to flag the start and end of folds
diff – used to fold unchanged text when viewing differences (automatically set in diff mode)

When foldmethod is set to manual (or marker), a fold can be created in Normal mode by typing zf{motion}. For example, zf'a will fold from the current line to wherever the mark a has been set, or zf3j folds the current line along with the following 3 lines. If you want to create folds in a text file that uses curly braces to delimit code blocks ({...}), you can use the command zfa} to create a fold for the current code block.

Alternatively, an arbitrary group of lines can be folded by selecting them to enter Visual mode and pressing zf. This allows you to preview the section you've selected before you fold it. The above example of folding the current code block could also be accomplished by first selecting the code block delimited by the curly braces (va}) and then creating the fold (zf). Putting this together gives va}zf.

Manual folds can also be created in Command mode :{range}fo[ld], e.g., the current line along with the following three lines (as in the example above) can be folded by running :,+3fo.

Use zd to delete the fold at the cursor (no text is deleted, just the fold markers); zD is used to recursively delete folds at the cursor.

The command zc will close a fold (if the cursor is in an open fold), and zo will open a fold (if the cursor is in a closed fold). It's easier to just use za which will toggle the current fold (close it if it was open, or open it if it was closed).

The commands zc (close), zo (open), and za (toggle) operate on one level of folding, at the cursor. The commands zC, zO and zA are similar, but operate on all folding levels (for example, the cursor line may be in an open fold, which is inside another open fold; typing zC would close all folds at the cursor).

The command zr reduces folding by opening one more level of folds throughout the whole buffer (the cursor position is not relevant). Use zR to open all folds.

The command zm gives more folding by closing one more level of folds throughout the whole buffer. Use zM to close all folds.

--]]
