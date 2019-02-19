source("setup.R")

conn <- getHiveConn()

db <- dbGetQuery(conn, "show databases")
print(db)

print("Success!")
