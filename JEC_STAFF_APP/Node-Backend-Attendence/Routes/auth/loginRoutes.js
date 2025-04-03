const express = require("express");
const router = express.Router();
const User = require("../../Models/userSchema");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
require("dotenv").config();

// User Login Route
router.post("/login", async (req, res) => {
    try {
        const { email, password } = req.body;

        // Check if user exists
        const user = await User.findOne({ email });
        if (!user) return res.status(401).json({ message: "User not found" });

        // Verify password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) return res.status(401).json({ message: "Invalid credentials" });

        // Generate JWT token
        const token = jwt.sign(
            { id: user._id },
            process.env.JWT_SECRET || "defaultsecret",
            { expiresIn: "1h" }
        );

        // Send response with token
        res.status(200).json({
            message: "Login successful",
            token,
            user: {
                _id: user._id,
                name: user.name,
                email: user.email,
                department: user.department,
            },
        });
    } catch (err) {
        console.error("Login error:", err);
        res.status(500).json({ message: "Error logging in", error: err.message });
    }
});

module.exports = router;
