# 🚀 API Rinha - Elixir

## Descrição
Este projeto consiste em uma aplicação de API desenvolvida em Elixir, utilizando o framework Phoenix, para rinha Backend-2024 (No final nem submitei o projeto).

## Configuração
1. Clone este repositório em sua máquina local.
2. Certifique-se de ter o Docker e o Docker Compose instalados em seu sistema.
3. Altere as configurações necessárias nos arquivos de configuração, se necessário.
4. Certifique-se de ter o arquivo `init.sql` na raiz do projeto, se desejar inicializar o banco de dados com dados pré-existentes.

## Execução
1. Navegue até o diretório raiz do projeto e depois docker.
2. Execute o seguinte comando para iniciar os serviços:
    ```
    docker-compose up -d
    ```
3. Aguarde até que todos os serviços estejam iniciados e prontos para uso.

## Acesso
- Acesse a API através do HAProxy em: `http://localhost:9999`
- Acesso direto às instâncias da aplicação web:
    - `http://localhost:4000` (Web1)
    - `http://localhost:4001` (Web2)

