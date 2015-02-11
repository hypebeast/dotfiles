#!/usr/bin/env python

import sys
import datetime
from prettytable import PrettyTable

def main():
    jrnl_output = sys.argv[1]

    entries = jrnl_output.split('\n')
    firstLine = ""
    x = PrettyTable(["Day", "Date", "Hours"])
    for idx, entry in enumerate(entries):
        # Save the first line
        if not idx % 2:
            firstLine = entry
            continue

        partsFirst = firstLine.split(" ")
        partsSecond = entry.split(" ")
        year, month, day = (int(x) for x in partsFirst[0].split("-"))
        ans = datetime.date(year, month, day)
        x.addRow([ans.strftime('%A'), partsFirst[0], partsSecond[1]])

    print x

if __name__ == '__main__':
    main()
