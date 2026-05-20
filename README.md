# projeto-jogo-assemly

O jogo consiste em turnos de ação interativos do usuário contra uma máquina
em cada turno o usuário terá a opção de
- Dar um passe para qualquer zona do campo com exceção de sua zona atual (exemplo: se você está no meio campo, você pode escolher passar para o goleiro, os zagueiros ou os atacantes)
- Chutar ao gol
- Ver o placar atual (essa ação não gasta tempo do jogo)

Cada ação terá uma probabilidade de sucesso ou de fracasso, com uma probabilidade pré definida, em caso de fracasso o sistema irá jogar automaticamente até errar ou fazer um gol, então o controle é devolvido ao player (as ações do sistema tambem contam para o tempo do jogo)

O jogo acabará passados 90 minutos (ou seja, 90 ações), então exibindo uma mensagem correspondente ao resultado.

O placar irá ter o formato seguinte
´´´

  # ==============================================
        TEMPO: 90 min
        BRASIL 3 X 2 FRANCA
        12 Vinicius Jr
        44 Raphinha
        45 Mbappe
        88 Mbappe
        89 Neymar Jr
  # ==============================================
´´´
O placar deve sempre mostar o estado atual do jogo, podendo ser solicitado a qualquer momento pelo player.



