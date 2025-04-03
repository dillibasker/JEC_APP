const express=require("express")
const router=express.Router()
const Attendance=require("../../Models/attendanceSchema")

//get all student - department wise
router.get('/get-attendance', async (req, res) => {
    try {
      const { department, className, section, session } = req.query;
      const records = await Attendance.find({ department, className, section, session });
      res.json(records);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  });

module.exports=router