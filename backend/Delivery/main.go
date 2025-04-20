package main

import (
	"context"
	"log"
	"os"

	"github.com/A2SV/A2SV-2025-Internship-Pass-Me/delivery/controllers"
	"github.com/A2SV/A2SV-2025-Internship-Pass-Me/delivery/routers"
	repositories "github.com/A2SV/A2SV-2025-Internship-Pass-Me/repositories"
	usecases "github.com/A2SV/A2SV-2025-Internship-Pass-Me/usecases"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/mongo"
	"go.mongodb.org/mongo-driver/mongo/options"
	"golang.ngrok.com/ngrok"
	"golang.ngrok.com/ngrok/config"
)

func main() {
	// Load environment variables from .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}

	// Get MongoDB URI from the environment variables
	mongoURI := os.Getenv("MONGO_URI")
	if mongoURI == "" {
		log.Fatal("MONGO_URI is not set in the .env file")
	}

	// Get ngrok auth token from environment variables
	ngrokToken := os.Getenv("NGROK_AUTH_TOKEN")
	if ngrokToken == "" {
		log.Fatal("NGROK_AUTH_TOKEN is not set in the .env file")
	}

	// Connect to MongoDB
	client, err := mongo.Connect(context.Background(), options.Client().ApplyURI(mongoURI))
	if err != nil {
		log.Fatal(err)
	}
	defer client.Disconnect(context.Background())

	// Select the database
	db := client.Database("passme")

	// Initialize repositories
	flightRepo := repositories.NewFlightRepository(db)
	userRepo := repositories.NewUserRepository(db)

	// Initialize use cases
	flightUC := usecases.NewFlightUseCase(flightRepo)
	userUC := usecases.NewUserUseCase(userRepo)

	// Initialize controllers
	flightController := controllers.NewFlightController(flightUC)
	userController := controllers.NewUserController(userUC)

	// Set up the Gin router
	r := gin.Default()

	// Set up the routes
	// Each router file handles its own route setup
	routers.SetupUserRoutes(r, userController)
	routers.SetupFlightRoutes(r, flightController)

	// Start ngrok tunnel
	ctx := context.Background()
	tunnel, err := ngrok.Listen(ctx,
		config.HTTPEndpoint(),
		ngrok.WithAuthtoken(ngrokToken),
	)
	if err != nil {
		log.Fatalf("Failed to start ngrok tunnel: %v", err)
	}
	log.Printf("ngrok tunnel started at: %s", tunnel.URL())

	// Start the server through ngrok
	log.Println("Server is running through ngrok")
	if err := r.RunListener(tunnel); err != nil {
		log.Fatalf("Failed to start server: %v", err)
	}
}
