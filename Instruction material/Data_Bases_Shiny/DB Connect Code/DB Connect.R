
#Download MS SQL Expresse here: https://www.microsoft.com/en-us/sql-server/sql-server-downloads?ranMID=46131&ranEAID=a1LgFw09t88&ranSiteID=a1LgFw09t88-VpNsLM_l9z3.e1zyrlHSqA&epi=a1LgFw09t88-VpNsLM_l9z3.e1zyrlHSqA&irgwc=1&OCID=AID2200057_aff_7806_1243925&tduid=%28ir__kfvdzuqz60kfqhjjk1igxhg6e32xt0xqdn6ndjdr00%29%287806%29%281243925%29%28a1LgFw09t88-VpNsLM_l9z3.e1zyrlHSqA%29%28%29&irclickid=_kfvdzuqz60kfqhjjk1igxhg6e32xt0xqdn6ndjdr00

# Download the MS SQL demo database AdventureWorks here: https://docs.microsoft.com/en-us/sql/samples/adventureworks-install-configure?ranMID=46131&ranEAID=a1LgFw09t88&ranSiteID=a1LgFw09t88-jRTEpHeK_dLKUflWatIWLg&epi=a1LgFw09t88-jRTEpHeK_dLKUflWatIWLg&irgwc=1&OCID=AID2200057_aff_7806_1243925&tduid=(ir__kfvdzuqz60kfqhjjk1igxhg6e32xt02xsn6ndjdr00)(7806)(1243925)(a1LgFw09t88-jRTEpHeK_dLKUflWatIWLg)()&irclickid=_kfvdzuqz60kfqhjjk1igxhg6e32xt02xsn6ndjdr00&view=sql-server-ver15&tabs=ssms
# You need same version as DB, 
# Restore Database file

# Some CRAN links
# https://cran.r-project.org/web/views/Databases.html
# https://cran.r-project.org/web/packages/DBI/index.html
# https://cran.r-project.org/web/packages/RSQLite/index.html

# install.packages("RSQLite")
# install.packages("DBI")




require(DBI)
require(RSQLite)


# For a real-world database, you will typically need to specify more connection parameters
# https://db.rstudio.com/getting-started/connect-to-database/

con <- dbConnect(odbc::odbc(), 
                  Driver = "SQL Server", 
                  Server = "localhost\\SQLEXPRESS", 
                  Database = "AdventureWorksLT2019", 
                  Trusted_Connection = "True")

# Show tables contained within the database
tables <- dbListTables(con)

# Pull data into R
customers <- dbGetQuery(conn=con, statement="SELECT * FROM SalesLT.Customer;")
invoices <- dbGetQuery(conn=con, statement=
                                                "SELECT 
                                                  [SalesOrderID]
                                                  ,[OrderDate]
                                                  ,[DueDate]
                                                  ,[ShipDate] 
                                                  ,[Status]
                                                  ,[CustomerID] 
                                                FROM 
                                                  SalesLT.SalesOrderHeader;"
)

View(customers)
View(invoices)

# join the two tables with dplyr
require(dplyr)
names(customers) # CustomerId is the primary key
names(invoices) # CustomerId is the foreign key
# Join the two tables
# https://dplyr.tidyverse.org/reference/join.html

cust_inv <- customers %>% inner_join(invoices, by = c("CustomerID" = "CustomerID"))

dim(customers)
dim(invoices)
dim(cust_inv) # each invoice is matched to exactly 1 customer

# Rather than using R, for large data sets the data can already
#   be joined directly within the database
cust_inv2 <- dbGetQuery(conn=con, 
                        statement="
                                DROP TABLE IF EXISTS SalesLT.NewTable;
                                
                                SELECT 
                                	cus.*
                                	,sal.[SalesOrderID]
                                	,sal.[OrderDate]
                                	,sal.[DueDate]
                                	,sal.[ShipDate]
                                	,sal.[Status]
                                INTO 
                                	SalesLT.NewTable
                                FROM
                                	SalesLT.Customer cus
                                Inner JOIN
                                	SalesLT.SalesOrderHeader sal
                                ON
                                	cus.CustomerId=sal.CustomerId
                                "
                      )

View(cust_inv2)
# same dimensions as with the dplyr approach
dim(cust_inv2)

# Terminate connection to the SQLite file
dbDisconnect(con)


# You can also use SQL-like syntax within R to prepare your data
#install.packages('sqldf')
require(sqldf)
View(invoices)
# Question 1: How many invoices total and how many customers total?
sqldf("select count(*) as CNT_INVOICES, 
              count(distinct CustomerID) AS CNT_CUSTOMERS
      from invoices")

# Question 2: How many invoices per customer in descending order?
orders_by_cust <- sqldf("select CustomerId,
              count(*) as COUNT_INV_PER_CUSSTOMER
              from invoices
              group by CustomerID
              order by COUNT_INV_PER_CUSSTOMER desc")

View(orders_by_cust)


# The Microsoft R Version
# https://mran.microsoft.com/download

# This version is particularly useful to be used together with the Microsoft SQL Server 
# Standard case: pull data from database into R --> easy, can be done with standard R also
# Real-time analytics case: run R directly in DB --> Microsoft R version can be run directly within the database, leveraging 
#     many of the database performance advantages --> https://docs.microsoft.com/en-us/sql/machine-learning/tutorials/quickstart-r-create-script?view=sql-server-ver15
