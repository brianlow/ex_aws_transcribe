defmodule ExAws.TranscribeTest do
  use ExUnit.Case, async: true

  alias ExAws.Transcribe

  test "start_transcription_job/5" do
    res = Transcribe.get_transcription_job("Job1")

    assert ignore_parser(res) ===
      %ExAws.Operation.JSON{
        before_request: nil,
        data: %{"TranscriptionJobName" => "Job1", "Version" => "2017-10-26"},
        headers: [
          {"X-Amz-Target", "Transcribe.GetTranscriptionJob"},
          {"content-type", "application/x-amz-json-1.1"}
        ],
        http_method: :post,
        params: %{},
        parser: nil,
        path: "/",
        service: :transcribe,
        stream_builder: nil
      }
  end

  test "list_transcription_job/1" do
    res = ExAws.Transcribe.list_transcription_jobs()

    assert ignore_parser(res) ===
      %ExAws.Operation.JSON{
        before_request: nil,
        data: %{"Version" => "2017-10-26"},
        headers: [
          {"X-Amz-Target", "Transcribe.ListTranscriptionJobs"},
          {"content-type", "application/x-amz-json-1.1"}
        ],
        http_method: :post,
        params: %{},
        parser: nil,
        path: "/",
        service: :transcribe,
        stream_builder: nil
      }
  end

  test "get_transcription_job/1" do
    res = ExAws.Transcribe.get_transcription_job("Job1")
    assert ignore_parser(res) ===
      %ExAws.Operation.JSON{
        before_request: nil,
        data: %{"TranscriptionJobName" => "Job1", "Version" => "2017-10-26"},
        headers: [
          {"X-Amz-Target", "Transcribe.GetTranscriptionJob"},
          {"content-type", "application/x-amz-json-1.1"}
        ],
        http_method: :post,
        params: %{},
        parser: nil,
        path: "/",
        service: :transcribe,
        stream_builder: nil
      }
  end

  defp ignore_parser(res) do
    Map.put(res, :parser, nil)
  end
end
