# CurrencyNow Setup Guide

## Prerequisites
Ensure that the following tools are installed:
- [Mise](https://github.com/jdx/mise)

### Generating the Project  

To generate the project, you need to configure the environment variables `apiURL` and `apiKey`. These variables are required for accessing the API and must be set before generating the project.  

For reference, there is an example branch named `with-credentials`, which includes a sample file containing these variables. However, **this file should not be included in the project** for security reasons. Make sure to set the environment variables securely in your development setup.  

## Steps to Run the Project

1. **Install Dependencies with Mise**  
   Run the following command to install the dependencies via Mise:
   ```bash
   mise i
   ```

2. **Install Tuist Dependencies**  
   Install the necessary dependencies for Tuist:
   ```bash
   tuist install
   ```

3. **Generate the Project**  
   Generate the Xcode project with Tuist:
   ```bash
   tuist generate
   ```

After completing these steps, you can open the generated `.xcodeproj` file in Xcode and run the project.

## Project Structure

The project is organized into the following main modules:

- **AppCore**: Contains base functionality and shared components used across all modules.
- **AppUI**: Contains the main UI components and building blocks for the application.
- **App**: The main module responsible for starting the application, coordinating communication between modules, and handling flow coordinators.
- **AppDependencies**: Manages the setup and configuration of all dependencies used across the application. 
- **Features**: This folder contains individual modules for different features of the app
