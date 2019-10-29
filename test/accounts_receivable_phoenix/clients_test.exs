defmodule AccountsReceivablePhoenix.ClientsTest do
  use AccountsReceivablePhoenix.DataCase

  alias AccountsReceivablePhoenix.Clients

  describe "clients" do
    alias AccountsReceivablePhoenix.Clients.Client

    test "list_clients/0 returns all clients" do
      client = insert(:client)
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = insert(:client)
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{email: "some email", name: "some name"}
      assert {:ok, %Client{} = client} = Clients.create_client(valid_attrs)
      assert client.email == "some email"
      assert client.name == "some name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      invalid_attrs = %{email: nil, name: nil}
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = insert(:client)
      update_attrs = %{email: "some updated email", name: "some updated name"}
      assert {:ok, %Client{} = client} = Clients.update_client(client, update_attrs)
      assert client.email == "some updated email"
      assert client.name == "some updated name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = insert(:client)
      invalid_attrs = %{email: nil, name: nil}
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = insert(:client)
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = insert(:client)
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end
end
