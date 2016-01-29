#install.packages("httr")
#install.packages("httpuv")
library(httr)
library(httpuv)

req <- GET("https://api.github.com/users/caspyin")
content(req)

req <- GET("https://api.github.com/repos/jtleek/datasharing/forks")
content(req)

strsplit(headers(req)$link,"(<|>|;| |,)+")

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
#Client ID
key <- "69430fd3f0d575c02a10"
#Client Secret
secret <- "fe78caf3ae69788896b37d68f8dc6ad6b14a67f"


myapp <- oauth_app("github",
                   key = key,
                   secret = secret)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

# OR:
req <- with_config(gtoken, GET("https://api.github.com/rate_limit"))
stop_for_status(req)
content(req)

