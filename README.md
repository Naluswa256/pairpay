# Easy-Consult README

Welcome to Easy-Consult! This comprehensive Flutter application allows clients to book appointments with lawyers seamlessly. Below, you'll find detailed documentation covering the architecture, features, backend integration, and future roadmap.

## Table of Contents
1. [Preview](#preview)
2. [Architecture](#architecture)
3. [Features](#features)
4. [Backend Integration](#backend-integration)
5. [Future Roadmap](#future-roadmap)
6. [Installation and Setup](#installation-and-setup)

## Preview

To get a quick overview of the Easy-Consult app, watch the preview video below:
[Watch this video on YouTube](https://www.youtube.com/watch?v=7uXYyreLLo4)

## Architecture

Easy-Consult follows a structured architecture pattern comprising three main layers:

1. **Repository Layer**: Manages data access and communication with the backend API.
2. **Data Layer**: Handles data models and data sources, including local caching using Hive.
3. **Presentation Layer**: Manages UI components and state management using Bloc.

## Features

- **Authentication**:
  - User login, registration, forgot password, and email verification.
  - Token storage and management with automatic token refresh functionality.
  - Persistent user sessions to avoid onboarding for returning users.

- **Lawyer Search and View**:
  - Search and view lawyer specializations retrieved from the REST API.
  - View detailed lawyer profiles, including their education, employment history, specializations, and availability.

- **Appointment Booking**:
  - Clients can place appointment requests, specifying appointment details (video call, voice call, or physical meeting).
  - Real-time updates on appointment status (accepted or rejected) via socket server integration.
  - Local notifications for upcoming appointments, notifying users 30 minutes before the appointment time.

- **Data Management**:
  - Data fetching from the REST API and caching using Hive for offline support.
  - Efficient state management using Bloc for a responsive user experience.

- **Notifications**:
  - Integration with `flutter_local_push_notification` for handling notifications with action buttons.
  - Real-time updates and notifications via socket server for seamless communication between clients and lawyers.

## Network Connectivity

Easy-Consult monitors network connectivity to provide a seamless user experience whether online or offline:

- **Network Status**: The app uses the `connectivity_plus` package to detect changes in network status.
- **Offline Support**: When offline, cached data stored with Hive ensures users can access previously fetched information.
- **Toast Notifications**: Users receive toast notifications using `fluttertoast` when the network status changes, providing real-time feedback.

## Backend Integration

The app uses a custom-built Express.js backend REST API. The backend handles all core functionalities, including user authentication, appointment management, and real-time notifications. 

**Backend Project Hosting**: [Link to Backend Project](https://github.com/username/backend-project)

## Future Roadmap

We have an exciting roadmap for upcoming features, ensuring that Easy-Consult continues to meet user needs:

1. **Chat Integration**:
   - Integration with Agora for in-app messaging between clients and lawyers.
   - Real-time chat support for seamless communication.

2. **Lawyer View**:
   - A dedicated interface for lawyers to manage their appointments, view client requests, and update their availability.



## Installation and Setup

Follow these steps to set up and run Easy-Consult on your local machine:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/username/easy-consult.git
   cd easy-consult
   flutter pub get
   flutter run
   ```

