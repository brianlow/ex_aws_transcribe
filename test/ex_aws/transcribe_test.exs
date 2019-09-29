defmodule ExAws.TranscribeTest do
  use ExUnit.Case, async: true

  alias ExAws.Transcribe

  test "start_transcription_job/5" do
    job_name = "Job1"
    url = "https://example.com"
    format = "mp3"
    language = "en-US"
    opts = [settings: [show_speaker_labels: true, max_speaker_labels: 3]]

    res = Transcribe.start_transcription_job(job_name, url, format, language, opts)

    assert ignore_parser(res) ===
             %ExAws.Operation.JSON{
               before_request: nil,
               data: %{
                 "TranscriptionJobName" => "Job1",
                 "LanguageCode" => "en-US",
                 "Media" => %{"MediaFileUri" => "https://example.com"},
                 "MediaFormat" => "mp3",
                 "Settings" => %{"MaxSpeakerLabels" => 3, "ShowSpeakerLabels" => true},
                 "Version" => "2017-10-26"
               },
               headers: [
                 {"X-Amz-Target", "Transcribe.StartTranscriptionJob"},
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

  test "start_transcription_job/5 with no options" do
    job_name = "Job1"
    url = "https://example.com"
    format = "mp3"
    language = "en-US"

    res = Transcribe.start_transcription_job(job_name, url, format, language)

    assert ignore_parser(res) ===
             %ExAws.Operation.JSON{
               before_request: nil,
               data: %{
                 "TranscriptionJobName" => "Job1",
                 "LanguageCode" => "en-US",
                 "Media" => %{"MediaFileUri" => "https://example.com"},
                 "MediaFormat" => "mp3",
                 "Version" => "2017-10-26"
               },
               headers: [
                 {"X-Amz-Target", "Transcribe.StartTranscriptionJob"},
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
