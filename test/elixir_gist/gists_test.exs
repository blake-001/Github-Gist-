defmodule ElixirGist.GistsTest do
  use ElixirGist.DataCase

  alias ElixirGist.Gists

  describe "gists" do
    alias ElixirGist.Gists.Gist

    import ElixirGist.GistsFixtures

    @invalid_attrs %{name: nil, description: nil, markup_text: nil}

    test "list_gists/0 returns all gists" do
      gist = gist_fixture()
      assert Gists.list_gists() == [gist]
    end

    test "get_gist!/1 returns the gist with given id" do
      gist = gist_fixture()
      assert Gists.get_gist!(gist.id) == gist
    end

    test "create_gist/1 with valid data creates a gist" do
      valid_attrs = %{name: "some name", description: "some description", markup_text: "some markup_text"}

      assert {:ok, %Gist{} = gist} = Gists.create_gist(valid_attrs)
      assert gist.name == "some name"
      assert gist.description == "some description"
      assert gist.markup_text == "some markup_text"
    end

    test "create_gist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gists.create_gist(@invalid_attrs)
    end

    test "update_gist/2 with valid data updates the gist" do
      gist = gist_fixture()
      update_attrs = %{name: "some updated name", description: "some updated description", markup_text: "some updated markup_text"}

      assert {:ok, %Gist{} = gist} = Gists.update_gist(gist, update_attrs)
      assert gist.name == "some updated name"
      assert gist.description == "some updated description"
      assert gist.markup_text == "some updated markup_text"
    end

    test "update_gist/2 with invalid data returns error changeset" do
      gist = gist_fixture()
      assert {:error, %Ecto.Changeset{}} = Gists.update_gist(gist, @invalid_attrs)
      assert gist == Gists.get_gist!(gist.id)
    end

    test "delete_gist/1 deletes the gist" do
      gist = gist_fixture()
      assert {:ok, %Gist{}} = Gists.delete_gist(gist)
      assert_raise Ecto.NoResultsError, fn -> Gists.get_gist!(gist.id) end
    end

    test "change_gist/1 returns a gist changeset" do
      gist = gist_fixture()
      assert %Ecto.Changeset{} = Gists.change_gist(gist)
    end
  end

  describe "saved_gists" do
    alias ElixirGist.Gists.Savedgist

    import ElixirGist.GistsFixtures

    @invalid_attrs %{}

    test "list_saved_gists/0 returns all saved_gists" do
      savedgist = savedgist_fixture()
      assert Gists.list_saved_gists() == [savedgist]
    end

    test "get_savedgist!/1 returns the savedgist with given id" do
      savedgist = savedgist_fixture()
      assert Gists.get_savedgist!(savedgist.id) == savedgist
    end

    test "create_savedgist/1 with valid data creates a savedgist" do
      valid_attrs = %{}

      assert {:ok, %Savedgist{} = savedgist} = Gists.create_savedgist(valid_attrs)
    end

    test "create_savedgist/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Gists.create_savedgist(@invalid_attrs)
    end

    test "update_savedgist/2 with valid data updates the savedgist" do
      savedgist = savedgist_fixture()
      update_attrs = %{}

      assert {:ok, %Savedgist{} = savedgist} = Gists.update_savedgist(savedgist, update_attrs)
    end

    test "update_savedgist/2 with invalid data returns error changeset" do
      savedgist = savedgist_fixture()
      assert {:error, %Ecto.Changeset{}} = Gists.update_savedgist(savedgist, @invalid_attrs)
      assert savedgist == Gists.get_savedgist!(savedgist.id)
    end

    test "delete_savedgist/1 deletes the savedgist" do
      savedgist = savedgist_fixture()
      assert {:ok, %Savedgist{}} = Gists.delete_savedgist(savedgist)
      assert_raise Ecto.NoResultsError, fn -> Gists.get_savedgist!(savedgist.id) end
    end

    test "change_savedgist/1 returns a savedgist changeset" do
      savedgist = savedgist_fixture()
      assert %Ecto.Changeset{} = Gists.change_savedgist(savedgist)
    end
  end
end
