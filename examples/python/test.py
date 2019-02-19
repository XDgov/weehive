from pyhive import hive

cursor = hive.connect("localhost").cursor()
cursor.execute("CREATE TABLE IF NOT EXISTS people (name string)")
cursor.execute("INSERT INTO people (name) VALUES ('Aidan')")
cursor.execute("SELECT * FROM people LIMIT 10")
print(cursor.fetchone())

print("Success!")
