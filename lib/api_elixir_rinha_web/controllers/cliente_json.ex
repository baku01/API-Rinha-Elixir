defmodule ApiElixirRinhaWeb.ClienteJSON do
  alias ApiElixirRinha.Rinha.Cliente

  @doc """
  Renders a list of cliente.
  """
  def index(%{cliente: cliente}) do
    %{data: for(cliente <- cliente, do: data(cliente))}
  end

  @doc """
  Renders a single cliente.
  """
  def show(%{cliente: cliente}) do
    %{cliente: data(cliente)}
  end

  defp data(%Cliente{} = cliente) do
    %{
      id: cliente.id,
      limite: cliente.limite,
      saldo: cliente.saldo
    }
  end

end
