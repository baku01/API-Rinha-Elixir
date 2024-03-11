defmodule ApiElixirRinha.Rinha do
  @moduledoc """
  The Rinha context.
  """

  import Ecto.Query, warn: false
  alias ApiElixirRinha.Repo

  alias ApiElixirRinha.Rinha.Cliente

  @doc """
  Returns the list of cliente.

  ## Examples

      iex> list_cliente()
      [%Cliente{}, ...]

  """
  def list_cliente do
    Repo.all(Cliente)
  end

  @doc """
  Gets a single cliente.

  Raises `Ecto.NoResultsError` if the Cliente does not exist.

  ## Examples

      iex> get_cliente!(123)
      %Cliente{}

      iex> get_cliente!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cliente!(id), do: Repo.get!(Cliente, id)

  @doc """
  Creates a cliente.

  ## Examples

      iex> create_cliente(%{field: value})
      {:ok, %Cliente{}}

      iex> create_cliente(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cliente(attrs \\ %{}) do
    %Cliente{}
    |> Cliente.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cliente.

  ## Examples

      iex> update_cliente(cliente, %{field: new_value})
      {:ok, %Cliente{}}

      iex> update_cliente(cliente, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cliente(%Cliente{} = cliente, attrs) do
    cliente
    |> Cliente.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cliente.

  ## Examples

      iex> delete_cliente(cliente)
      {:ok, %Cliente{}}

      iex> delete_cliente(cliente)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cliente(%Cliente{} = cliente) do
    Repo.delete(cliente)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cliente changes.

  ## Examples

      iex> change_cliente(cliente)
      %Ecto.Changeset{data: %Cliente{}}

  """
  def change_cliente(%Cliente{} = cliente, attrs \\ %{}) do
    Cliente.changeset(cliente, attrs)
  end

  alias ApiElixirRinha.Rinha.Transacoes

  @doc """
  Returns the list of transacoes.

  ## Examples

      iex> list_transacoes()
      [%Transacoes{}, ...]

  """
  def list_transacoes do
    Repo.all(Transacoes)
  end

  @doc """
  Gets a single transacoes.

  Raises `Ecto.NoResultsError` if the Transacoes does not exist.

  ## Examples

      iex> get_transacoes!(123)
      %Transacoes{}

      iex> get_transacoes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transacoes!(id), do: Repo.get!(Transacoes, id)

  @doc """
  Creates a transacoes.

  ## Examples

      iex> create_transacoes(%{field: value})
      {:ok, %Transacoes{}}

      iex> create_transacoes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transacoes(attrs \\ %{}) do
    %Transacoes{}
    |> Transacoes.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transacoes.

  ## Examples

      iex> update_transacoes(transacoes, %{field: new_value})
      {:ok, %Transacoes{}}

      iex> update_transacoes(transacoes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transacoes(%Transacoes{} = transacoes, attrs) do
    transacoes
    |> Transacoes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transacoes.

  ## Examples

      iex> delete_transacoes(transacoes)
      {:ok, %Transacoes{}}

      iex> delete_transacoes(transacoes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transacoes(%Transacoes{} = transacoes) do
    Repo.delete(transacoes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transacoes changes.

  ## Examples

      iex> change_transacoes(transacoes)
      %Ecto.Changeset{data: %Transacoes{}}

  """
  def change_transacoes(%Transacoes{} = transacoes, attrs \\ %{}) do
    Transacoes.changeset(transacoes, attrs)
  end
end
