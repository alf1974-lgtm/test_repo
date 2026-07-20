# School API

A Rails 7 API-only application modelling a school with students, teachers, departments, courses, semesters, and class sessions.

## Setup

```bash
cd school_api
bundle install
rails db:create db:migrate db:seed
rails server
```

## Data Model

```
User (role: student | teacher)
  ├── has_many :enrollments          (as student)
  ├── has_many :class_sessions_as_student (through enrollments)
  └── has_many :class_sessions_as_teacher

Department
  └── has_many :courses

Course (belongs_to :department)
  └── has_many :class_sessions

Semester
  └── has_many :class_sessions

ClassSession (belongs_to :course, :semester, :teacher)
  └── has_many :enrollments
  └── has_many :students (through enrollments)

Enrollment (belongs_to :class_session, :student)
  └── grade  (A, A-, B+, B, B-, C+, C, C-, D+, D, D-, F, or nil)
```

## API Endpoints

All routes are namespaced under `/api/v1`.

### `GET /api/v1/students/:id`

Returns a student's profile.

**Example response:**
```json
{
  "id": 1,
  "first_name": "Alice",
  "last_name": "Johnson",
  "full_name": "Alice Johnson",
  "email": "alice.johnson@school.edu",
  "role": "student"
}
```

---

### `GET /api/v1/students/:id/courses`

Returns all class sessions the student is enrolled in, with course, semester, teacher, and grade details.

**Example response:**
```json
[
  {
    "enrollment_id": 1,
    "grade": "A",
    "class_session": {
      "id": 1,
      "room": "Humanities 101",
      "schedule": "MWF 09:00-09:50",
      "course": {
        "id": 1,
        "code": "ENG101",
        "name": "Composition I",
        "description": "Introduction to academic writing and rhetoric.",
        "department": {
          "id": 1,
          "name": "English"
        }
      },
      "semester": {
        "id": 1,
        "name": "Fall 2026",
        "start_date": "2026-08-24",
        "end_date": "2026-12-18"
      },
      "teacher": {
        "id": 5,
        "full_name": "Margaret Atwood",
        "email": "m.atwood@school.edu"
      }
    }
  }
]
```

## Seed Data

Running `rails db:seed` creates:

| Resource       | Count |
|----------------|-------|
| Departments    | 4 (English, Mathematics, Science, History) |
| Courses        | 8 (ENG101, ENG201, MTH101, MTH201, SCI101, SCI201, HIS101, HIS201) |
| Semesters      | 2 (Fall 2026, Spring 2027) |
| Teachers       | 4 |
| Students       | 8 |
| Class Sessions | 10 |
| Enrollments    | 24 |
