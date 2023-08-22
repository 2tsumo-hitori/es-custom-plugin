# my_movie_search 인덱스 구성

# 1. movieNm 데이터 색인, 검색할 때 default_kor_analyzer (analysis-nori)
# 2. 오타 교정(suggest)할 때 fix_analyzer (analysis-icu)
# 3. 한영/영한 교정할 때 eng2kor_search_analyzer, kor2eng_search_analyzer (javacafe-analyzer)
# 4. 자동완성은 jamo_index_analyzer, jamo_search_analyzer (javacafe-analyzer)
# 5. 초성검색은 chosung_index_analyzer, chosung_search_analyzer (javacafe-analyzer)

# 6. edgeNgram side를 활용해서 초성 부분검색 구현

PUT my_movie_search
{
  "settings": {
    "number_of_shards": 5,
    "index.max_ngram_diff": 50,
    "analysis": {
      "filter": {
        "javacafe_jamo_filter": {
          "type": "javacafe_jamo"
        },
        "javacafe_chosung_filter": {
          "type": "javacafe_chosung"
        },
        "ngram3_front_filter": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 50,
          "side": "front"
        },
        "ngram3_back_filter": {
          "type": "edge_ngram",
          "min_gram": 2,
          "max_gram": 50,
          "side": "back"
        },
        "ngram4_filter": {
          "type": "ngram",
          "min_gram": 4,
          "max_gram": 50
        }
      },
      "char_filter": {
        "nfd_normalizer" : {
          "mode" : "decompose",
          "name" : "nfc",
          "type" : "icu_normalizer"
        },
        "white_remove_char_filter": {
          "type": "pattern_replace",
          "pattern": "\\s+",
          "replacement": ""
        },
        "special_character_filter": {
          "pattern": "[^\\p{L}\\p{Nd}\\p{Blank}]",
          "type": "pattern_replace",
          "replacement": ""
        }
      },
      "tokenizer" : {
        "korean_nori_tokenizer" : {
          "type" : "nori_tokenizer",
          "decompound_mode" : "mixed"
        }
      },
      "analyzer": {
        "fix_analyzer": {
          "char_filter": [
            "nfd_normalizer"
          ],
          "tokenizer": "korean_nori_tokenizer"
        },
        "default_kor_analyzer": {
          "filter": [
            "lowercase"
          ],
          "tokenizer": "korean_nori_tokenizer"
        },
        "kor2eng_search_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "javacafe_kor2eng"
          ]
        },
        "eng2kor_search_analyzer": {
          "type": "custom",
          "tokenizer": "standard",
          "filter": [
            "trim",
            "lowercase",
            "javacafe_eng2kor"
          ]
        },
        "chosung_index_front_analyzer": {
          "type": "custom",
          "char_filter": [
            "special_character_filter",
            "white_remove_char_filter"
          ],
          "tokenizer": "keyword",
          "filter": [
            "javacafe_chosung_filter",
            "lowercase",
            "ngram3_front_filter"
          ]
        },
        "chosung_index_back_analyzer": {
          "type": "custom",
          "char_filter": [
            "special_character_filter",
            "white_remove_char_filter"
          ],
          "tokenizer": "keyword",
          "filter": [
            "javacafe_chosung_filter",
            "lowercase",
            "ngram3_back_filter"
          ]
        },
        "chosung_search_analyzer": {
          "type": "custom",
          "char_filter": [
            "white_remove_char_filter",
            "special_character_filter"
          ],
          "tokenizer": "keyword",
          "filter": [
            "lowercase"
          ]
        },
        "jamo_index_analyzer": {
          "type": "custom",
          "char_filter": [
            "white_remove_char_filter",
            "special_character_filter"
          ],
          "tokenizer": "keyword",
          "filter": [
            "javacafe_jamo_filter",
            "lowercase",
            "ngram3_front_filter"
          ]
        },
        "jamo_search_analyzer": {
          "type": "custom",
          "char_filter": [
            "special_character_filter"
          ],
          "tokenizer": "standard",
          "filter": [
            "javacafe_jamo_filter",
            "lowercase"
          ]
        }
      }
    }
  },
  "mappings": {
    "properties": {
      "movieCd": {
        "type": "keyword"
      },
      "movieNm": {
        "type": "keyword",
        "copy_to": ["movieNm_text", "movieNm_chosung_front", "movieNm_chosung_back","movieNm_eng2kor", "movieNm_kor2eng", "movieNm_ac"]
      },
      "movieNm_text": {
        "type": "text",
        "analyzer": "default_kor_analyzer",
        "fields": {
          "fix": {
            "type": "text",
            "analyzer": "fix_analyzer"
          }
        }
      },
      "movieNm_chosung_front": {
        "type": "text",
        "analyzer": "chosung_index_front_analyzer",
        "search_analyzer": "chosung_search_analyzer"
      },
      "movieNm_chosung_back": {
        "type": "text",
        "analyzer": "chosung_index_back_analyzer",
        "search_analyzer": "chosung_search_analyzer"
      },
      "movieNm_eng2kor": {
        "type": "text",
        "analyzer": "standard", 
        "search_analyzer": "eng2kor_search_analyzer"
      },
      "movieNm_kor2eng": {
        "type": "text",
        "analyzer": "standard", 
        "search_analyzer": "kor2eng_search_analyzer"
      },
      "movieNm_ac": {
        "type": "text",
        "analyzer": "jamo_index_analyzer", 
        "search_analyzer": "jamo_search_analyzer"
      },
      "movieNmEn": {
        "type":"text",
        "analyzer":"standard"
      },
      "prdtYear": {
        "type": "integer"
      },
      "openDt": {
        "type": "integer"
      },
      "typeNm": {
        "type": "keyword"
      },
      "prdtStatNm": {
        "type": "keyword"
      },
      "nationAlt": {
        "type": "keyword"
      },
      "genreAlt": {
        "type":"keyword"
      },
      "repNationNm": {
        "type":"keyword"
      },
      "repGenreNm": {
        "type":"keyword"
      },
      "companies": {
        "properties": {
          "companyCd": {
            "type": "keyword"
          },
          "companyNm": {
            "type": "keyword"
          }
        }
      },
      "directors": {
        "properties": {
          "peopleNm": {
            "type": "keyword"
          }
        }
      }
    }
  }
}
