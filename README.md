![imagem](.img/terraform-libvirt.jpg)
# terraform-libvirt
Repo para criação de laboratórios terraform usando KVM. A ideia deste repo é testar varios ambientes, por hora, há apenas 2 ambientes (almalinux e ubuntu). acompanhe o repo para mais atualizações.

- run `terraform init` para inicializar um workspace do terraform

- run `terraform validate` para validar a syntase

- run `terraform plan` para validar plano de execução

- run `terraform apply` para executar a criação dos recursos
  - digite `y` para sim
  - digite `n` para n

- run `terraform destroy` para destruir seu ambiente

### extra
o lab almalinux você deve baixar a iso primeiramente, para mais informações, leia o arquivo main.tf
