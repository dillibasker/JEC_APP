const express=require("express")
const router=express.Router()
const Student=require("../../Models/students")

// Mark attendence 

router.post("/attendence",async(req,res)=>{
    const { rollNumber, date, status } = req.body;
    const student = await Student.findOne({ rollNumber });
if (!student) return res.status(400).send("Student Not found") 
    student.attendence.push({date,status})
    await student.save();
    res.send(student);
})

module.exports=router
