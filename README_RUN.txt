CampusSync run guide

Database setup:
1. Open SQL Server Management Studio.
2. Open this file:
   C:\Users\Saksh\Desktop\CampusSync\database_schema.sql
3. Execute the full script.

Default login:
username: sakshi
password: 1234

You can also create a new account from the first screen.

Compile in VS Code terminal:
cd C:\Users\Saksh\Desktop\CampusSync
javac -cp ".;lib/*" -d . Main.java dao/*.java model/*.java service/*.java ui/*.java

Run:
java -cp ".;lib/*" Main

Run the ready jar:
java -cp "CampusSync.jar;lib/*" Main

If the first login feels slow, run database_schema.sql once in SSMS. The app also has a lightweight auto-check, but a prepared database opens faster.

Important:
The project uses Microsoft SQL Server through:
lib/mssql-jdbc-13.4.0.jre8.jar

If connection fails, edit:
dao\DBConnection.java

Runnable jar for college submission:
jar cfe CampusSync.jar Main Main.class dao/*.class model/*.class service/*.class ui/*.class

Run jar:
java -cp "CampusSync.jar;lib/*" Main
