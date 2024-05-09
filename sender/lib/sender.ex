defmodule Sender do
  def notify_all(emails) do
    # Creates an async stream of %Task{} under the
    # EmailTaskSupervisor which are not linked so that
    # when the below send_email/1 raises, it does not
    # crash the supervising process but instead captures
    # the %Task{} exit and returns it as a meaninful result
    Sender.EmailTaskSupervisor
    |> Task.Supervisor.async_stream_nolink(
      emails,
      &send_email/1
    )
    |> Enum.to_list()
  end

  def send_email("konnichiwa@world.com" = _email), do: :error

  def send_email(email) do
    Process.sleep(3000)
    IO.puts("Email to #{email} sent")
    {:ok, "email_sent"}
  end
end
