## Dominando o Python Para Ciência de Dados

<br>
<p align = "justify">O módulo Dominando o Python Para Ciência de Dados integra o bootcamp Potência Tech powered by iFood, disponibilizado através da plataforma Digital Innovation One (DIO).
<p align = "justify"> Para este módulo são propostos cinco desafios de código e dois desafios de projeto. A seguir estão descritos os detalhes de cada um deles:
<br><br> 

### Desafios de Código
Os desafios de código possuem definições que devem ser seguidas para que não sejam retornados erros, desta forma, é preciso criar os algoritmos exatamente como solicitado no enunciado.

#### :heavy_check_mark: 1. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafioCodigo1_tempo_entrega.py">Tempo Estimado de Entrega</a>
<p align = "justify"><b>Desafio:</b> Imagine que você está criando um aplicativo de entrega de comida e precisa informar ao usuário o tempo estimado de entrega de um restaurante. A mensagem deve conter o nome do restaurante e o tempo estimado de entrega em minutos.
<p align = "justify"><b>Entrada:</b> A entrada deverá receber os valores: nomeRestaurante (string) - o nome do restaurante desejado; tempoEstimadoEntrega (number) - o tempo estimado de entrega em minutos.
<p align = "justify"><b>Saída:</b> Deverá retornar uma mensagem (string) informando ao usuário o tempo estimado de entrega do restaurante. Por exemplo, para o restaurante Bar do Zinho com o tempo estimado de entrega sendo 20, imprima: "O restaurante Bar do Zinho entrega em 20 minutos".

#### :heavy_check_mark: 2. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafioCodigo2_preco_final.py">Calcular o Preço Final de um Pedido</a>
<p align = "justify"><b>Desafio:</b> Você está criando um aplicativo de entrega de comida e precisa calcular o preço final do pedido do usuário. O usuário escolheu alguns itens do cardápio e é preciso calcular o preço total do pedido.
<p align = "justify"><b>Entrada:</b> A entrada deve receber os valores: valorHamburguer - o valor unitário de um hambúrguer; quantidadeHamburguer - a quantidade de hambúrgueres que o usuário deseja; valorBebida - o valor unitário de uma bebida; quantidadeBebida - a quantidade de bebidas que o usuário deseja; valorPago - o valor pago pelo usuário.
<p align = "justify"><b>Saída:</b> A saída deve retornar um texto informando o valor total do pedido e a quantidade de troco que será necessário. Por exemplo, se tivermos os seguintes valores de entrada: 
  
```
  valorHamburguer = 10.00;
  quantidadeHamburguer = 2;
  valorBebida = 5.00;
  quantidadeBebida = 1;
  valorPago = 30.00;
```
De acordo com esses valores de entrada, o cálculo do preço final do pedido ficaria assim:
```
  Valor total dos hambúrgueres: 10.00 * 2 = 20.00
  Valor total da bebida: 5.00 * 1 = 5.00
  Preço total do pedido: 20.00 + 5.00 = 25.00
  Troco necessário: 30.00 - 25.00 = 5.00
```
Como o usuário pagou R$ 30.00 e o preço total do pedido ficou em R$ 25.00, o troco necessário é de R$ 5.00. Portanto, a saída esperada para esse exemplo seria:
```
  O preço final do pedido é R$ 25.00. Seu troco é R$ 5.00.
```
#### :heavy_check_mark: 3. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafioCodigo3_sobremesa_especial.py">Ganhe uma Sobremesa Especial!</a>
<p align = "justify"><b>Desafio:</b> Crie um programa que informe ao usuário se ele pode receber um brinde especial de acordo com o valor total do pedido. Se o valor total do pedido for maior ou igual a R$ 50.00, o usuário receberá uma sobremesa grátis. Caso contrário, o usuário não receberá nenhum brinde. 
<p align = "justify"><b>Entrada:</b> A entrada deverá receber o valor total do pedido em uma variável numérica: valorPedido - o valor do pedido.
<p align = "justify"><b>Saída:</b> Deverá retornar uma mensagem (string) que informa se o usuário ganhou uma sobremesa ou não:
 
  - Se valorPedido >= 50, a mensagem deve ser: Parabens, você ganhou uma sobremesa gratis!
  - Caso contrário, a mensagem deve ser: Que pena, você nao ganhou nenhum brinde especial.
 

#### :heavy_check_mark: 4. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafioCodigo4_gerenciamento_pedidos.py">Gerenciamento de Pedidos de Comida Online</a>
<p align = "justify"><b>Desafio:</b> Você foi contratado para desenvolver um sistema que armazena informações dos pedidos de comida online realizados por um cliente. O sistema deve permitir ao cliente inserir novos pedidos, escolher um cupom de desconto (10% ou 20%) e exibir o valor total de todos os pedidos realizados até o momento, com o desconto aplicado.
<p align = "justify"><b>Entrada:</b> A entrada é composta por: 1. Uma linha com um número inteiro n representando a quantidade de pedidos que o usuário deseja inserir; 2. n linhas, cada uma contendo uma string com o nome do pedido e um valor em ponto flutuante separados por espaço. O nome do pedido não contém espaços em branco; 3. Uma linha contendo o cupom de desconto escolhido (10% ou 20%).
<p align = "justify"><b>Saída:</b> O programa deve exibir uma única linha contendo o valor total de todos os pedidos com o desconto aplicado, no seguinte formato: Valor total: XX.YY, onde "XX.YY" é a soma de todos os pedidos com desconto em formato de duas casas decimais após a vírgula.

#### :heavy_check_mark: 5. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafioCodigo5_pedidos_veganos.py">Identificando Pedidos Veganos</a>
<p align = "justify"><b>Desafio:</b> O objetivo deste programa é ajudar a equipe do Restaurante Veggieworld a identificar rapidamente os pedidos veganos e não veganos e informar as calorias de cada prato definido pelo cliente. O programa deve solicitar ao usuário o número de pedidos que serão feitos e, em seguida, pedir informações sobre cada pedido, incluindo se o prato é vegano ou não (usando as opções "s" para sim e "n" para não) e a quantidade de calorias. Ao final, o programa deve exibir uma lista de todos os pedidos com suas informações correspondentes.
<p align = "justify"><b>Entrada:</b> Um inteiro n, que representa o número de pedidos que o usuário deseja fazer. Para cada pedido, o usuário deve inserir:
  
  - O nome do prato;
  - A quantidade de calorias do prato;
  - Se o prato é vegano ou não (usando as opções "s" para sim e "n" para não).

<p align = "justify"><b>Saída:</b> O programa deve exibir uma lista de todos os pedidos com suas informações correspondentes, incluindo o nome do prato, se é vegano ou não, e a quantidade de calorias, no seguinte formato: Pedido X: NOME_DO_PRATO (EH_VEGANO?) - YYY calorias, onde "X" é o número do pedido, "NOME_DO_PRATO" é o nome do prato, "EH_VEGANO?" indica se o prato é vegano (escrever "Vegano" ou "Nao-vegano"), e "YYY" é a quantidade de calorias do prato.
<br><br>
  
### Desafios de Projeto
#### :heavy_check_mark: 1. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafio_sistema_bancario_v1.py">Criando um Sistema Bancário com Python</a>
<p align = "justify"> <b>Descrição:</b> Neste projeto, você terá a oportunidade de criar um Sistema Bancário em Python. O objetivo é implementar três operações essenciais: depósito, saque e extrato. O sistema será desenvolvido para um banco que busca monetizar suas operações. Durante o desafio, você terá a chance de aplicar seus conhecimentos em programação Python e criar um sistema funcional que simule as operações bancárias. Prepare-se para aprimorar suas habilidades e demonstrar sua capacidade de desenvolver soluções práticas e eficientes.
<br><br>
  
#### :heavy_check_mark: 2. <a href = "https://github.com/lilandracunha/dio-bootcamp-ifood/blob/main/python/desafio_sistema_bancario_v2.py">Otimizando o Sistema Bancário com Funções Python</a>
<p align = "justify"> <b>Descrição:</b> Neste desafio, você terá a oportunidade de otimizar o Sistema Bancário previamente desenvolvido com o uso de funções Python. O objetivo é aprimorar a estrutura e a eficiência do sistema, implementando as operações de depósito, saque e extrato em funções específicas. Você terá a chance de refatorar o código existente, dividindo-o em funções reutilizáveis, facilitando a manutenção e o entendimento do sistema como um todo. Prepare-se para aplicar conceitos avançados de programação e demonstrar sua habilidade em criar soluções mais elegantes e eficientes utilizando Python.
