const express=require("express")
const router=express.Router()
const Remark=require("../../Models/remarksSchema")

router.post("/remark",async(req,res) =>{
    try{
        const { department, className, remark, username } = req.body;
        const newRemark=new Remark({ department, className, remark, username })
        await newRemark.save();
        res.status(201).json({ message: "Remark added successfully!" });
    }catch (error) {
        res.status(500).json({ error: "Failed to add remark" });
      }
    
})


router.get("/remark", async (req, res) => {
    try {
      const { department, className } = req.query;
      const remarks = await Remark.find({ department, className }).sort({ timestamp: -1 });
      res.json(remarks);
    } catch (error) {
      res.status(500).json({ error: "Failed to fetch remarks" });
    }
  });

  module.exports=router