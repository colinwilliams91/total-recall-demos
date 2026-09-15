#!/bin/sh
# Sourced by the tapes (hidden off-camera) after the daemon has created the DB.
# Seeds one known multiple-choice question scoped to this repo + branch so the
# quiz flow can be recorded without an AI provider. Schema mirrors
# internal/cache/store.go in the main repo — update on schema changes.
set -e
REPO="$(git rev-parse --show-toplevel)"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"
DB="$TR_HOME/memory.db"
sqlite3 "$DB" "
INSERT INTO questions (question_type, status, question, repo, branch)
VALUES ('multiple_choice', 'queued', 'What does the SRP in \"SOLID\" stand for?', '$REPO', '$BRANCH');
INSERT INTO choices (question_id, position, text, is_correct)
VALUES
  ((SELECT max(id) FROM questions), 0, 'Single Responsibility Principle', 1),
  ((SELECT max(id) FROM questions), 1, 'Sequential Retrieval Pattern',     0),
  ((SELECT max(id) FROM questions), 2, 'Safe Refactoring Protocol',        0),
  ((SELECT max(id) FROM questions), 3, 'Stable Release Policy',            0);
INSERT INTO question_events (question_id, event_type, actor)
VALUES ((SELECT max(id) FROM questions), 'queued', 'system');
"
