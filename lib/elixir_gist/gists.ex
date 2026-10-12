 defmodule ElixirGist.Gists do
  @moduledoc """
  The Gists context.
  """

  import Ecto.Query, warn: false
  alias ElixirGist.Repo

  alias ElixirGist.Gists.Gist

  @doc """
  Returns the list of gists.

  ## Examples

      iex> list_gists()
      [%Gist{}, ...]

  """
  def list_gists do
    Repo.all(Gist)
  end

  @doc """
  Gets a single gist.

  Raises `Ecto.NoResultsError` if the Gist does not exist.

  ## Examples

      iex> get_gist!(123)
      %Gist{}

      iex> get_gist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gist!(id), do: Repo.get!(Gist, id)

  @doc """
  Creates a gist.

  ## Examples

      iex> create_gist(%{field: value})
      {:ok, %Gist{}}

      iex> create_gist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gist(user,attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:gists)
    |> Gist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gist.

  ## Examples

      iex> update_gist(gist, %{field: new_value})
      {:ok, %Gist{}}

      iex> update_gist(gist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gist(%Gist{} = gist, attrs) do
    gist
    |> Gist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gist.

  ## Examples

      iex> delete_gist(gist)
      {:ok, %Gist{}}

      iex> delete_gist(gist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gist(%Gist{} = gist) do
    Repo.delete(gist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gist changes.

  ## Examples

      iex> change_gist(gist)
      %Ecto.Changeset{data: %Gist{}}

  """
  def change_gist(%Gist{} = gist, attrs \\ %{}) do
    Gist.changeset(gist, attrs)
  end

  alias ElixirGist.Gists.Savedgist

  @doc """
  Returns the list of saved_gists.

  ## Examples

      iex> list_saved_gists()
      [%Savedgist{}, ...]

  """
  def list_saved_gists do
    Repo.all(Savedgist)
  end

  @doc """
  Gets a single savedgist.

  Raises `Ecto.NoResultsError` if the Savedgist does not exist.

  ## Examples

      iex> get_savedgist!(123)
      %Savedgist{}

      iex> get_savedgist!(456)
      ** (Ecto.NoResultsError)

  """
  def get_savedgist!(id), do: Repo.get!(Savedgist, id)

  @doc """
  Creates a savedgist.

  ## Examples

      iex> create_savedgist(%{field: value})
      {:ok, %Savedgist{}}

      iex> create_savedgist(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_savedgist(user, attrs \\ %{}) do
    user
    |> Ecto.build_assoc(:saved_gists)
    |> Savedgist.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a savedgist.

  ## Examples

      iex> update_savedgist(savedgist, %{field: new_value})
      {:ok, %Savedgist{}}

      iex> update_savedgist(savedgist, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_savedgist(%Savedgist{} = savedgist, attrs) do
    savedgist
    |> Savedgist.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a savedgist.

  ## Examples

      iex> delete_savedgist(savedgist)
      {:ok, %Savedgist{}}

      iex> delete_savedgist(savedgist)
      {:error, %Ecto.Changeset{}}

  """
  def delete_savedgist(%Savedgist{} = savedgist) do
    Repo.delete(savedgist)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking savedgist changes.

  ## Examples

      iex> change_savedgist(savedgist)
      %Ecto.Changeset{data: %Savedgist{}}

  """
  def change_savedgist(%Savedgist{} = savedgist, attrs \\ %{}) do
    Savedgist.changeset(savedgist, attrs)
  end
end
