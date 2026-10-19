defmodule ElixirGistWeb.GistLive do
  use ElixirGistWeb, :live_view

  alias ElixirGist.Gists
  alias ElixirGistWeb.GistFormComponent

  def mount(%{"id" => id}, _session, socket) do
    gist = Gists.get_gist!(id)

    can_manage_gist? =
      case socket.assigns.current_user do
        %{id: user_id} -> user_id == gist.user_id
        _ -> false
      end
    {:ok, relative_time} = Timex.format(gist.updated_at, "{relative}", :relative)
    gist = Map.put(gist, :relative, relative_time)
    {:ok, assign(socket, gist: gist, can_manage_gist?: can_manage_gist?)}
  end

  @spec handle_event(<<_::48>>, map(), Phoenix.LiveView.Socket.t()) :: {:noreply, map()}
  @spec handle_event(<<_::48>>, map(), Phoenix.LiveView.Socket.t()) :: {:noreply, map()}
  def handle_event("delete", %{"id" => id}, socket) do
    case Gists.delete_gist(socket.assigns.current_user, id) do
    {:ok, _gist} ->
      socket = put_flash(socket, :info, "Gist Successfully Deleted")
      {:noreply, push_navigate(socket, to: ~p"/create")}

    {:error, message} ->
      socket = put_flash(socket, :error, message)
      {:noreply, socket}
    end
  end
end
