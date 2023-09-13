import re
import json
print('initializing')
vcf_file = "/scratch1/jlee0087/projects/case_study/dbsnp.high_mod.100qual.vcf"
topmed_ndjson = "/scratch1/jlee0087/resources/topmed.dbsnp.ndjson"
output_name= "/scratch1/jlee0087/projects/case_study/topmed.001.dbsnp.high_mod.100qual.vcf"
alternate_AF_cutoff = float(0.001)
print('starting')

with open(vcf_file, 'r') as file, open(topmed_ndjson, 'r') as ndjson, open(output_name, "w") as output_file:
    print(f"Opened {vcf_file} for reading.")
    print(f"Opened {topmed_ndjson} for reading.")
    print(f"Opened {output_name} for writing.")
    info_regex = '^(\S+)\s+(\S+)\s+\S+\s+(\S+)\s+(\S+)\s+\S+\s+\S+\s+(\S+)'
    topmed_regex = "TOPMED=([^;\t\n]+)"
    resulting_dicts = []
    ## loading all the dictionaries into resulting_dicts. the dictionary size is like 35GB so should be okay...
    for dic in ndjson:
        try:
            obj = json.loads(dic.strip())
            resulting_dicts.append(obj)
        except json.JSONDecodeError as e:
            print(f"Error parsing JSON on line: {dic}")
    ## searching each variant in the list of dictionaries        
    for line in file:
        if line.startswith("#"):
            output_file.write(line)
            print('header written')
        elif re.match(info_regex, line) and re.search(topmed_regex, line):
            variant = re.match(info_regex, line)
            variant_key = variant[1]+":"+ variant[2]+":"+ variant[3]  # unique key

            found_dict = None
            for dictionary in resulting_dicts:
                ## check variant key in each dictionary. if it exists along with the allele reported, then check the AF and filter below AF cutoff
                if variant_key in dictionary and variant[4] in dictionary[variant_key]:
                            af = dictionary[variant_key][variant[4]]
                            if not af == "." :
                                variant_AF = float(af)
                                if variant_AF <= alternate_AF_cutoff:
                                    output_file.write(line)  
                                    print('variant recorded')

