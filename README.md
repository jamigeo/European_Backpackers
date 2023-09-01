# The European Backpackers Project
This Readme.md file is intended to ensure that you get all the necessary information about this project, and the implementation of this architecture. If you notice an error during your visit, feel free to let us know in an issue.

## Please make sure you have met the following requirements:

### 1. What need to be installed?:

- [Python](https://www.python.org/downloads/) required is [ version >=3 ] and pip package manager for Python [ >=20 ]

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) [ version >= 2 ] You need an AWS account, or at least have access to one.

- [Terraform](https://developer.hashicorp.com/terraform/downloads) [ version >= 5 ] The common notation for "greater than or equal to" in terraform is: "~> 5.0"

### 2. Place your credentials in the following file:

- consider storing your AWS Credentials in ~/.aws/config using aws_access_key_id, aws_secret_access_key, and aws_session_token

- [ The [Terraform](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/credentials.txt) access data is usually stored in a separate file that ends with the file extension: .tfvars ] Please keep them safe, because big solutions are also big responsibilities[.](images/stand_alone.jpg)

### 3. The knowlegde of the data structure underlying the project:

- The [JSON](data_structure.json) data structure on which this project is based, must have a [marshalled](https://en.wikipedia.org/wiki/Marshalling_(computer_science)) JSON format for import into the [DynamoDB](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/dynamodb.tf) database. Otherwise the import from the [s3](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/s3.tf) bucket is not possible. Please take care of it.

### 4. File Structure

- Working Directory: Terraform-EB
- edit variables.tf

