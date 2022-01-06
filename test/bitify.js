const path = require("path")
const { wasm: wasm_tester } = require("circom_tester")
const { buildBabyjub } = require("circomlibjs")

describe("Bitify Test", () => {

    let F

    before(async () => {
        const babyJubjub = await buildBabyjub()
        F = babyJubjub.F
    })

    it("Bitify", async () => {
        // generate input
        const input = 4541
        const binary = Array.from(input.toString(2)).map(entry => Number(entry)).reverse()
        // interact with circuit
        const circuit = await wasm_tester(path.resolve(__dirname, "../circuits/bitify.circom"))
        const witness = await circuit.calculateWitness({ in: input }, true)
        await circuit.assertOut(witness, { out: [...binary] }, true)
    })
})