#
# Example for imapsync massive migration on Unix systems.
 
# This loop will also create a log file called LOG/log_${u2}_$NOW.txt for each account transfer
# where u2 is just a variable containing the user2 account name, and NOW is the current date_time
 
mkdir -p LOG
 
{ while IFS=';' read  u1 p1 u2 p2
    do 
         { echo "$u1" | egrep "^#" ; } > /dev/null && continue
         NOW=`date +%Y_%m_%d_%H_%M_%S` 
         echo syncing to user "$u2"
         imapsync --host1 0.0.0.0 --user1 "$u1" --password1 "$p1" \
                  --host2 0.0.0.0 --user2 "$u2" --password2 "$p2" \
                  > LOG/log_${u2}_$NOW.txt 2>&1
    done 
} < emails.txt