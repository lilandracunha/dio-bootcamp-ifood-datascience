# Identificando Pedidos Veganos
"""
    O objetivo deste programa é ajudar a equipe do Restaurante Veggieworld a identificar rapidamente os pedidos veganos e 
    não veganos e informar as calorias de cada prato definido pelo cliente. 
    O programa deve solicitar ao usuário o número de pedidos que serão feitos e, em seguida, pedir informações sobre cada pedido, 
    incluindo se o prato é vegano ou não (usando as opções "s" para sim e "n" para não) e a quantidade de calorias. 
    
    Ao final, o programa deve exibir uma lista de todos os pedidos com suas informações correspondentes.
"""

numPedidos = int(input())

for i in range(1, numPedidos + 1):
    prato = input()
    calorias = int(input())
    ehVegano = input()
    
    if ehVegano == "s":
      tipo = "Vegano"
    else:
      tipo = "Nao-vegano"
    
    print(f"Pedido {i}: {prato} ({tipo}) - {calorias} calorias")