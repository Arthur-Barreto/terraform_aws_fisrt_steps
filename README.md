# Terraform AWS EC2 Instance with SSH Key

This Terraform project sets up an AWS EC2 instance with a custom SSH key pair. The private key is generated locally and saved to a `.pem` file.

## Prerequisites

Before you begin, make sure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://aws.amazon.com/cli/)

## Usage

1. Clone this repository:

2. Initialize your Terraform environment:

    ```bash
    terraform init
    ```

3. Create a Terraform execution plan:

    ```bash
    terraform plan
    ```

4. Apply the Terraform configuration to create the AWS resources:

    ```bash
    terraform apply
    ```

5. After the deployment is complete, the private key is saved to `ssh_key.pem`.

6. Connect to the EC2 instance using SSH:

    ```bash
    ssh -i ssh_key.pem ec2-user@<public-ip>
    ```

Remember to destroy the resources when they are no longer needed:

## Cleanup

To avoid incurring unnecessary charges, make sure to destroy the created resources when they are no longer needed:

```bash
terraform destroy
```

## Outputs

*private_key_file*: Path to the private key file (ssh_key.pem).

## Notes

Ensure that your AWS credentials are properly configured on your local machine.
Customize the variables in terraform.tfvars if needed.
