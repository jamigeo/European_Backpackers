# The European Backpackers Project
This Readme.md file is intended to ensure that you get all the necessary information about this project, and the implementation of this architecture. If you notice an error during your visit, feel free to let us know in an issue.

## Please make sure you have met the following requirements:

### 1. What need to be installed?:

- [Python](https://www.python.org/downloads/) required is [ version >=3 ] and pip package manager for Python [ >=20 ]

    - run: ```python --version``` ...on your comandline to see if the version meets the requirement.

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) [ version >= 2 ] You need an AWS account, or at least have access to one.

    - run: `aws sts get-caller-identity` ...on your comandline to get the S-ecurity T-oken S-ervice identity informations...

- [Terraform](https://developer.hashicorp.com/terraform/downloads) [ version >= 5 ] The common notation for "greater than or equal to" in terraform is: "~> 5.0"

    - run: `terraform version` ...and:
    - run: `terraform init` ...on your commandline to validate the version, and initialize [ in the right folder ] the terraform project. 

### 2. Place your credentials in the following file:

- consider storing your AWS Credentials in `~/.aws/config`[^1] using `aws_access_key_id`, `aws_secret_access_key`, and `aws_session_token`

- [ The [Terraform](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/credentials.txt) access data is usually stored in a separate file that ends with the file extension: `.tfvars` ] Please keep them safe, because big solutions are also big responsibilities[.](images/stand_alone.jpg)

### 3. The knowlegde of the data structure underlying the project:

- The [JSON](data_structure.json) data structure on which this project is based, must have a [marshalled](https://en.wikipedia.org/wiki/Marshalling_(computer_science)) JSON format for import into the [DynamoDB](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/dynamodb.tf) database. Otherwise the import from the [s3](https://github.com/jamigeo/European_Backpackers/tree/main/Terraform%20templates/s3.tf) bucket is not possible. Please take care of it.

| Table   | Field            | Type    | Maps   | Types   |
| ------- | ---------------- | ------- | ------ | ------- |
| cities  |                  |         |        |         |
|         | name             | string  |        |         |
|         | country          | string  |        |         |
|         | population       | integer |        |         |
|         | average age      | float   |        |         |
|         | area             | float   |        |         |
|         | founding year    | date    |        |         |
|         | population density | integer |      |         |
|         | districts        | integer |        |         |
|         | transportation   | Map (M) |        |         |
|         |                  |         |        |         |
|         | subway connections | Map (M) |      |         |
|         |                  |         |        |         |
|         |                  | north   | integer |     |
|         |                  | south   | integer |     |
|         |                  | east    | integer |     |
|         |                  | west    | integer |     |
|         | train connections | Map (M) |      |         |
|         |                  |         |        |         |
|         |                  | north   | integer |     |
|         |                  | south   | integer |     |
|         |                  | east    | integer |     |
|         |                  | west    | integer |     |
|         | highway connections | Map (M) |    |         |
|         |                  |         |        |         |
|         |                  | north   | integer |     |
|         |                  | south   | integer |     |
|         |                  | east    | integer |     |
|         |                  | west    | integer |     |
|         | airports         | List (L) |       |         |
|         |                  | [0]     | string  |         |
|         | geography        | Map (M) |        |         |
|         |                  |         |        |         |
|         |                  | latitude | float  |         |
|         |                  | longitude | float  |        |
|         |                  | nearest city distance km | Map (M) | |
|         |                  |         | value   | float  |
|         |                  |         | unit    | string  |
|         |                  | rivers  | List (L) |        |
|         |                  |         | [0]     | string  |
|         |                  | elevation meters | integer |  |
|         |                  | max daily temperature celsius | double | |
|         |                  | min daily temperature celsius | double | |
|         |                  | precipitation | string  |        |
|         |                  | rainy days | integer |        |
|         |                  | monthly sunshine hours | integer | |
|         | coat of arms image path | string  |        |         |


#### 3.1 AWS Infrastructure we are creating

* API Gateway (not yet)

* 2 Lambda functions (GET and POST City)

* DynamoDB Table
    > Name : 'european-cities'
    > Key : 'Name'


### 4. File Structure

- Working Directory: Terraform-EB
- edit variables.tf

[^1]: Wichtig ist es zu beachten, dass diese Fußnote auch irgendwann einen Sinn bekommt...



