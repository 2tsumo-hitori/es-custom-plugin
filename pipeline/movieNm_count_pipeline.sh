# movieNm의 길이를 필드로 추가해주는 파이프라인

PUT _ingest/pipeline/movieNm_count_pipeline
{
  "description": "movieNm count",
  "processors": [
    {
      "set": {
        "field": "movieNmCount",
        "value": "{{_source.movieNm}}"
      }
    },
    {
      "script": {
        "source": "ctx.movieNmCount = ctx.movieNm.length()",
        "lang": "painless"
      }
    }
  ]
}