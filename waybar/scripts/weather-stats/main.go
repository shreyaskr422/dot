package main

import (
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"time"
)

// Patna coordinates — change if needed
const (
	LATITUDE  = "24.963129"
	LONGITUDE = "83.608084"
	API_URL   = "https://api.open-meteo.com/v1/forecast?latitude=" + LATITUDE + "&longitude=" + LONGITUDE + "&current=temperature_2m,apparent_temperature,weather_code,wind_speed_10m,wind_direction_10m,relative_humidity_2m,precipitation&wind_speed_unit=ms&timezone=Asia%2FKolkata"
)

type OpenMeteoResponse struct {
	Current struct {
		Temperature     float64 `json:"temperature_2m"`
		ApparentTemp    float64 `json:"apparent_temperature"`
		WeatherCode     int     `json:"weather_code"`
		WindSpeed       float64 `json:"wind_speed_10m"`
		WindDirection   float64 `json:"wind_direction_10m"`
		Humidity        float64 `json:"relative_humidity_2m"`
		Precipitation   float64 `json:"precipitation"`
	} `json:"current"`
}

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Alt     string `json:"alt"`
	Class   string `json:"class"`
}

// WMO weather codes → icon + description + class
type WeatherInfo struct {
	Icon        string
	Description string
	Class       string
}

func getWeatherInfo(code int) WeatherInfo {
	switch {
	case code == 0:
		return WeatherInfo{"󰖙", "Clear Sky", "clear"}
	case code == 1:
		return WeatherInfo{"󰖙", "Mainly Clear", "clear"}
	case code == 2:
		return WeatherInfo{"󰖕", "Partly Cloudy", "cloud"}
	case code == 3:
		return WeatherInfo{"󰖐", "Overcast", "cloud"}
	case code == 45 || code == 48:
		return WeatherInfo{"󰖑", "Foggy", "fog"}
	case code >= 51 && code <= 57:
		return WeatherInfo{"󰖗", "Drizzle", "rain"}
	case code >= 61 && code <= 67:
		return WeatherInfo{"󰖗", "Rain", "rain"}
	case code >= 71 && code <= 77:
		return WeatherInfo{"󰖘", "Snow", "snow"}
	case code >= 80 && code <= 82:
		return WeatherInfo{"󰖗", "Rain Showers", "rain"}
	case code == 85 || code == 86:
		return WeatherInfo{"󰖘", "Snow Showers", "snow"}
	case code == 95:
		return WeatherInfo{"󰖓", "Thunderstorm", "thunder"}
	case code == 96 || code == 99:
		return WeatherInfo{"󰖓", "Thunderstorm with Hail", "thunder"}
	default:
		return WeatherInfo{"󰖐", "Unknown", "normal"}
	}
}

func windDirection(degrees float64) string {
	dirs := []string{"N", "NE", "E", "SE", "S", "SW", "W", "NW"}
	idx := int((degrees+22.5)/45) % 8
	return dirs[idx]
}

func getWeather() (WaybarOutput, error) {
	client := &http.Client{Timeout: 10 * time.Second}

	resp, err := client.Get(API_URL)
	if err != nil {
		return WaybarOutput{}, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return WaybarOutput{}, fmt.Errorf("API error: %s", resp.Status)
	}

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return WaybarOutput{}, err
	}

	var weather OpenMeteoResponse
	if err := json.Unmarshal(body, &weather); err != nil {
		return WaybarOutput{}, err
	}

	c := weather.Current
	info := getWeatherInfo(c.WeatherCode)

	text := fmt.Sprintf("%s %.0f°C", info.Icon, c.Temperature)

	tooltip := fmt.Sprintf(
		"Bhagwanpur, Bihar\n%s\nTemperature: %.1f°C\nFeels like: %.1f°C\nHumidity: %.0f%%\nWind: %.1f m/s %s\nPrecipitation: %.1f mm\nUpdated: %s",
		info.Description,
		c.Temperature,
		c.ApparentTemp,
		c.Humidity,
		c.WindSpeed,
		windDirection(c.WindDirection),
		c.Precipitation,
		time.Now().Format("15:04:05"),
	)

	return WaybarOutput{
		Text:    text,
		Tooltip: tooltip,
		Alt:     info.Description,
		Class:   info.Class,
	}, nil
}

func main() {
	output, err := getWeather()
	if err != nil {
		errorOutput := WaybarOutput{
			Text:    "󰅧 N/A",
			Tooltip: fmt.Sprintf("Error fetching weather: %v", err),
			Alt:     "Error",
			Class:   "error",
		}
		jsonOutput, _ := json.Marshal(errorOutput)
		fmt.Println(string(jsonOutput))
		return
	}

	jsonOutput, err := json.Marshal(output)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error creating JSON: %v\n", err)
		return
	}

	fmt.Println(string(jsonOutput))
}
