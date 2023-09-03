# Calcular o Preço Final de um Pedido
"""
    Você está criando um aplicativo de entrega de comida e precisa calcular o preço final do pedido do usuário. 
    O usuário escolheu alguns itens do cardápio e é preciso calcular o preço total do pedido.
"""

valorHamburguer = float(input())
quantidadeHamburguer = int(input())
valorBebida = float(input())
quantidadeBebida = int(input())
valorPago = float(input())

valor_pedido = ((valorHamburguer * quantidadeHamburguer) + (valorBebida * quantidadeBebida))
troco = valorPago - valor_pedido

print(f"O preço final do pedido é R$ {valor_pedido:.2f}. Seu troco é R$ {troco:.2f}.")