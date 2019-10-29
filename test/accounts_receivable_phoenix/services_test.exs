defmodule AccountsReceivablePhoenix.ServicesTest do
  use AccountsReceivablePhoenix.DataCase

  alias AccountsReceivablePhoenix.Services

  describe "services" do
    alias AccountsReceivablePhoenix.Services.Service

    test "list_services/0 returns all services" do
      service = insert(:service)
      assert Services.list_services() == [service]
    end

    test "get_service!/1 returns the service with given id" do
      service = insert(:service)
      assert Services.get_service!(service.id) == service
    end

    test "create_service/1 with valid data creates a service" do
      valid_attrs = %{name: "some name", price_cents: 42}
      assert {:ok, %Service{} = service} = Services.create_service(valid_attrs)
      assert service.name == "some name"
      assert service.price_cents == 42
    end

    test "create_service/1 with invalid data returns error changeset" do
      invalid_attrs = %{name: nil, price_cents: nil}
      assert {:error, %Ecto.Changeset{}} = Services.create_service(invalid_attrs)
    end

    test "update_service/2 with valid data updates the service" do
      service = insert(:service)
      update_attrs = %{name: "some updated name", price_cents: 43}
      assert {:ok, %Service{} = service} = Services.update_service(service, update_attrs)
      assert service.name == "some updated name"
      assert service.price_cents == 43
    end

    test "update_service/2 with invalid data returns error changeset" do
      service = insert(:service)
      invalid_attrs = %{name: nil, price_cents: nil}
      assert {:error, %Ecto.Changeset{}} = Services.update_service(service, invalid_attrs)
      assert service == Services.get_service!(service.id)
    end

    test "delete_service/1 deletes the service" do
      service = insert(:service)
      assert {:ok, %Service{}} = Services.delete_service(service)
      assert_raise Ecto.NoResultsError, fn -> Services.get_service!(service.id) end
    end

    test "change_service/1 returns a service changeset" do
      service = insert(:service)
      assert %Ecto.Changeset{} = Services.change_service(service)
    end
  end
end
