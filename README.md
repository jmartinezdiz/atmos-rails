# Atmos

**Atmos** is a example Ruby on Rails application designed to manage and visualize hierarchical weather forecasts across different countries and their political divisions. It provides a robust platform for viewing temperature, rainfall, and wind data, supporting deep geographical hierarchies and full internationalization.

This repository is designed for educational purposes, allowing students to identify and implement improvements.

## Features

* **Geographical Hierarchy Management**. Handles complex hierarchical administrative structures (e.g., Country -> State -> City).
* **Comprehensive Weather Data**. Tracks and visualizes temperatures, rainfall and wind speed.
* **Internationalization**: Built-in support for English and Spanish.
* **Date-Based Navigation**: Default views focus on the current week, with navigation capabilities.

## Tech Stack

* **Language**: Ruby 4
* **Framework**: Ruby on Rails 8
* **Database**: SQLite3
* **Templating**: HAML
* **Server**: Puma

## Getting started

### 1. Clone the repository

```bash
git clone https://github.com/jmartinezdiz/atmos-rails.git
cd atmos
```

### 2. Setup

Run the setup script to install dependencies and prepare the database. This includes running migrations and seeding the database with initial random test data (USA and Spain with random weather data).

```bash
bin/setup
```

Alternatively, you can run:

```bash
bundle install
bin/rails db:setup
```

### 3. Run server

Start the development server:

```bash
bin/dev
```

*Or standard Rails server:*

```bash
bin/rails server
```

Access the application at: `http://localhost:3000`

## Testing

The project uses the standard Rails testing framework (`Minitest`).

Run the test suite:

```bash
bin/rails test
```
