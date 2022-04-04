# Construct the URI from the .env
DB_HOST=ec2-3-230-238-86.compute-1.amazonaws.com
DB_NAME=dfg9e64pd8ml2f
DB_USER=ddjkguwhkprpvz
DB_PORT=5432
DB_PASSWORD=a57ae2f1a05854bd4be7aeef7a00efe69213ae7d135ee8c419a48340a50929a8

while IFS= read -r line
do
  if [[ $line == DB_HOST* ]]
  then
    DB_HOST=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_NAME* ]]
  then
    DB_NAME=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_USER* ]]
  then
    DB_USER=$(cut -d "=" -f2- <<< $line | tr -d \' )
  elif [[ $line == DB_PORT* ]]
  then
    DB_PORT=$(cut -d "=" -f2- <<< $line | tr -d \')
  elif [[ $line == DB_PASSWORD* ]]
  then
    DB_PASSWORD=$(cut -d "=" -f2- <<< $line | tr -d \')
  fi
done < ".env"

URI="postgres://$DB_USER:$DB_PASSWORD@$DB_HOST:$DB_PORT/$DB_NAME"

# Run the scripts to insert data.
psql ${URI} -f sql/DropTablesTriggers.sql
psql ${URI} -f sql/DeleteTableContents.sql
psql ${URI} -f sql/Schema.sql
psql ${URI} -f sql/Users.sql
psql ${URI} -f sql/Member.sql
psql ${URI} -f sql/Administrator.sql
psql ${URI} -f sql/Category.sql
psql ${URI} -f sql/Activity.sql
psql ${URI} -f sql/Joins.sql
psql ${URI} -f sql/RandomComments.sql
psql ${URI} -f sql/RandomReports.sql
psql ${URI} -f sql/Review.sql
psql ${URI} -f sql/Report.sql
psql ${URI} -f sql/ProceduresTriggers.sql



