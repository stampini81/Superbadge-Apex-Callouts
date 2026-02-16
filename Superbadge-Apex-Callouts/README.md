
# Superbadge Apex Callouts - Projeto Completo

> Projeto completo para o Superbadge Apex Callouts do Trailhead, com toda a configuração, código, testes e documentação para facilitar a validação e o reuso.

## Sumário
- [Visão Geral](#visão-geral)
- [Pré-requisitos](#pré-requisitos)
- [Configuração do Ambiente](#configuração-do-ambiente)
- [Geração e Importação do WSDL](#geração-e-importação-do-wsdl)
- [Configuração do Named Credential e External Credential](#configuração-do-named-credential-e-external-credential)
- [Execução e Testes](#execução-e-testes)
- [Licença](#licença)
- [Autor](#autor)

---

## Visão Geral
Este projeto implementa todas as etapas do Superbadge Apex Callouts, incluindo:
- Integração SOAP e REST com Named Credentials
- Testes automatizados com mocks
- Batch Apex para envio de dados
- Documentação detalhada para configuração e deploy

## Pré-requisitos
- Salesforce CLI (sfdx)
- VS Code com Salesforce Extensions
- Acesso a uma org Developer Edition ou Trailhead Playground

## Configuração do Ambiente
1. **Clone o repositório:**
	```sh
	git clone https://github.com/stampini81/Superbadge-Apex-Callouts.git
	cd Superbadge-Apex-Callouts
	```
2. **Crie/Conecte sua org:**
	```sh
	sfdx force:auth:web:login -a superbadge-org
	```
3. **Crie um scratch org (opcional):**
	```sh
	sfdx force:org:create -f config/project-scratch-def.json -a superbadge-scratch
	```
4. **Deploy do código:**
	```sh
	sfdx force:source:deploy -p force-app
	```

## Geração e Importação do WSDL
1. Obtenha o arquivo WSDL do serviço SOAP (exemplo: `IntegrationSB__billingInvoice.wsdl`).
2. No Setup da org Salesforce, pesquise por "Apex Classes" e clique em "Generate from WSDL".
3. Faça upload do WSDL e gere a classe Apex (ex: `BillingServiceProxy`).
4. Ajuste o código conforme necessário para o superbadge (veja exemplos nas classes do projeto).

## Configuração do Named Credential e External Credential
1. **Crie um Named Credential:**
	- Nome: `BillingServiceCredential` (ou conforme o WSDL/Desafio)
	- URL: endpoint do serviço (ex: `callout:IntegrationSB__BillingInvoiceService`)
	- Tipo de autenticação: **Named Principal**
	- Marque as opções "Allow Merge Fields in HTTP Body" e "Allow Merge Fields in HTTP Header".
2. **Crie um External Credential:**
	- Nome: igual ao usado no merge field (ex: `BillingServiceCredential` ou `IntegrationSB__BillingServiceCredential`)
	- Adicione um Principal com username e password (valores fictícios, mas não deixe em branco).
	- Atribua o External Credential a um Permission Set e associe ao seu usuário.
3. **Adicione o endpoint em Remote Site Settings** (caso necessário para testes):
	- Exemplo: `http://sb-integration-bs.herokuapp.com`

## Execução e Testes
1. Execute os testes Apex pelo VS Code ou Setup da org.
2. Rode os batchs e triggers conforme o enunciado do superbadge.
3. Use os logs para validar as respostas dos callouts e o funcionamento dos mocks.

## Licença

Este projeto está licenciado sob a Licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## Autor

Leandro da Silva Stampini  
[LinkedIn](https://www.linkedin.com/in/leandro-da-silva-stampini/)
