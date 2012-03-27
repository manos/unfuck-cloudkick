#!/bin/sh
# hit the hidden "setnoit" (reapply check to endpoint) link for every open alert, assuming they are stuck because cloudkick--
#
# howitworks: reads the check id from the whatswrong page (from the "log" link), 
#  then hits the /setnoit/ URL instead of /history/.
#
# TODO: we could curl -d (POST) user/pass, and use the cookie given, instead of supplying a sessionid cookie every time.

sessionid="sessionid-value-from-a-browser-session"
user="my-account-name"

curl -L -H "Cookie: sessionid=${sessionid}" https://www.cloudkick.com/a/${user}/monitoring/whatswrong > /tmp/whatswrong

for i in `grep "href=\"/a/${user}/monitoring/check/history/.*\">log" /tmp/whatswrong |sed "s/.*\"\(.*\)\"\>.*/\1/g" |sed 's/history/setnoit/g'`; do curl -L -H "Cookie: sessionid=${sessionid}" https://www.cloudkick.com/$i; done


