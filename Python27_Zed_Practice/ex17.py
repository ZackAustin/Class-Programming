from sys import argv
from os.path import exists

script, from_file, to_file = argv

print "Copying from %s to %s. The input file is %d bytes long and the existance of the output file: %r" % (from_file, to_file, len(open(from_file).read()), exists(to_file)) + str(open(to_file, 'w').write(open(from_file).read())).strip('None')

# we could do these two on one line, how?
#in_file = open(from_file)
#indata = in_file.read()

#print"The input file is %d bytes long" % len(indata)

#print "Does the otput file exist? %r" % exists(to_file)
#print "Ready, hit RETURN to continue, CTRL-C to abort."
#raw_input()

#out_file = open(to_file, 'w')
#out_file.write(indata)

#open(to_file, 'w').write(open(from_file).read())

#print "Alright, all done."

#out_file.close()
#in_file.close()
