import { BASEURL, URL_LENGTH } from "../config";
import { Url } from "../models";
import validUrl from "valid-url";
import crypto from "crypto";

const urlController = {
    async expand(req, res, next) {
        try {
            const { shorturl } = req.body;
        
            // checking validity of base url
            if (!validUrl.isUri(BASEURL)) {
                return res.send("Invalid base url");
            }
        
            // checking validity of short url
            if (!validUrl.isUri(shorturl)) {
                return res.send("Invalid long url");
            }
        
            // Check if the short url already exists in the database
            const oldurl = await Url.findOne({ shorturl: shorturl });
        
            if (oldurl) {
                return res.render("../views/url", {
                    url: oldurl,
                    message: "",
                });
            } else {
                // Generate unique long id
                const code = crypto.randomBytes(parseInt(URL_LENGTH)).toString('hex')
        
                // Long URL
                const longurl = BASEURL + code;
        
                const newUrl = new Url({
                    longurl: longurl,
                    code: code,
                    shorturl: shorturl,
                    date: new Date(),
                });
        
                const newurl2 = await newUrl.save();
        
                return res.render("../views/url", {
                    url: newurl2,
                    message: "",
                });
            }
        } catch (error) {
            return next(error);
        }
    },

    async custom(req, res, next) {
        try {
            const { custom } = req.body;
        
            // check if custom code already exists
            const oldcustom = await Url.findOne({ code: custom });
            if (oldcustom) {
                return res.render("../views/url", {
                    url: oldcustom,
                    message: "Sorry, this code is already in use, please enter a new one",
                });
            } else {
                const url = await Url.findOne({ code: req.params.code });
        
                const urln = BASEURL + custom;
        
                var newvalues = { $set: { code: custom, longurl: urln } };
        
                if (url) {
                Url.findOneAndUpdate(
                    { code: req.params.code },
                    newvalues,
                    async (err, data) => {
                    if (err) return res.send("Error");
                    else {
                        const url2 = await Url.findOne({ code: custom });
                        return res.render("../views/url", {
                            url: url2,
                            message: "",
                        });
                    }
                    }
                );
                } else {
                    return res.send("Invalid url code");
                }
            }
        } catch (error) {
            return next(error);
        }    
    },

    async open(req, res, next) {
        try {
            const url = await Url.findOne({ code: req.params.code });
            
            if (url) {
              // checking validity of the url
              if (!validUrl.isUri(url.shorturl)) {
                return res.send("Invalid long url");
              }
        
              res.redirect(url.shorturl);
            } else {
              return res.render("../views/errorpage");
            }
        } catch (error) {
            return next(error);
        }
    }
};

export default urlController;