# simple_weather

Test application to display flutter capacities

## Architechture

The project follows a Domain based architecture, a less rigid form of Clean Architecture. On the domain, sets of features may share same widgets, repositories and logic to acomplish the desired tasks. 


1. Core domain
    - data
        - TokenRepository
    - logic
        - SessionCubit
    - presentation
        - SplashScreen
        - common widgets

2. Auth domain
    - data
        - AuthProvider
    - logic
        - LoginCubic
    - presentation
        - LoginPage

3. Weather domain
    - data
        - Interfaces
            - WeatherProvider
        - Models
            - Weather
        - Providers
            - GeoLocalizationProvider
            - OpenWeatherProvider
    - logic
        - CurrentWeatherCubit
    - presentation
        - CurrentWeather
        
This organization also aims to protect core models from change and make the view dependent on models and logic in a way that make the view reflect the desired business rules of the project.

### Domains

1. Common: should contain code to perform core actions and provide support to other domains
2. Auth: shuold contain all auth related code, including operations such as login, signup, change of password, etc
3. Weather: should contain all code related to weather actions, such as displaying current weather and forecasts

### Presentation

Presentation widgets are grouped by views, except for the core domain. Views might have minor widgets stored in widget folders. This helps improve maintainance, code readability and testing.

Whenever view or common widgets get bigger, consider spliting into smaller parts within widgets folder.

### Data

Data folder contains models and repositories that will dictate the domain main data types and how the application interacts with the source of data. So far, due to the simplicity of data, no repositories were used on Auth and Weather domains.

### State management / Logic

The logic folder contains the BLoC files to handle the logic and state of the application. Cubits were chosen to better define the desired states and the transition between them while keeping simplicity in comparison with BLoC. There are 3 cubits to handle state


## Misc.

- This project follows [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) guidelines