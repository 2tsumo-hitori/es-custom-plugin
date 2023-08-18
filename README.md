# es-custom-plugin

# 자바카페 플러그인 7.0.0 -> 7.9.1로 버전 수정 후 빌드

## 엘라스틱 서치 자동완성
- 인덱스에 색인할 때 nori_analyzer 사용
- 자동완성은 ngram, suggest는 지양하고 match_phrase_prefix가 좋은듯함
  ### 근거
  1. 검색 대상에 따라 다르겠지만 명사 위주로 검색하는 경우 多
  2. nori_analyzer가 명사 단위로 색인해서 저장함
```
GET autocomplete_test_1/_search
{
  "query": {
    "match_phrase_prefix": {
      "word": "폰"
    }
  }
}
```

``` {
  "took" : 0,
  "timed_out" : false,
  "_shards" : {
    "total" : 1,
    "successful" : 1,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : {
      "value" : 5,
      "relation" : "eq"
    },
    "max_score" : 1.1651303,
    "hits" : [
      {
        "_index" : "autocomplete_test_1",
        "_type" : "_doc",
        "_id" : "9",
        "_score" : 1.1651303,
        "_source" : {
          "word" : "스마트폰 추천"
        }
      },
      {
        "_index" : "autocomplete_test_1",
        "_type" : "_doc",
        "_id" : "10",
        "_score" : 1.1651303,
        "_source" : {
          "word" : "폰게임 환불"
        }
      },
      {
        "_index" : "autocomplete_test_1",
        "_type" : "_doc",
        "_id" : "14",
        "_score" : 1.1651303,
        "_source" : {
          "word" : "폰게임 순위"
        }
      },
      {
        "_index" : "autocomplete_test_1",
        "_type" : "_doc",
        "_id" : "15",
        "_score" : 1.1651303,
        "_source" : {
          "word" : "폰게임 추천"
        }
      },
      {
        "_index" : "autocomplete_test_1",
        "_type" : "_doc",
        "_id" : "16",
        "_score" : 1.0311216,
        "_source" : {
          "word" : "스마트폰게임 추천"
        }
      }
    ]
  }
}

```
