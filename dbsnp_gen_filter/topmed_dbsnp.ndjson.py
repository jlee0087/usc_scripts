import json
import re
### IMPORTANT!! FOR SOME REASON THE SCRIPT MAKES EXTRA BRACES AT THE END OF THE FILE. FIND A WAY TO FIX THIS!!!

#SCRIPT FOR MAKING DBSNP DICTIONARY WITH TOPMED VALUES. 100K- KV-PAIR DICTIONARY PER LINE OF NDJSON
dbsnp_file = "/scratch1/jlee0087/resources/00-All.vcf"
json_path = "/scratch1/jlee0087/resources/testing.ndjson"
batch_size = 10000  ## cant read all at once cuz too big

## function to create key value pairs for every line
def process_line(line):
    reference = re.match(info_regex, line)
    if reference:
        key = reference[1] + ":" + reference[2] + ":" + reference[3]  # unique key generation
        alleles = reference[4].split(',')
        alleles.insert(0, reference[3])

        topmed_regex = "TOPMED=([^;\t\n]+)"

        ref_topmed = re.search(topmed_regex, line)
        if ref_topmed:
            topmed_values = ref_topmed[1].split(',')
            topmed_dict_line = {key: value for key, value in zip(alleles, topmed_values)}
            return key, topmed_dict_line

    return None, None


## apply onto batches
try:
    with open(dbsnp_file, 'rt') as file, open(json_path, "w") as f1:
        info_regex = '^(\S+)\s+(\S+)\s+\S+\s+(\S+)\s+(\S+)\s+\S+\s+\S+\s+(\S+)'
        dbsnp_dict = {}

        for line_count, line in enumerate(file):
            if line_count % batch_size == 0 and line_count > 0 :
                # accumulat data to the output file
                if not dbsnp_dict == {}:
                    inner_string = json.dumps(dbsnp_dict)
                    f1.write(inner_string +"\n")
                dbsnp_dict = {}
            if not line.startswith("#"):
                key, topmed_dict_line = process_line(line)
                if key:
                    dbsnp_dict[key] = topmed_dict_line
        #remaining data
        json_string = json.dumps(dbsnp_dict)
        f1.write(json_string+ "\n")


        

except EOFError:
    print("Error: Compressed file ended before the end-of-stream marker was reached.")
