# Appfood API

Express.js + Sequelize MySQL API for Appfood.

## Setup

1. Copy `.env.example` or create `.env` with values:

```
DB_NAME=appfood
DB_USER=root
DB_PASSWORD=password
DB_HOST=localhost
DB_PORT=3306
NODE_ENV=development
PORT=3000
JWT_SECRET=your_jwt_secret
```

2. Install dependencies

```bash
npm install
```

3. Run the server

```bash
npm start
```

## API Endpoints

Base: `http://localhost:3000`

Auth:

- `POST /api/auth/register`
- `POST /api/auth/login`

Users:

- `GET /api/users`
- `POST /api/users` (admin)
- `GET /api/users/:id`
- `PUT /api/users/:id` (protected)
- `DELETE /api/users/:id` (protected)

Menu:

- `GET /api/menu`
- `POST /api/menu` (protected)
- `GET /api/menu/:id`
- `PUT /api/menu/:id` (protected)
- `DELETE /api/menu/:id` (protected)

## Notes

- Protect routes by passing `Authorization: Bearer <token>` header returned from login.
- Consider running migrations and seeds with `sequelize-cli`.
 - To create an admin user for first-time setup, either use the database directly or create a seed.
 - Run migrations (after creating `config/config.json`):

```bash
npx sequelize-cli db:migrate
npx sequelize-cli db:seed:all
```
