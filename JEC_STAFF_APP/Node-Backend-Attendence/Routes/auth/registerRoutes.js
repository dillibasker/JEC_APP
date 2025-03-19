const express = require("express");
const router = express.Router();
const users = require("../../Models/userSchema");
const bcrypt = require("bcryptjs");
// Generate Unique ID
const generateUserId = () => "U" + Math.floor(Math.random() * 1000000);
router.post("/", async (req, res) => {
    try {
        console.log("Received request:", req.body);  // ✅ Debugging

        const { email, password } = req.body;
        if (!email || !password) {
            console.log("Validation failed");  
            return res.status(400).json({ message: "All fields are required" });
        }

        const existingUser = await users.findOne({ email });
        if (existingUser) {
            console.log("User already exists");  
            return res.status(400).json({ message: "User already exists" });
        }

        const hashedPassword = await bcrypt.hash(password, 10);
        const user = new users({ email, password: hashedPassword ,  userId: generateUserId() });

        await user.save();
        console.log("User registered successfully");  
        res.status(201).json({ message: "User registered successfully" ,userId: user.userId });
    } catch (err) {
        console.error("Register Error:", err);  
        res.status(500).json({ message: "Internal Server Error", error: err.message });
    }
});

module.exports = router;
