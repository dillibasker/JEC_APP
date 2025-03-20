const express=require("express")
const router=express.Router()
const Student=require("../../Models/students")

// today student resent or not 
router.get("/attendance/:rollNumber", async (req, res) => {
    const { rollNumber } = req.params;
    const student = await Student.findOne({ rollNumber });
    if (!student) return res.status(404).send("Student not found");
  
    res.send(student.attendance);
  });

  module.exports=router