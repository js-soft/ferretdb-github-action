"use strict"

const { test } = require("uvu")
const { expect } = require("expect")
const Mongoose = require("mongoose")

const PORT = process.env.PORT ?? 27017

test("connects to FerretDB", async () => {
  const connection = await Mongoose.createConnection(`mongodb://localhost:${PORT}`).asPromise()
  await connection.close()
})

test("fails to connect to non-existent FerretDB instance", async () => {
  await expect(
    Mongoose.connect(`mongodb://localhost:${parseInt(PORT) + 1}`, {
      connectTimeoutMS: 1000,
      serverSelectionTimeoutMS: 1000,
    })
  ).rejects.toThrow()
})

test.run()
