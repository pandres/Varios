#!/usr/bin/python
import sys
from datetime import datetime, timedelta

file = ".birthdays"

births = open(file, "r")
birth = births.readline()
while birth:
    data = birth.rpartition(" bd")[0]
    if data:
        who, when_string = data.split("=")
        today = datetime.today()
        try:
            when = datetime.strptime(when_string.strip(), "%d/%m/%y")
        except Exception, e:
            try:
                when = datetime.strptime(when_string.strip(), "%d/%m/%Y")
            except Exception, e:
                print "bang! " + str(e)
                birth = births.readline()
                continue

        try:
            diff = datetime(today.year, when.month, when.day) - datetime(today.year, today.month, today.day)
        except Exception, e:
            print "bang! " + str(e)
            birth = births.readline()
            continue

        if timedelta(0) <= diff < timedelta(31):
            print "%s cumple el %s" % (who, when_string,)

    birth = births.readline()

