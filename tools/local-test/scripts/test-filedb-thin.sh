JOB_NAME=ThinManagmentApplication
TEMP_DB_PATH=$DB_PATH/$JOB_NAME

$SCRIPTPATH/create-ib.sh /F$TEMP_DB_PATH $JOB_NAME

$SCRIPTPATH/run-tests.sh thin /F$TEMP_DB_PATH $JOB_NAME