# Sistema Bancário - v1.0.1
# Iniciei o desafio proposto criando as variáveis iniciais que serão utilizadas
saldo = 0
LIMITE_DIARIO_SAQUES = 3
saques_realizados = 0
limite_para_saque = 500
extrato = ""

# O programa começou com um laço While True
while True:

  menu_bancario = '''
  ----------------------------- MENU -----------------------------
      [1] Efetuar depósito
      [2] Realizar saque
      [3] Consultar extrato
      [4] Sair
  ----------------------------------------------------------------
  '''
  print(menu_bancario)

  opcao = int(input("Selecione o número referente a ação que deseja executar: "))
  print()

# [1] Depósito: Deve ser possível depositar valores positivos e todos os depósitos realizados devem ser armazenados para visualização no extrato
  if opcao == 1:
    valor_deposito = float(input("Informe o valor do depósito: "))

    if valor_deposito > 0:
       saldo += valor_deposito
       extrato += f"Depósito: R$ {valor_deposito:.2f}\n"
       print("\nDepósito realizado com sucesso!")

    else:
      print("\nFALHA NA OPERAÇÃO \nMotivo: O valor informado é inválido.")

# [2] Saque: Será possível executar apenas 3 saques diários e o valor limite para cada saque é de 500,00 (valor definido acima); todos os saques realizados devem ser armazenados para visualização no extrato
  elif opcao == 2:
    valor_saque = float(input("Informe o valor do saque: "))

    if valor_saque > saldo:
      print("\nFALHA NA OPERAÇÃO \nMotivo: Saldo insuficiente.")

    elif valor_saque > limite_para_saque:
      print("\nFALHA NA OPERAÇÃO \nMotivo: O valor solicitado excede o limite disponível para saque.")

    elif saques_realizados >= LIMITE_DIARIO_SAQUES:
      print("\nFALHA NA OPERAÇÃO \nMotivo: O limite de saques diários foi atingido.")

    elif valor_saque > 0:
      saldo -= valor_saque
      saques_realizados += 1
      extrato += f"Saque: R$ {valor_saque:.2f}\n"
      print("\nSaque realizado com sucesso!")

      while saques_realizados < LIMITE_DIARIO_SAQUES:
        print(f"Ainda é possível realizar {LIMITE_DIARIO_SAQUES - saques_realizados} saque(s) no dia de hoje.")
        break

    else:
      print("\nFALHA NA OPERAÇÃO \nMotivo: O valor informado é inválido.")

# [3] Extrato: Deve listar todas as operações (depósitos e saques) e apresentar o saldo atual. Se o extrato estiver em branco, deve exibir a mensagem "Não foram realizadas movimentações"
  elif opcao == 3:
    print(">>> EXTRATO\n")

    if not extrato:
      print("Não foram realizadas movimentações.\n")

    else:
      print(extrato)
      print(f"Saldo atual: R$ {saldo:.2f}")

# [4] Sair: Opção que encerra a execução
  elif opcao == 4:
    print("Agradecemos por escolher o nosso banco. Até logo!")
    break

  else:
    print("Opção inválida.\nSelecione uma opção dentre as apresentadas no menu.\n")