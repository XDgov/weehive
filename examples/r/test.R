source("setup.R")

db <- dbGetQuery(conn, "show databases")
print(db)

print("Success!")
