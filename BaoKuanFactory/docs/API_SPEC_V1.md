# BaoKuanFactory API Spec v1

## Overview

This document defines the first version of the content generation API for BaoKuanFactory iOS.

## Goal

Convert a user topic + style + duration into a structured short-video copywriting result.

## Endpoint

- **Method**: `POST`
- **Path**: `/generate-script`
- **Content-Type**: `application/json`

## Request Body

```json
{
  "topic": "老板创业",
  "style": "boss",
  "duration": "thirty"
}
```

### Fields

- `topic`: string, required, user input topic
- `style`: string, required, one of:
  - `emotion`
  - `motivation`
  - `talking`
  - `women`
  - `boss`
  - `sales`
  - `workplace`
  - `anime`
- `duration`: string, required, one of:
  - `fifteen`
  - `thirty`
  - `sixty`

## Success Response

**HTTP 200**

```json
{
  "titles": [
    "关于老板创业，这条内容建议你直接发",
    "老板创业，一个更容易起流量的表达方式",
    "不会写老板创业视频？这版可以直接用"
  ],
  "script": "完整视频文案内容...",
  "storyboards": [
    "0-3秒：强钩子开头",
    "3-10秒：抛出冲突",
    "10-20秒：展开观点",
    "20-30秒：结尾收束"
  ],
  "coverTexts": [
    "这条内容可以直接发",
    "真正拉流量的是表达方式"
  ],
  "tags": ["#短视频", "#文案", "#老板创业"]
}
```

## Error Response

### Validation Error
**HTTP 400**

```json
{
  "error": {
    "code": "INVALID_REQUEST",
    "message": "topic is required"
  }
}
```

### Unauthorized
**HTTP 401**

```json
{
  "error": {
    "code": "UNAUTHORIZED",
    "message": "Invalid token"
  }
}
```

### Rate Limited
**HTTP 429**

```json
{
  "error": {
    "code": "RATE_LIMITED",
    "message": "Too many requests"
  }
}
```

### Server Error
**HTTP 500**

```json
{
  "error": {
    "code": "INTERNAL_ERROR",
    "message": "Failed to generate content"
  }
}
```

## Auth Recommendation

Recommended production approach:

- iOS client calls your backend
- backend verifies user / subscription / quota
- backend calls LLM provider
- backend returns normalized response

Do not place raw model provider secrets inside the iOS app.

## Future Extensions

Reserved optional fields for v2:

- `tone`
- `platform`
- `audience`
- `language`
- `version`
- `requestId`
- `remainingQuota`
- `isPremium`

## iOS Mapping

Current iOS files already aligned with this spec:

- `Models/GenerateScriptRequest.swift`
- `Models/GenerateScriptResponse.swift`
- `Services/APIClient.swift`
- `Services/ScriptGeneratorService.swift`

## Backend Checklist

1. Accept POST `/generate-script`
2. Validate `topic`, `style`, `duration`
3. Generate structured copywriting output
4. Return stable JSON schema
5. Add auth + quota checks before production launch
