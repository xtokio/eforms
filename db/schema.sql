BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "access" (
	"id"	INTEGER NOT NULL,
	"company"	TEXT NOT NULL DEFAULT '',
	"area"	TEXT NOT NULL DEFAULT '',
	"department"	TEXT NOT NULL DEFAULT '',
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "attachments" (
	"id"	INTEGER NOT NULL,
	"attachment"	TEXT NOT NULL DEFAULT '',
	"filename"	TEXT NOT NULL DEFAULT '',
	"extension"	TEXT NOT NULL DEFAULT '',
	"user_id"	INTEGER NOT NULL,
	"form_id"	INTEGER NOT NULL,
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "comments" (
	"id"	INTEGER NOT NULL,
	"comment"	TEXT NOT NULL DEFAULT '',
	"user_id"	INTEGER NOT NULL,
	"form_id"	INTEGER NOT NULL,
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	INTEGER NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "forms" (
	"id"	INTEGER NOT NULL,
	"form"	TEXT NOT NULL DEFAULT '',
	"template"	TEXT NOT NULL DEFAULT '',
	"data"	TEXT NOT NULL DEFAULT '',
	"assigned_to"	TEXT NOT NULL DEFAULT '',
	"active"	INTEGER NOT NULL DEFAULT 1,
	"type_id"	INTEGER NOT NULL,
	"status_id"	INTEGER NOT NULL,
	"user_id"	INTEGER NOT NULL,
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "types" (
	"id"	INTEGER NOT NULL,
	"type"	TEXT NOT NULL DEFAULT '',
	"description"	TEXT NOT NULL DEFAULT '',
	"template"	TEXT NOT NULL DEFAULT '',
	"addons"	TEXT NOT NULL DEFAULT '',
	"active"	INTEGER NOT NULL DEFAULT 1,
	"user_id"	INTEGER NOT NULL,
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "status" (
	"id"	INTEGER NOT NULL,
	"status"	TEXT NOT NULL DEFAULT '',
	"description"	TEXT NOT NULL DEFAULT '',
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "roles" (
	"id"	INTEGER NOT NULL,
	"role"	TEXT DEFAULT '',
	"description"	TEXT NOT NULL DEFAULT '',
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "users" (
	"id"	INTEGER NOT NULL,
	"user"	TEXT NOT NULL DEFAULT '',
	"password"	TEXT NOT NULL DEFAULT '',
	"name"	TEXT DEFAULT '',
	"photo"	TEXT NOT NULL DEFAULT '',
	"active"	INTEGER NOT NULL DEFAULT 1,
	"role_id"	INTEGER NOT NULL,
	"access_id"	INTEGER NOT NULL,
	"created_at"	TEXT NOT NULL DEFAULT '',
	"updated_at"	TEXT NOT NULL DEFAULT '',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE VIEW IF NOT EXISTS "view_users"
AS
SELECT a.id,a.user,a.password,a.name,a.photo,a.active,a.role_id,b.role,b.description,a.access_id,c.department,c.area,c.company,a.created_at,a.updated_at
FROM users a, roles b, access c
WHERE a.role_id = b.id and a.access_id = c.id;

CREATE VIEW IF NOT EXISTS "view_forms"
AS
SELECT f.id,f.form,f.template,f.data,f.assigned_to,f.active,f.type_id,t.type,f.status_id,s.status,s.description as status_description,f.user_id,u.name,u.user,f.created_at,f.updated_at
FROM forms f,types t,status s,users u
WHERE f.type_id = t.id and f.status_id = s.id and f.user_id = u.id;

CREATE VIEW IF NOT EXISTS "view_comments"
AS
SELECT c.id,c.comment,c.user_id,u.name,u.user,c.form_id,f.form,c.created_at,c.updated_at
FROM comments c,forms f,users u
WHERE c.user_id = u.id and c.form_id = f.id;

COMMIT;
