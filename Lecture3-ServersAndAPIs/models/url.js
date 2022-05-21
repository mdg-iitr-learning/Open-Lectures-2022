import  mongoose  from "mongoose";
const Schema = mongoose.Schema;

const urlSchema = new Schema({
    longurl:
     {
        type:String,
        required: true
    },
    code: 
    {
        type: String
    },
    shorturl: {
        type: String
    },
    date: 
    {
        type: Date,
        default: Date.now
    },
});

export default mongoose.model('Url', urlSchema, 'urls');