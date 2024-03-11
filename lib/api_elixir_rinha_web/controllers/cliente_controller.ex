defmodule ApiElixirRinhaWeb.ClienteController do
  use ApiElixirRinhaWeb, :controller

  alias ApiElixirRinha.Rinha
  alias ApiElixirRinha.Rinha.Cliente
  alias ApiElixirRinha.Repo
  import Ecto.Query

  action_fallback ApiElixirRinhaWeb.FallbackController

  def index(conn, _params) do
    cliente = Rinha.list_cliente()
    render(conn, :index, cliente: cliente)
  end

  def create(conn, %{"cliente" => cliente_params}) do
    with {:ok, %Cliente{} = cliente} <- Rinha.create_cliente(cliente_params) do
      conn
      |> put_status(:created)
      |> render(:show, cliente: cliente)
    end
  end

  def show(conn, %{"id" => id}) do
    if is_nil(id) do
      conn
      |> put_status(:not_found)
      |> json(%{error: "Cliente with provided ID does not exist"})
    else
      case Repo.get(ApiElixirRinha.Rinha.Cliente, id) do
        nil ->
          conn
          |> put_status(:not_found)
          |> json(%{error: "Cliente not found"})
        cliente ->
          render(conn, :show, cliente: cliente)
      end
    end
  end

  def update(conn, %{"id" => id, "cliente" => cliente_params}) do
    cliente = Rinha.get_cliente!(id)

    with {:ok, %Cliente{} = cliente} <- Rinha.update_cliente(cliente, cliente_params) do
      render(conn, :show, cliente: cliente)
    end
  end

  def delete(conn, %{"id" => id}) do
    cliente = Rinha.get_cliente!(id)

    with {:ok, %Cliente{}} <- Rinha.delete_cliente(cliente) do
      send_resp(conn, :no_content, "")
    end
  end
  def get_extrato(cliente_id) do
    case Repo.get(ApiElixirRinha.Rinha.Cliente, cliente_id) do
      nil ->
        {:error, "Cliente not found"}
      cliente ->
        transacoes = Repo.all(from t in ApiElixirRinha.Rinha.Transacoes, where: t.cliente_id == ^cliente_id, order_by: [desc: t.inserted_at], limit: 5)

        extrato = %{
          saldo: %{
            total: cliente.saldo,
            data_extrato: DateTime.utc_now() |> DateTime.to_iso8601(),
            limite: cliente.limite
          },
          ultimas_transacoes: Enum.map(transacoes, fn t -> %{
                                                             valor: t.valor,
                                                             tipo: t.tipo,
                                                             descricao: t.descricao,
                                                             realizada_em: t.inserted_at |> DateTime.to_iso8601()
                                                           } end)
        }

        {:ok, extrato}
    end
  end

  def extrato(conn, %{"id" => id}) do
    case get_extrato(id) do
      {:ok, extrato} ->
        json(conn, extrato)
      {:error, reason} ->
        conn
        |> put_status(:not_found)
        |> json(%{error: reason})
    end
  end

end

