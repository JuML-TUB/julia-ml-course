<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Adrian Hill"
mintoclevel = 2
maxtoclevel = 3

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = false
prepath = "julia-ml-course"
website_title = "Julia for Machine Learning"
website_descr = "Julia for Machine Learning course at TU Berlin"
website_url   = "https://juml-tub.github.io/julia-ml-course/"
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
