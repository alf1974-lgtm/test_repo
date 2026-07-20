# db/seeds.rb
# Run with: rails db:seed
# Clears and repopulates all tables with sample school data.

puts "Seeding database..."

# ── Clean slate ──────────────────────────────────────────────────────────────
[Enrollment, ClassSession, Course, Department, Semester, User].each(&:destroy_all)

# ── Departments ───────────────────────────────────────────────────────────────
departments = Department.create!([
  { name: "English" },
  { name: "Mathematics" },
  { name: "Science" },
  { name: "History" }
])

english = departments.find { |d| d.name == "English" }
math    = departments.find { |d| d.name == "Mathematics" }
science = departments.find { |d| d.name == "Science" }
history = departments.find { |d| d.name == "History" }

puts "  Created #{Department.count} departments"

# ── Courses ───────────────────────────────────────────────────────────────────
courses = Course.create!([
  { department: english,  code: "ENG101", name: "Composition I",
    description: "Introduction to academic writing and rhetoric." },
  { department: english,  code: "ENG201", name: "American Literature",
    description: "Survey of American literature from colonial times to the present." },
  { department: math,     code: "MTH101", name: "Pre-Calculus",
    description: "Functions, trigonometry, and analytic geometry." },
  { department: math,     code: "MTH201", name: "Calculus I",
    description: "Limits, derivatives, and an introduction to integration." },
  { department: science,  code: "SCI101", name: "Biology I",
    description: "Cell biology, genetics, and evolution." },
  { department: science,  code: "SCI201", name: "Chemistry I",
    description: "Atomic structure, bonding, and stoichiometry." },
  { department: history,  code: "HIS101", name: "World History",
    description: "Major civilizations and events from antiquity to 1500." },
  { department: history,  code: "HIS201", name: "U.S. History",
    description: "American history from colonization through Reconstruction." }
])

puts "  Created #{Course.count} courses"

# ── Semesters ─────────────────────────────────────────────────────────────────
fall2026   = Semester.create!(name: "Fall 2026",   start_date: "2026-08-24", end_date: "2026-12-18")
spring2027 = Semester.create!(name: "Spring 2027", start_date: "2027-01-11", end_date: "2027-05-07")

puts "  Created #{Semester.count} semesters"

# ── Teachers ──────────────────────────────────────────────────────────────────
teachers = User.create!([
  { first_name: "Margaret", last_name: "Atwood",   email: "m.atwood@school.edu",   role: "teacher" },
  { first_name: "Richard",  last_name: "Feynman",  email: "r.feynman@school.edu",  role: "teacher" },
  { first_name: "Marie",    last_name: "Curie",    email: "m.curie@school.edu",    role: "teacher" },
  { first_name: "Howard",   last_name: "Zinn",     email: "h.zinn@school.edu",     role: "teacher" }
])

atwood  = teachers.find { |t| t.last_name == "Atwood" }
feynman = teachers.find { |t| t.last_name == "Feynman" }
curie   = teachers.find { |t| t.last_name == "Curie" }
zinn    = teachers.find { |t| t.last_name == "Zinn" }

puts "  Created #{User.teachers.count} teachers"

# ── Students ──────────────────────────────────────────────────────────────────
students = User.create!([
  { first_name: "Alice",   last_name: "Johnson",  email: "alice.johnson@school.edu",  role: "student" },
  { first_name: "Bob",     last_name: "Smith",    email: "bob.smith@school.edu",      role: "student" },
  { first_name: "Carol",   last_name: "Williams", email: "carol.williams@school.edu", role: "student" },
  { first_name: "David",   last_name: "Brown",    email: "david.brown@school.edu",    role: "student" },
  { first_name: "Eva",     last_name: "Davis",    email: "eva.davis@school.edu",      role: "student" },
  { first_name: "Frank",   last_name: "Miller",   email: "frank.miller@school.edu",   role: "student" },
  { first_name: "Grace",   last_name: "Wilson",   email: "grace.wilson@school.edu",   role: "student" },
  { first_name: "Henry",   last_name: "Moore",    email: "henry.moore@school.edu",    role: "student" }
])

alice  = students.find { |s| s.first_name == "Alice" }
bob    = students.find { |s| s.first_name == "Bob" }
carol  = students.find { |s| s.first_name == "Carol" }
david  = students.find { |s| s.first_name == "David" }
eva    = students.find { |s| s.first_name == "Eva" }
frank  = students.find { |s| s.first_name == "Frank" }
grace  = students.find { |s| s.first_name == "Grace" }
henry  = students.find { |s| s.first_name == "Henry" }

puts "  Created #{User.students.count} students"

# ── Class Sessions ────────────────────────────────────────────────────────────
# Helper to look up a course by code
def course(code) = Course.find_by!(code: code)

class_sessions = ClassSession.create!([
  # Fall 2026
  { course: course("ENG101"), semester: fall2026,   teacher: atwood,  room: "Humanities 101", schedule: "MWF 09:00-09:50" },
  { course: course("ENG201"), semester: fall2026,   teacher: atwood,  room: "Humanities 102", schedule: "TTh 10:30-11:45" },
  { course: course("MTH101"), semester: fall2026,   teacher: feynman, room: "Science 201",    schedule: "MWF 11:00-11:50" },
  { course: course("MTH201"), semester: fall2026,   teacher: feynman, room: "Science 202",    schedule: "TTh 13:00-14:15" },
  { course: course("SCI101"), semester: fall2026,   teacher: curie,   room: "Lab 301",        schedule: "MWF 14:00-14:50" },
  { course: course("HIS101"), semester: fall2026,   teacher: zinn,    room: "Social 401",     schedule: "TTh 15:30-16:45" },
  # Spring 2027
  { course: course("ENG101"), semester: spring2027, teacher: atwood,  room: "Humanities 101", schedule: "MWF 09:00-09:50" },
  { course: course("SCI201"), semester: spring2027, teacher: curie,   room: "Lab 302",        schedule: "MWF 10:00-10:50" },
  { course: course("MTH201"), semester: spring2027, teacher: feynman, room: "Science 202",    schedule: "TTh 11:00-12:15" },
  { course: course("HIS201"), semester: spring2027, teacher: zinn,    room: "Social 402",     schedule: "TTh 13:30-14:45" }
])

# Convenience lookup
def cs(idx) = ClassSession.all.order(:id)[idx]

puts "  Created #{ClassSession.count} class sessions"

# ── Enrollments ───────────────────────────────────────────────────────────────
# Fall 2026 sessions (indices 0-5)
fall_eng101, fall_eng201, fall_mth101, fall_mth201, fall_sci101, fall_his101 =
  ClassSession.joins(:semester).where(semesters: { name: "Fall 2026" }).order(:id).to_a

# Spring 2027 sessions (indices 6-9)
spr_eng101, spr_sci201, spr_mth201, spr_his201 =
  ClassSession.joins(:semester).where(semesters: { name: "Spring 2027" }).order(:id).to_a

Enrollment.create!([
  # Alice: ENG101 (Fall), MTH101 (Fall), SCI101 (Fall), MTH201 (Spring)
  { class_session: fall_eng101, student: alice, grade: "A"  },
  { class_session: fall_mth101, student: alice, grade: "B+" },
  { class_session: fall_sci101, student: alice, grade: "A-" },
  { class_session: spr_mth201,  student: alice, grade: nil  },

  # Bob: ENG101 (Fall), HIS101 (Fall), ENG101 (Spring)
  { class_session: fall_eng101, student: bob, grade: "B"  },
  { class_session: fall_his101, student: bob, grade: "C+" },
  { class_session: spr_eng101,  student: bob, grade: nil  },

  # Carol: MTH201 (Fall), SCI101 (Fall), SCI201 (Spring), HIS201 (Spring)
  { class_session: fall_mth201, student: carol, grade: "A"  },
  { class_session: fall_sci101, student: carol, grade: "B"  },
  { class_session: spr_sci201,  student: carol, grade: nil  },
  { class_session: spr_his201,  student: carol, grade: nil  },

  # David: ENG201 (Fall), HIS101 (Fall), HIS201 (Spring)
  { class_session: fall_eng201, student: david, grade: "B-" },
  { class_session: fall_his101, student: david, grade: "A-" },
  { class_session: spr_his201,  student: david, grade: nil  },

  # Eva: MTH101 (Fall), MTH201 (Fall), SCI201 (Spring)
  { class_session: fall_mth101, student: eva, grade: "A"  },
  { class_session: fall_mth201, student: eva, grade: "A-" },
  { class_session: spr_sci201,  student: eva, grade: nil  },

  # Frank: SCI101 (Fall), ENG101 (Spring), MTH201 (Spring)
  { class_session: fall_sci101, student: frank, grade: "C"  },
  { class_session: spr_eng101,  student: frank, grade: nil  },
  { class_session: spr_mth201,  student: frank, grade: nil  },

  # Grace: ENG101 (Fall), ENG201 (Fall), HIS201 (Spring)
  { class_session: fall_eng101, student: grace, grade: "A-" },
  { class_session: fall_eng201, student: grace, grade: "B+" },
  { class_session: spr_his201,  student: grace, grade: nil  },

  # Henry: HIS101 (Fall), MTH101 (Fall), SCI201 (Spring)
  { class_session: fall_his101, student: henry, grade: "B"  },
  { class_session: fall_mth101, student: henry, grade: "C+" },
  { class_session: spr_sci201,  student: henry, grade: nil  }
])

puts "  Created #{Enrollment.count} enrollments"
puts ""
puts "Done! Seed summary:"
puts "  #{Department.count} departments"
puts "  #{Course.count} courses"
puts "  #{Semester.count} semesters"
puts "  #{User.teachers.count} teachers"
puts "  #{User.students.count} students"
puts "  #{ClassSession.count} class sessions"
puts "  #{Enrollment.count} enrollments"
puts ""
puts "Example API calls:"
puts "  GET /api/v1/students/#{alice.id}          → Alice's profile"
puts "  GET /api/v1/students/#{alice.id}/courses   → Alice's enrolled courses"
