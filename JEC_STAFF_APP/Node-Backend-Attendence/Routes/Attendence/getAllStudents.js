const express=require("express")
const router=express.Router()
const Student=require("../../Models/students")

//get all student - department wise

router.get("/students/:department/:year/:section",async(req,res)=>{
    const {department, year, section}=req.params
    const students=await Student.find(department,year,section)
    res.send(students)
})

module.exports=router