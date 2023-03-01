echo
echo "GENERATING TERRAFORM PLAN"
terraform plan

echo
echo "CONFIRM? [yes/no]"
read confirm

if [ ${confirm} = "yes" ] ;
then
    echo
    echo "APPLYING CODE TO CREATE THE INFRA"
    terraform apply -auto-approve

    echo
    echo "SAVING THE OUTPUT VALUES"
    terraform output -json > outputs.json
    ls outputs.json

    echo
    echo "CREATING HOST FILE (INVENTORY)"
    python3 ../ansible/script.py
else
    echo "Exiting..."
fi
