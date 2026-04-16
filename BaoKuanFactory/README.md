# BaoKuanFactory

SwiftUI MVP for a short-video copywriting app.

## Current status
- SwiftUI app skeleton completed
- Home generation flow refactored for async loading and error handling
- Generator service now supports mock/remote switching
- API layer scaffold added for future backend integration
- History and copy actions included

## Architecture updates
- `AppEnvironment`: controls whether the app uses mock or remote generation
- `APIClient`: centralized network request entry point
- `MockScriptGeneratorService` / `RemoteScriptGeneratorService`: separate demo and production logic
- `GenerateScriptRequest` / `GenerateScriptResponse`: request-response DTO layer

## Next steps
1. Fill `AppEnvironment.current.apiBaseURL` with your backend URL
2. Switch `usesMockGenerator` to `false`
3. Add auth, retry strategy, and richer network error handling
4. Replace local membership placeholder with StoreKit 2
5. Polish UI and prepare production release
