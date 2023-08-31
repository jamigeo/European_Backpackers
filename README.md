# The European Backpackers Project
This Readme.md file is intended to ensure that you get all the necessary information about this project, and the implementation of this architecture. If you notice an error during your visit, feel free to let us know in an issue.

## Please make sure you have met the following requirements:

### 1. Need to be installed:

- [Python](https://www.python.org/downloads/) required is [ version >=3 ] and pip package manager for Python [ >=20 ]

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) [ version >= 2 ] You need an AWS account, or at least have access to one.

- [Terraform](https://developer.hashicorp.com/terraform/downloads) [ version >= 5 ] The common notation for greater than or equal to in terraform is: "~> 5.0" [ check the access.tf file ]

### 2. Place your credentials in the following file:

- [Terraform](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/credentials.txt) [ The access data is usually stored in a separate file that ends with the file extension .tfvars ]

### 3. The knowlegde of the data structure underlying the project:

- [json](data_structure.json) The data structure on which this project is based must have a marshalled JSON format for import into the [DynamoDB](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/dynamodb.tf) database. otherwise the import from the [s3](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/s3.tf) bucket is not possible. Please take care of it.

