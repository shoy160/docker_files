#/bin/bash
start_date=`date -d "+0 day $1" +%Y%m%d`
end_date=`date -d "+0 day $2" +%Y%m%d`
while [[ $start_date -le $end_date ]]
do
  date=$start_date
  echo "date $date \n"
  start_date=`date -d "+1 day $date" +%Y%m%d`
done

# dates.sh 20210701 20210801