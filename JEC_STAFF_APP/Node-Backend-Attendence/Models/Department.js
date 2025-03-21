const mongoose=require("mongoose")

const DepartmentSchema = new mongoose.Schema({
    name: String,
    classes: [{ year: Number, section: String, students: [StudentSchema] }],
  });
  
const Department=mongoose.model("Department",DepartmentSchema)
module.exports = Department