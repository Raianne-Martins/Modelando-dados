# Descrição

Modelagem de dados para um e-commerce utilizando o MYSQL Workbench.

# Modelo Relacional Desenvolvido
- Para gerenciar de forma eficiente o sistema de pedidos, as entidades e seus respectivos relacionamentos foram criados. 
- A entidade **Cliente** se relaciona com as entidades Cliente - Físico e Cliente- Empresa de forma 1:1, onde para o modelo o clipe só pode ser de um tipo. A entidade se relaciona com a entidade Pedido de forma 1:n, já que um cliente pode ter vários pedidos.<br> 
- A entidade **Formas de Pagamento** se relaciona com a entidade Cliente de forma n:m, por meio de uma tabela intermediária. <br>
- A entidade **Status** se relaciona com a entidade Pedido de forma 1:n.

# Modelagem

[Modelagem](https://github.com/Raianne-Martins/Modelando-dados/blob/main/modelo_ecommerce1.png)

![modelo_ecommerce1](https://github.com/user-attachments/assets/0638616d-ba30-4f78-a06d-8a8f50f0c567)
