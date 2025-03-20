const express=require("express")
const router=express.router()
const Student=require("../../Models/students")

// Add a student  logic 

router.post("/addStudents",async(req,res)=>{
    const student=new Student(req.body)
    await student.save();
    res.status(201).send(student)
})

module.exports=router

