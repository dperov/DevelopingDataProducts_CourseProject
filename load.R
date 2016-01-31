library(httr)
library(data.table)

github_auth <- readRDS(".github_auth.rds");
# github_auth <- authenticate("gtihubuser", "githubpassword") 


# R programming
#https://github.com/rdpeng/ProgrammingAssignment2

# reproducible research
#https://github.com/rdpeng/RepData_PeerAssessment1

# explanatory data analisys
#https://github.com/rdpeng/ExData_Plotting1
# https://api.github.com/repos/rdpeng/ProgrammingAssignment2/forks

load_fork_info <- function(fork_base_url, fork_dir)
{
  #fork_base_url <- "https://api.github.com/repositories/14204342/forks"
  fork_page <- 0
  
  fork_url <- fork_base_url
  
  while (1) {
    
    file_name <- sprintf("%s/%d", fork_dir, fork_page)
    
    if (!file.exists(file_name)) {
      req <- GET(fork_url, github_auth)
      status <- status_code(req);
      if (status != 200) {
        print(sprintf("Get status %d, url: %s", status, fork_url))
        break;
      }
      content <- content(req)
      if (length(content) == 0) {
        print(sprintf("Empty contetn, url: %s", fork_url))
        break;
  
      }
      save(content, file = file_name)
      print(sprintf("done %s", fork_url))
    }
    if (fork_page == 0) {
      fork_page <- 2
    } else {
      fork_page <- fork_page + 1
    }
    fork_url <- sprintf("%s?page=%d", fork_base_url, fork_page)
    
  }
}

process_content <- function(content, table)
{
  owner_ids <- vapply(content, function(x) { x$owner$id }, FUN.VALUE = numeric(1) )
  created_at <- vapply(content, function(x) { x$created_at }, FUN.VALUE = character(1) )
  
  rbind(table, data.table(owner_id = owner_ids, created_at = created_at))

}

process_fork_info <- function(path, table = data.table())
{
  fork_page <- 0
  while (1) {
    file_name <- sprintf("%s/%d", path, fork_page)
    if (!file.exists(file_name)) {
      print(sprintf("No file: %s", file_name))
      
      break;
    }
    content <- get(load(file_name));
    table <- process_content(content, table);
    print(sprintf("Loaded: %s %d", file_name, length(content)))
    if (length(content) == 0) {
      print(sprintf("Empty file: %s", file_name))
      break;
    }
    if (fork_page == 0) {
      fork_page <- 2
    } else {
      fork_page <- fork_page + 1
    }
  }
  table;
}

# https://api.github.com/repositories/14204342/forks?page=2
#fork_url <- "https://api.github.com/repositories/14204342/forks"

#req <- GET("https://api.github.com/rate_limit", authenticate("dperov", "github00"))
#content(req)

#load_fork_info()

#table <- process_fork_info();
#write.table(table, "forkdata.table")

#url2 <- "https://api.github.com/repos/rdpeng/ProgrammingAssignment2/forks"
#load_fork_info(url2, "fork2")

#table <- process_fork_info("fork2")
#write.table(table, "forkdata_rprogr.table")

#url_ex <- "https://api.github.com/repos/rdpeng/ExData_Plotting1/forks"
#load_fork_info(url_ex, "fork_ex")
#table <- process_fork_info("fork_ex")
#write.table(table, "forkdata_ex.table")

url_repl <- "https://api.github.com/repos/rdpeng/RepData_PeerAssessment1/forks"
load_fork_info(url_repl, "fork_repl")
table <- process_fork_info("fork_repl")
write.table(table, "forkdata_repl.table")

