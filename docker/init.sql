CREATE DATABASE api_elixir_rinha;

\c api_elixir_rinha;

CREATE TABLE cliente (
                         id SERIAL PRIMARY KEY,
                         saldo INTEGER DEFAULT 0,
                         limite INTEGER DEFAULT 0,
                         inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transacoes (
                            id SERIAL PRIMARY KEY,
                            valor INTEGER NOT NULL,
                            tipo VARCHAR(255) NOT NULL CHECK (tipo IN ('c', 'd')),
                            descricao VARCHAR(255),
                            cliente_id INTEGER NOT NULL,
                            inserted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                            FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);