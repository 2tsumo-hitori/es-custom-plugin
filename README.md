# es-custom-plugin

# 자바카페 플러그인 7.0.0 -> 7.9.1로 버전 수정 후 빌드

# 초성 부분 검색 기능구현
  - 색인 시 movieNm의 길이를 필드로 추가해주는 파이프라인
  - 초성을 색인할 때 edgeNgram의 side를 활용

## Query Dsl
```
# 초성검색
POST my_movie_search/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "bool": {
            "should": [
              {
                "match": {
                  "movieNm_chosung_front": "ㅎㅂㄹㄱ"
                }
              },
              {
                "match": {
                  "movieNm_chosung_back": "ㅎㅂㄹㄱ"
                }
              }
            ]
          }
        }
      ],
      "should": [
        {
          "range": {
            "movieNmCount": {
              "lte": 4
            }
          }
        }
      ]
    }
  },
  "sort": [
    {
      "movieNmCount": {
        "order": "asc"
      }
    }
  ],
  "_source": "movieNm"
}
```
## Response
```
"hits" : [
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "uj3JqmkBjjM-ebDb_YqV",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기"
        },
        "sort" : [
          4
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "zT3JqmkBjjM-ebDb-VmP",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기"
        },
        "sort" : [
          4
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "aD3JqmkBjjM-ebDb9CjG",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기"
        },
        "sort" : [
          4
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "Kj3KqmkBjjM-ebDbCO5q",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기 가족"
        },
        "sort" : [
          7
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "_T3JqmkBjjM-ebDb9CTG",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기의 습격"
        },
        "sort" : [
          8
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "cj3JqmkBjjM-ebDb_XqU",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기들의 밤"
        },
        "sort" : [
          8
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "PD3KqmkBjjM-ebDbBdUP",
        "_score" : null,
        "_source" : {
          "movieNm" : "해바라기야이제그만잠들렴"
        },
        "sort" : [
          12
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "XD3KqmkBjjM-ebDbCOpq",
        "_score" : null,
        "_source" : {
          "movieNm" : "밤을 기다리는 해바라기"
        },
        "sort" : [
          12
        ]
      },
      {
        "_index" : "my_movie_search",
        "_type" : "_doc",
        "_id" : "bj3JqmkBjjM-ebDb9DfI",
        "_score" : null,
        "_source" : {
          "movieNm" : "명탐정 코난 : 화염의 해바라기"
        },
        "sort" : [
          17
        ]
      }
    ]
```
