const express = require("express");
const router = express.Router();
const User = require("../../Models/userSchema");

const authMiddleware = require("../../middleware/authMiddleware");

router.get("/profile", authMiddleware, async (req, res) => {
    try {
        const user = await User.findById(req.user.id);
        if (!user) return res.status(404).json({ message: "User not found" });

        res.status(200).json({ username: user.username });
    } catch (error) {
        console.error("Server Error:", error);
        res.status(500).json({ message: "Server Error" });
    }
});


module.exports = router;