const express=require("express")
const router=express.router()
const Student=require("../../Models/students")

router.post("/attendence",async(req,res)=>{
    const { rollNumber, date, status } = req.body;
    const student = await Student.findOne({ rollNumber });
if (!student) return res.status(400).send("Student Not found") 
    student.attendence.push({date,status})
    await student.save();
    res.send(student);
})

