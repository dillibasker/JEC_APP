const mongoose=require("mongoose")

const StudentSchema=new mongoose.Schema({
      name: String,
      rollNumber: String,
      department: String,
      className: String,
      section: String,
      attendance: [{ date: Date, status: String }],
})

const students=mongoose.model("students",StudentSchema)
module.exports = students