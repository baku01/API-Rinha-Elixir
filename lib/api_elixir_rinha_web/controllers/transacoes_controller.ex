defmodule ApiElixirRinhaWeb.TransacoesController do
  use ApiElixirRinhaWeb, :controller


  alias ApiElixirRinha.Rinha
  alias ApiElixirRinha.Rinha.Transacoes
  alias ApiElixirRinha.Repo

  action_fallback ApiElixirRinhaWeb.FallbackController


  def index(conn, _params) do
    transacoes = Rinha.list_transacoes()
    render(conn, :index, transacoes: transacoes)
  end

  def create(conn, %{"transacoes" => transacoes_params}) do
    cliente_id = Map.get(transacoes_params, "cliente_id")

    if cliente_id do
      case Repo.get(ApiElixirRinha.Rinha.Cliente, cliente_id) do
        nil ->
          conn
          |> put_status(:bad_request)
          |> json(%{error: "Cliente with provided ID does not exist"})
        _cliente ->
          attrs = Map.put(transacoes_params, "cliente_id", cliente_id)

          with {:ok, %Transacoes{} = transacoes} <- Rinha.create_transacoes(attrs) do
            transacoes = Repo.preload(transacoes, :cliente)

            conn
            |> put_status(:created)
            |> render(:show, transacoes: transacoes)
          end
      end
    else
      conn
      |> put_status(:bad_request)
      |> json(%{error: "cliente_id is missing in the request parameters"})
    end
  end

  def show(conn, %{"id" => id}) do
    transacoes = Rinha.get_transacoes!(id)
    render(conn, :show, transacoes: transacoes)
  end

  def update(conn, %{"id" => id, "transacoes" => transacoes_params}) do
    transacoes = Rinha.get_transacoes!(id)

    with {:ok, %Transacoes{} = transacoes} <- Rinha.update_transacoes(transacoes, transacoes_params) do
      render(conn, :show, transacoes: transacoes)
    end
  end

  def delete(conn, %{"id" => id}) do
    transacoes = Rinha.get_transacoes!(id)

    with {:ok, %Transacoes{}} <- Rinha.delete_transacoes(transacoes) do
      send_resp(conn, :no_content, "")
    end
  end
end
