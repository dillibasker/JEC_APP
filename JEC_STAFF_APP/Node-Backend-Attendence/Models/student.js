const mongoose=require("mongoose")

const StudentSchema=new mongoose.Schema({
      name: String,
      rollNumber: String,
      department: String,
      year: Number,
      section: String,
      attendance: [{ date: Date, status: String }],
})

const students=mongoose.Model("students",StudentSchema)
module.exports = students