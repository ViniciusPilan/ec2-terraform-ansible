###########################################################
echo "TASK 01 - CREATING INFRA WITH TERRAFORM"
cd terraform && ./create_infra.sh
cd ..
echo

###########################################################
echo "TASK 02 - PREPARING THE ENVIRONMENT WITH ANSIBLE"
cd ansible
python3 script.py
./execute_ansible.sh
cd ..
echo

###########################################################
echo "TASK 03 - TESTING THE CREATED ENVIRONMENT"
cd tests
python3 script.py
cd ..
echo
