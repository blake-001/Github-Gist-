defmodule ElixirGistWeb.GistFormComponent do
  use ElixirGistWeb,:live_component


  alias ElixirGist.{Gists, Gists.Gist}

  def mount(socket) do
  {:ok, socket}
  end


  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="create" phx-change="validate" phx-target={@myself}>
        <div class="justify-center px-4 sm:px-8 lg:px-20 w-full space-y-4 mb-10">
          <input type="hidden" name={@form[:id].name} value={@id} />
          <.input field={@form[:description]} placeholder="Gist description..." autocomplete="off" phx-debounce="blur" />
          <div>
            <div class="p-2 bg-emdark rounded-t-md border border-white">
              <div class="w-full max-w-48 mb-2">
                <.input
                  field={@form[:name]}
                  placeholder="Filename including extension..."
                  autocomplete="off"
                  phx-debounce="blur"
                />
              </div>
            </div>

            <div id="gist-wrapper" class="flex w-full min-w-0" phx-update="ignore">
              <textarea id="line-numbers" class="line-numbers shrink-0 rounded-bl-md" readonly>1</textarea>
              <div class="min-w-0 flex-1">
                <textarea
                  id={@form[:markup_text].id}
                  name={@form[:markup_text].name}
                  phx-hook="UpdateLineNumbers"
                  class="gist-editor w-full rounded-br-md"
                  placeholder="Insert code..."
                  spellcheck="false"
                  autocomplete="off"
                  phx-debounce="blur"
                ><%= Phoenix.HTML.Form.normalize_value("textarea", @form[:markup_text].value) %></textarea>
              </div>
            </div>

            <div class="mt-4 flex justify-end">
              <%= if @id == :new do %>
              <.button class="create_button" phx-disable-with="Creating...">Create gist</.button>
              <% else %>
              <.button class="create_button" phx-disable-with="Updating...">Update gist</.button>
              <% end %>
            </div>
          </div>
        </div>
        </.form>
    </div>
    """
    end

    def handle_event("validate", %{"gist" => params}, socket) do
      changeset =
        socket.assigns.form.data
        |> Gists.change_gist(params)
        |> Map.put(:action, :validate)
      {:noreply, assign(socket, :form, to_form(changeset))}
    end

    def handle_event("create", %{"gist" => params}, socket) do
      if params["id"] == "new" do
        create_gist(params, socket)
      else
        update_gist(params, socket)
      end
    end

    defp create_gist(params, socket) do
      case Gists.create_gist(socket.assigns.current_user, params) do
        {:ok, gist} ->
        socket = push_event(socket, "clear-textareas", %{})
        changeset =Gists.change_gist(%Gist{})
        socket = assign(socket, :form, to_form(changeset))
          {:noreply, push_navigate(socket, to: ~p"/gist?#{[id: gist.id]}")}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, :form, to_form(changeset))}
      end
    end

    defp update_gist(params, socket) do
      case Gists.update_gist(socket.assigns.current_user, params) do
        {:ok, gist} ->
          {:noreply, push_navigate(socket, to: ~p"/gist?#{[id: gist.id]}")}

          {:error, message} ->
            socket = put_flash(socket, :error, message)
            {:noreply, socket}
        end
    end

end
