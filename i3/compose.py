#!/usr/bin/env python3

import os
import argparse
import sys

parser = argparse.ArgumentParser(
    description='i3 config preprocessor. Include files with <include file>.\nEvaluate partially with <if FLAG><else><endif>.\nSet Flags as arguments or with <set FLAG true|false>.')

parser.add_argument("base", help="the base file for composing the config")
parser.add_argument("-o", "--out", default="compose-config",
                    help="name of output file. Default: 'compose-config'.")
parser.add_argument("--flags", nargs='+',
                    help="flags to be set 'true' during evaluation.")
args = parser.parse_args()

# flags
flags = {"true": True}
for flag in args.flags:
    flags[flag] = True
flags["false"] = False

# parser commands
strInclude = "<include "
strIf = "<if "
strElse = "<else>"
strEndIf = "<endif>"
strSet = "<set "

# files
# folder = os.path.dirname(os.path.abspath(__file__))
folder = os.path.dirname(os.path.abspath(args.base))

baseFile = os.path.basename(args.base) #os.path.join(folder, args.base)
output = os.path.join(folder, args.out)


# resulting config file (output)
print("writing to", output)
with open(output, "w") as config:

    # startig with base file
    readQueue = ["<include "+baseFile+">"]
    ifStack = []
    ifVal = True  # determines if current block is evaluated

    for index, line in enumerate(readQueue):

        # endif
        if line.startswith(strEndIf):
            if ifStack.count == 0:
                print("endif without if")
                exit(-1)
            else:
                (flag, ifVal) = ifStack.pop()
            continue

        # if block
        elif line.startswith(strIf):
            flag = line.strip()[len(strIf):-1]

            flagValue = False
            if flag in flags:
                flagValue = flags[flag]

            # push flag and current ifVal
            ifStack.append((flag, ifVal))

            # if in live block evaluate if
            if ifVal:
                # dead or live block?
                ifVal = flagValue

            continue

        # else block
        elif line.startswith(strElse):
            if ifStack.count == 0:
                print("else without if")
                exit(-1)
            else:
                (flag, peekIfVal) = ifStack[-1]
                # if in live block then evaluate else
                if peekIfVal:
                    ifVal = not ifVal
            continue

        # dead code
        if not ifVal:
            continue

        # set flag
        if line.startswith(strSet):
            setStatement = line.strip()[len(strSet):-1]
            setStatement = setStatement.split(" ")
            if not (setStatement.count == 2 and ["true", "false"].index(setStatement[1]) >= 0):
                print("invalid set", setStatement)
                exit(-1)
            else:
                flags[setStatement[0]] = setStatement[1]

        # include file
        elif line.startswith(strInclude):
            include = line.strip()[len(strInclude):-1]
            includePath = os.path.join(folder, include)
            print("including", include)

            with open(includePath, "r") as include_file:
                readQueue.insert(index+1, "# " + include + "\n")
                readQueue[index+2:index+2]=include_file.readlines()

        # normal line
        else:
            config.write(line)
