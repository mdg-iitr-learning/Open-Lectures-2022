import dotenv from "dotenv";

dotenv.config();

export const {
    APP_PORT,
    MONGOURI,
    BASEURL,
    URL_LENGTH
} = process.env;
