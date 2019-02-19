# https://stackoverflow.com/a/39280008/358804
if (!require(RJDBC)) {
  install.packages(c("RJDBC"), repos='http://cran.us.r-project.org')
  require(RJDBC)
}

library(rJava)

# https://mapr.com/support/s/article/How-to-connect-R-to-Hiveserver2-using-hive-jdbc?language=en_US

cp=c(
  "../../apache-hive-3.1.1-bin/jdbc/hive-jdbc-3.1.1-standalone.jar",
  "../../hadoop-3.2.0/share/hadoop/common/hadoop-common-3.2.0.jar"
)
.jinit(classpath=cp)
drv <- JDBC(
  "org.apache.hive.jdbc.HiveDriver",
  "../../apache-hive-3.1.1-bin/lib/hive-jdbc-3.1.1.jar",
  identifier.quote="`"
)

conn <- dbConnect(drv, "jdbc:hive2://localhost:10000/;") #, "<user>", "<password>")
