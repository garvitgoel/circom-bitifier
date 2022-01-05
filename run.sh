circom main.circom --r1cs --wasm --sym --c

# app.js defines input.json
node app.js

cd main_js
node generate_witness.js main.wasm input.json witness.wtns
snarkjs wej witness.wtns witness.json
cd ..

#Powers of Tau
snarkjs powersoftau new bn128 12 pot12_0000.ptau -v
snarkjs powersoftau contribute pot12_0000.ptau pot12_0001.ptau --name="First contribution" -v

#Phase 2
snarkjs powersoftau prepare phase2 pot12_0001.ptau pot12_final.ptau -v

snarkjs groth16 setup main.r1cs pot12_final.ptau main_0000.zkey
snarkjs zkey contribute main_0000.zkey main_0001.zkey --name="1st Contributor Name" -v
snarkjs zkey export verificationkey main_0001.zkey verification_key.json

cd main_js
mv witness.wtns ../witness.wtns
cd ..

#Generating a Proof
echo Generating a Proof
snarkjs groth16 prove main_0001.zkey witness.wtns proof.json public.json

#Verifying a Proof
echo Verifying a Proof
snarkjs groth16 verify verification_key.json public.json proof.json