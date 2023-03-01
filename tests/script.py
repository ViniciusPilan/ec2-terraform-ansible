import json
import os


## Loading the outputs json file
json_file = open("../terraform/outputs.json", "r")
json_dict = json.load(json_file)
json_file.close()

host_name = json_dict["instance_name"]["value"]
host_ipv4 = json_dict["instance_public_ipv4"]["value"]


## Generating the simple test file
test_file = open("connection_simple_test.sh", "w")
test_file.write(f"curl http://{host_ipv4}")
test_file.close()


## Executing the created test
os.system("bash connection_simple_test.sh")