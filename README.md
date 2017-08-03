# Server-less eclass in AWS

Services

1. API Gateway
2. Lambda Functions
3. DynamoDB (~ in progress )


--------


Dependencies

- Node ( LTS ~ 6.x )
- Terraform
- Apex (~ in progress )


> LTS is initials for Long-term Support

> Node is a JavaScript interpreter for server side

> Terraform is a tool for building,
changing, and versioning infrastructure safely
and efficiently. Terraform can manage existing
and popular service providers as well as custom
in-house solutions.

> API Gateway is a fully managed service
that makes it easy for developers to create, publish,
maintain, monitor, and secure APIs at any scale

> Lambda functions is an amazon web service to
compute, that lets you run code without
provisioning or managing servers

> HCL (HashiCorp Configuration Language)
> Why??? review [here](https://github.com/hashicorp/hcl#why)

>[ECMAScript 6 compatibility table](https://kangax.github.io/compat-table/es6/#node)



________

para poder levantar esta api en tu cuenta de amazon son necesaria 4
variables que deben ser descritas en el archivo `variables.tf`

la lista de orden para prepar todo una vez descrita las variables
son:

- `./make gc`
- `terraform get`
- `terraform plan`
- `terraform apply`


si quieres destruir la arquitectura ya creada solo basta ejecutar
`terraform destroy`

en caso de realizar cambio y exponer en la api (cambios en js para este caso de uso)
debemos la siguiente lista de comandos:

- volver a ejecuta el garbage collector custom con `./make gc`
- ejecutar el comando `terraform refresh`
- aplicar los cambios resfrescados con `terraform apply`
