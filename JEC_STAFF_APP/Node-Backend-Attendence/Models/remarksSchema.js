const express = require("express")

const remarkSchema = new mongoose.Schema({
    department: String,
    className: String,
    remark: String,
    username: String, // Stores who posted the remark
    timestamp: { type: Date, default: Date.now },
  });
  const Remark = mongoose.model("Remark", remarkSchema);
  module.export=Remark