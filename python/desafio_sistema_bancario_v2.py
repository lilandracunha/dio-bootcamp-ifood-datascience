# Sistema Bancário - v2.0.1
def cadastrar_usuario(usuarios):
  cpf = input("Para começar, informe o CPF para cadastro (somente números): ")
  usuario = consultar_cliente(cpf, usuarios)

  if usuario:
    print("\nATENÇÃO! O CPF informado já está cadastrado.")
    return

  nome = input("- Informe o seu nome completo: ")
  data_nascimento = input("- Informe a sua data de nascimento (inclua a data no formato DD-MM-AAAA [dia-mês-ano]): ")
  endereco_logradouro = input("- Informe o seu endereço. Atenção: Digite apenas o nome da rua/avenida: ")
  endereco_numero = input("- Digite o número e complemento, caso houver, de sua residência: ")
  endereco_bairro = input("- Informe o bairro de sua residência: ")
  endereco_cidade = input("- Informe a cidade onde sua residência está localizada: ")
  endereco_estado =  input("- Agora precisamos da sigla do estado onde reside (por exemplo, se for o estado de São Paulo, digite SP): ")

  usuarios.append({"nome": nome,
                  "data_nascimento": data_nascimento,
                   "cpf": cpf,
                   "endereco": {endereco_logradouro, endereco_numero, endereco_bairro, endereco_cidade, endereco_estado}})
  print("\nUsuário cadastrado com sucesso!")

def consultar_cliente(cpf, usuarios):
  lista_usuarios = [usuario for usuario in usuarios if usuario["cpf"] == cpf]
  return lista_usuarios[0] if lista_usuarios else None

def criar_conta(agencia, numero_conta, usuarios):
  cpf = input("Para criar uma nova conta, informe o CPF cadastrado (somente números): ")
  usuario = consultar_cliente(cpf, usuarios)

  if usuario:
    print(f"Conta criada com sucesso! A seguir estão os dados de sua conta: \nAgência: {agencia} \nConta: {numero_conta}")
    return {"agencia": agencia,
            "numero_conta": numero_conta,
            "usuario": usuario}

  print("\nNão foi possível concluir a solicitação! \nMotivo: Usuário não encontrado.")


def consultar_conta(contas, usuarios):
  cpf = input("Confirme o seu CPF: ")
  usuario = consultar_cliente(cpf, usuarios)

  if usuario:
    for conta in contas:
      retorno_consulta_conta = f'''
      Titular: {conta["usuario"]["nome"]}
      Agência: {conta["agencia"]}
      C/C: {conta["numero_conta"]}
      '''
      print(retorno_consulta_conta)
  else:
    print("\nNão foi possível concluir a solicitação! \nMotivo: Usuário não encontrado.")

def deposito(valor_deposito, saldo, extrato, /):
  if valor_deposito > 0:
    saldo += valor_deposito
    extrato += f"Depósito: R$ {valor_deposito:.2f}\n"
    print("\nDepósito realizado com sucesso!")

  else:
    print("\nFALHA NA OPERAÇÃO \nMotivo: O valor informado é inválido.")

  return saldo, extrato


def saque(*, valor_saque, saldo, saques_realizados, extrato, LIMITE_DIARIO_SAQUES, limite_para_saque):
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

  return saques_realizados, saldo, extrato


def consultar_extrato(saldo, /, *, extrato):
  print(">>> EXTRATO\n")

  if not extrato:
    print("Não foram realizadas movimentações.\n")

  else:
    print(extrato)
    print(f"Saldo atual: R$ {saldo:.2f}")

def main():
  # Dessa vez temos mais de uma constante e irei defini-las no início da main
  LIMITE_DIARIO_SAQUES = 3
  AGENCIA = "0001"

  saldo = 0
  saques_realizados = 0
  limite_para_saque = 500
  extrato = ""

  usuarios = []
  contas = []
  numero_conta = 1000

  while True:
    menu_bancario = '''
    ----------------------------- MENU -----------------------------
        [1] Cadastrar novo usuário
        [2] Criar uma nova conta
        [3] Consultar contas
        [4] Efetuar depósito
        [5] Realizar saque
        [6] Consultar extrato
        [7] Sair
    ----------------------------------------------------------------
    '''
    print(menu_bancario)
    opcao = int(input("Selecione o número referente a ação que deseja executar: "))
    print()

    # [1] Cadastrar novo usuário
    if opcao == 1:
      cadastrar_usuario(usuarios)

    # [2] Criar uma nova conta
    elif opcao == 2:
      conta = criar_conta(AGENCIA, numero_conta, usuarios)

      if conta:
        contas.append(conta)
        numero_conta += 1

    # [3] Consultar contas
    elif opcao == 3:
      consultar_conta(contas, usuarios)

    # [4] Efetuar depósito - valor_deposito, saldo, extrato, /
    elif opcao == 4:
      valor_deposito = float(input("Informe o valor do depósito: "))
      saldo, extrato = deposito(valor_deposito, saldo, extrato)

    # [5] Realizar saque
    elif opcao == 5:
      valor_saque = float(input("Informe o valor do saque: "))

      saques_realizados, saldo, extrato = saque(valor_saque = valor_saque,
                             saldo = saldo,
                             saques_realizados = saques_realizados,
                             extrato = extrato,
                             LIMITE_DIARIO_SAQUES = LIMITE_DIARIO_SAQUES,
                             limite_para_saque = limite_para_saque)

    # [6] Consultar extrato
    elif opcao == 6:
      consultar_extrato(saldo, extrato = extrato)

    # [7] Sair
    elif opcao == 7:
      print("Agradecemos por escolher o nosso banco. Até logo!")
      break

    # [0] Excluir uma conta
    else:
      print("Opção inválida.\nSelecione uma opção dentre as apresentadas no menu.\n")

main()