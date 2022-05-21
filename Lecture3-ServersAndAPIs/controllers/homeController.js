import { BASEURL } from "../config";

const homeController = {
    async home(req, res, next) {
        try {
            return res.render("../views/home", { baseUrl: BASEURL });
        } catch (error) {
            return next(error);
        }
    }
};

export default homeController;