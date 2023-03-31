![imagem](.img/capa.jpg)

#### Terraform
**Automatize a infraestrutura em qualquer nuvem com o Terraform**, o Terraform Cloud permite automação de infraestrutura para provisionamento, conformidade e gerenciamento de qualquer nuvem, datacenter e serviço. 
Mais sobre, visite https://www.terraform.io/

#### Libvirt
um kit de ferramentas para gerenciar plataformas de virtualização, é licenciado sob licenças de código aberto, suporta KVM, Hypervisor.framework, QEMU, Xen, Virtuozzo, VMWare ESX, LXC, BHyve e mais. Disponível para Linux, FreeBSD, Windows e Mac OS. visite https://libvirt.org/

## Este repositório
Repo para criação de laboratórios terraform usando KVM. A ideia deste repo é testar varios ambientes, por hora, há apenas 2 ambientes (almalinux e ubuntu). acompanhe o repo para mais atualizações.

- run `terraform init` para inicializar um workspace do terraform

- run `terraform validate` para validar a syntase

- run `terraform plan` para validar plano de execução

- run `terraform apply` para executar a criação dos recursos
  - digite `y` para sim
  - digite `n` para n

- run `terraform destroy` para destruir seu ambiente

#### extra
o lab almalinux você deve baixar a iso primeiramente, para mais informações, leia o arquivo main.tf
