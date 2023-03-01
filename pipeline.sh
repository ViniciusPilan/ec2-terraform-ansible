###########################################################
echo "TASK 01 - CREATING INFRA WITH TERRAFORM"
cd terraform && sudo bash create_infra.sh
cd ..
echo

###########################################################
echo "TASK 02 - PREPARING THE ENVIRONMENT WITH ANSIBLE"
cd ansible
python3 script.py
sudo bash execute_ansible.sh
cd ..
echo

###########################################################
echo "TASK 03 - TESTING THE CREATED ENVIRONMENT"
cd tests
python3 script.py
cd ..
echo

