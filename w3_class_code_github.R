

# check current R version 
R.version.string

# instlal package if needed. need to do this only once 
# install.packages("usethis") 
library(usethis)

use_git_config(user.name = "",
               user.email = "")

# takes us to GitHub to create a unique token 
# this will create a connection between RStudio and GitHub
usethis::create_github_token()

# paste in the token 
gitcreds::gitcreds_set()
