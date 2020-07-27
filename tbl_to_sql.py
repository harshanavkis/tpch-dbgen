import pandas as pd
import sys

def is_int_float(val):
	try:
		temp_int = int(val)
		return True
	except ValueError:
		pass
	try:
		temp_int = float(val)
		return True
	except ValueError:
		pass

	return False

def process_sqlite_insert_format(line, tbl_name):
	for i in range(len(line)):
		if is_int_float(line[i]):
			continue
		line[i] = "'{}'".format(line[i])

	line = ','.join(line)
	line = "INSERT INTO {} VALUES({});".format(tbl_name, line)

	return line

def main():
	schema       = sys.argv[1]
	data_tbl     = sys.argv[2:-1]
	scale_factor = sys.argv[-1]
	tbl_names    = [i.replace(".tbl", "") for i in data_tbl]
	tbl_names    = [i.replace("dbgen/", "") for i in tbl_names]

	out_file = open('build/TPC-H-{}.sql'.format(scale_factor), 'w')

	with open(schema, 'r') as f:
		while True:
			line = f.readline().strip()
			if not line:
				break;
			# print(line)
			out_file.write(line+'\n')

	for i in range(len(data_tbl)):
		f = open(data_tbl[i], 'r')

		while True:
			line = f.readline().strip()

			if not line:
				break

			line = line.split('|')[:-1]
			line = process_sqlite_insert_format(line, tbl_names[i])

			# print(line)
			# sys.exit(0)
			out_file.write(line+'\n')

	out_file.write("COMMIT;\n")

	print(tbl_names)

if __name__=="__main__":
	main()