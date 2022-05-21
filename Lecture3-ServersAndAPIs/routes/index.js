import express from "express";
const router = express.Router();

// Controllers
import { homeController, urlController } from "../controllers";

// Home page
router.get("/", homeController.home);

// Create a long url
router.post("/expand", urlController.expand);

// Add custom code in the url
router.post("/custom/:code", urlController.custom);

// Redirecting to original URL
router.get("/:code", urlController.open);


export default router;
