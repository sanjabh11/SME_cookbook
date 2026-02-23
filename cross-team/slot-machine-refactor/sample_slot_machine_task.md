TASK: Rename all `id` class variables to `uuid`
SCOPE: `src/utils/` and `src/models/` directories only
RULES: Do not touch database migration definitions. Keep function signatures identical where possible.
SUCCESS: `npm run lint` and `npm test` both pass.
