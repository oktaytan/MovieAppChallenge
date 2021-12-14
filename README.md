# Movie App

</br>

<div id="top"></div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>
</br>


<!-- ABOUT THE PROJECT -->

## About The Project

This is an application where you can search about your favorite movies and find detailed information about movies.

The application is built on the MVVM architecture. Moreover, the Router layer does the navigation of the application.

The data of the movies is provided by the OMDB API. The Network layer makes the API requests in the application.

Below you can see a gif of the application working.

</br>

![MovieApp Gif](/MovieApp.gif)

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

Programming language and frameworks used to build the app:

* [Swift](https://www.swift.org)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [AlamofireImage](https://github.com/Alamofire/AlamofireImage)
* [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started

You should follow the instructions below to run the application on your local computer.

### Prerequisites

First of all, you must have Xcode 13 or higher installed on your computer. [Xcode](https://developer.apple.com/xcode/)

### Installation

Follow the steps below to build.

1. Get a free API Key at [OMDP Api](http://www.omdbapi.com)

2. Clone the repo

   ```sh
   git clone https://github.com/oktaytan/MovieAppChallenge.git
   ```
3. Install Pod packages
   
   ```sh
   pod install
   ```
4. Enter your API in `NetworkService.swift`

   ```js
   private let apiKey = "{YOUR_API_KEY}";
   ```

<p align="right">(<a href="#top">back to top</a>)</p>


<!-- CONTACT -->
## Contact

Twitter - [@oktaytandev](https://twitter.com/oktaytandev)

Project Link: [https://github.com/oktaytan/MovieAppChallenge](https://github.com/oktaytan/MovieAppChallenge.git)

<p align="right">(<a href="#top">back to top</a>)</p>
