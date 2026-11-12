# Setup

## :one: LMS Assignment ID = 76

```json
{
  "id": 76,
  "cmid": 86,
  "name": "5.Storage"
}
```

## :two: Rubric Definition CMID = 72

- [ ] PWSH

```powershell
$body = @{
    wstoken            = $env:API_SYNC_TOKEN
    wsfunction         = 'core_grading_get_definitions'
    moodlewsrestformat = 'json'
    'cmids[0]'         = '75'
    areaname           = 'submissions'
}

Invoke-RestMethod `
    -Uri "https://$env:LMS_URL/webservice/rest/server.php" `
    -Method Post `
    -Body $body `
    -ContentType 'application/x-www-form-urlencoded' |
    ConvertTo-Json -Depth 100
```

- [ ] bash

```bash
curl -X POST "https://${LMS_URL}/webservice/rest/server.php" \
-d "wstoken=${API_SYNC_TOKEN}" \
-d "wsfunction=core_grading_get_definitions" \
-d "moodlewsrestformat=json" \
-d "cmids[0]=86" \
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
      "cmid": 86,
      "contextid": 796,
      "component": "mod_assign",
      "areaname": "submissions",
      "activemethod": "rubric",
      "definitions": [
        {
          "id": 75,
          "method": "rubric",
          "name": "5.Storage",
          "description": "5.Storage",
          "descriptionformat": 1,
          "status": 20,
          "copiedfromid": null,
          "timecreated": 1794506777,
          "usercreated": 3,
          "timemodified": 1794506804,
          "usermodified": 3,
          "timecopied": 0,
          "rubric": {
            "rubric_criteria": [
              {
                "id": 298,
                "sortorder": 1,
                "description": "README.md",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 777,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 778,
                    "score": 1,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 779,
                    "score": 2,
                    "definition": "🥇",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 299,
                "sortorder": 2,
                "description": "images",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 780,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 781,
                    "score": 1,
                    "definition": "✔️",
                    "definitionformat": 1
                  }
                ]
              },
              {
                "id": 300,
                "sortorder": 3,
                "description": "Appréciation",
                "descriptionformat": 1,
                "levels": [
                  {
                    "id": 782,
                    "score": 0,
                    "definition": "❌",
                    "definitionformat": 1
                  },
                  {
                    "id": 783,
                    "score": 1,
                    "definition": "🥉",
                    "definitionformat": 1
                  },
                  {
                    "id": 784,
                    "score": 2,
                    "definition": "🥈",
                    "definitionformat": 1
                  },
                  {
                    "id": 785,
                    "score": 3,
                    "definition": "🥇",
                    "definitionformat": 1
                  },
                  {
                    "id": 786,
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
