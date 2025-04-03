const express=require("express")
const router=express.Router()
const Attendance=require("../../Models/attendanceSchema")

// Mark attendence 

router.post('/sa', async (req, res) => {
    try {
      await Attendance.insertMany(req.body);
      res.status(201).json({ message: 'Attendance submitted successfully' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });
  

module.exports=router
