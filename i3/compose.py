#!/usr/bin/env python3

import os
import argparse
import sys

#parser = argparse.ArgumentParser(description='compose files with <include file>')
#parser.add_argument('-o', action="store", dest="output")
#args = parser.parse_args()



folder = os.path.dirname(os.path.abspath(__file__))

input = os.path.join(folder, "compose-config")
output = os.path.join(folder, "config")

search = "<include "

# resulting config file (output)
print("writing to", output)
with open(output, "w") as config:

    # compose file (input)
    print("reading from", input)
    with open(input, "r") as compose:

        for line in compose:
                    
            # including file
            if line.startswith(search):
                include = line.strip()[len(search):-1]
                include = os.path.join(folder, include)
                print("including", include)
                with open(include, "r") as include_file:
                    config.write("# " + include + "\n")
                    for i_line in include_file:
                        config.write(i_line)
            # normal line            
            else:
                config.write(line)
