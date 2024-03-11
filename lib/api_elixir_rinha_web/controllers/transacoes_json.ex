defmodule ApiElixirRinhaWeb.TransacoesJSON do
  alias ApiElixirRinha.Rinha.Transacoes

  @doc """
  Renders a list of transacoes.
  """
  def index(%{transacoes: transacoes}) do
    %{data: for(transacoes <- transacoes, do: data(transacoes))}
  end

  @doc """
  Renders a single transacoes.
  """
  def show(%{transacoes: transacoes}) do
    %{data: data(transacoes)}
  end

  defp data(%Transacoes{} = transacoes) do
    %{
      id: transacoes.id,
      valor: transacoes.valor,
      tipo: transacoes.tipo,
      descricao: transacoes.descricao,
      cliente_id: transacoes.cliente_id,
    }
  end
end
