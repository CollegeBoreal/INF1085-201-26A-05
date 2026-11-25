# Setup

## :one: LMS Assignment ID = 82

```json
{
  "id": 82,
  "cmid": 92,
  "name": "6.Projects"
}
```

## :two: Rubric Definition CMID = 86

- [ ] bash

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=92" \
-d "areaname=submissions" | jq .
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  2397    0  2261  100   136   3849    231 --:--:-- --:--:-- --:--:--  4076
```
<details><summary>📑</summary>

```json
{
  "areas": [
    {
      "cmid": 92,
      "contextid": 814,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 81,
          "method": "rubric",
          "name": "6.Projects",
          "description": "6.Projects",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1795555144,
          "usercreated": 3,
          "timemodified": 1795555173,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 316,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 837,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 838,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 839,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 317,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 840,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 841,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 318,
                "sortorder": 3,
                "description": "Appréciation",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 842,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 843,
                    "score": 1,
                    "definition": "🥉",
                    "definitionformat": 1
                  },
                  {
                    "id": 844,
                    "score": 2,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 845,
                    "score": 3,
                    "definition": "🥇",
                    "definitionformat": 1
                  },
                  {
                    "id": 846,
                    "score": 4,
                    "definition": "🏆",
                    "definitionformat": 1
                  }
                ]
              }
            ]
          }
        }
      ]
    }
  ],
  "warnings": []
}

```

</details>
