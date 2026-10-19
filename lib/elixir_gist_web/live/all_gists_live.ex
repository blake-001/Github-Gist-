defmodule ElixirGistWeb.AllGistsLive do
  use ElixirGistWeb, :live_view
  alias ElixirGist.Gists
  alias ElixirGistWeb.Utilities.DateFormat

  def mount(_params, _session, socket) do
  {:ok, socket}
  end

  def handle_params(_params, _uri, socket) do
    gists = Gists.list_gists()

    socket =
      assign(socket,
        gists: gists
      )
    {:noreply, socket}
  end
def gist(assigns) do
~H"""
<div class="mx-auto mb-10 flex w-full max-w-7xl min-w-0 flex-col gap-3 px-4 py-4 sm:px-[10%]">
  <div class="flex min-w-0 items-start gap-3">
    <img src="/images/user-circle-image.svg" alt="Profile Image" class="mt-0.5 h-6 w-6 shrink-0 rounded-full brightness-0 invert" />

    <div class="min-w-0 flex-1">
      <p class="truncate text-sm font-bold leading-5 text-emlavender-dark">
        <%= @gist.user_id %><span class="text-white">/</span><%= @gist.name %>
      </p>
      <p class="truncate text-xs font-bold leading-4 text-white"><%= DateFormat.get_relative_time(@gist.updated_at) %></p>
      <p class="truncate text-xs leading-4 text-white"><%= @gist.description %></p>
    </div>

    <div class="flex shrink-0 items-center gap-1 text-xs text-white">
      <img src="/images/comment.svg" alt="Comment Count" class="h-5 w-5 scale-y-[1.5625] brightness-0 invert" />
      <span>0</span>
      <img src="/images/bookmark-outline.svg" alt="Bookmark Count" class="ml-1 h-5 w-5 brightness-0 invert" />
      <span>0</span>
    </div>
  </div>

  <div class="flex w-full min-w-0">
    <textarea id={"syntax-numbers-#{@gist.id}"} class="syntax-numbers rounded-tl-md" readonly wrap="off" aria-hidden="true"></textarea>
    <div id={"highlight-#{@gist.id}"} class="syntax-area rounded-br-md rounded-tr-md" phx-hook="Highlight" data-name={@gist.name}>
      <pre class="m-0 min-w-max p-3"><code class="language-elixir"><%= get_preview_text(@gist) %></code></pre>
    </div>
  </div>
</div>
"""
end

defp get_preview_text(gist) when not is_nil(gist.markup_text) do
  lines =gist.markup_text |>String.split("\n")

  if length(lines) > 10 do
    (Enum.take(lines, 9) ++ ["..."]) |> Enum.join("\n")
  else
    gist.markup_text
  end
  end


  defp get_preview_text(_gist), do: ""
end
