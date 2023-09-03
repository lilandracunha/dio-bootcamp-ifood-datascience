# Gerenciamento de Pedidos de Comida Online
"""
    Você foi contratado para desenvolver um sistema que armazena informações dos pedidos de comida online realizados por um cliente. 
    O sistema deve permitir ao cliente inserir novos pedidos, escolher um cupom de desconto (10% ou 20%) e exibir o valor total de todos os pedidos realizados até o momento, com o desconto aplicado.
"""

def main():
    n = int(input())
 
    total = 0
 
    for i in range(1, n + 1):
        pedido = input().split(" ")
        nome = pedido[0]
        valor = float(pedido[1])
        total += valor
    
    cupom_desconto = input()
    desconto = 0.0
    
    if cupom_desconto == "10%":
      desconto = 0.1
    elif cupom_desconto == "20%":
      desconto = 0.2
    
    valor_com_desconto = total - (total * desconto)
    print(f"Valor total: {valor_com_desconto:.2f}")
 
if __name__ == "__main__":
    main()