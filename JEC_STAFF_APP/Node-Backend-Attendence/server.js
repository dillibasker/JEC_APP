const express=require("express")
const dotenv=require("dotenv")
const cors=require("cors")
const { default: mongoose } = require("mongoose")
const bodyParser = require("body-parser");

const app=express()
app.use(express.json())
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type", "Authorization"]
}));

app.use(bodyParser.json());
dotenv.config()

mongoose.connect(process.env.MONGO_URL).then(()=> console.log("Mongo DB is connect")).catch((err) => console.log("Mongo db is not connected",(err)))

app.use("/api/register", require("./Routes/auth/registerRoutes"));
app.use("/api/login", require("./Routes/auth/loginRoutes"));
app.use("/api/forgot-password", require("./Routes/auth/forgot-password"));
app.use("/api/addStudents", require("./Routes/Attendence/addStudent"));
app.use("/api/attendence", require("./Routes/Attendence/markAttendence"));
app.use("/api/attendance/:rollNumber",require("./Routes/Attendence/getAttendenceRecordStudent"));
app.use("/api/students/:department/:year/:section",require("./Routes/Attendence/getAllStudents"));
app.use("/api/user", require("./Routes/profile/profile"));


const PORT=process.env.PORT || 5000
app.listen(PORT,()=>{ console.log(`server running on port ${PORT}`)})