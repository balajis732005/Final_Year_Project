# Parameters
design/DefaultParameters/defaultParameters.vh

# Fetch
design/Fetch/programCounterInputMux.v
design/Fetch/programCounter.v
design/Fetch/programCounterIncrementor.v
design/Fetch/instructionMemory.v

# Pipeline Registers
design/PipelineRegisters/fetchToDecodeRegister.v
design/Decode/instructionDecoder.v
design/Decode/registerFile.v
design/Decode/controlUnit.v
design/Decode/immediateGenerator.v
design/PipelineRegisters/decodeToExecuteRegister.v

# Execute
design/Execute/aluControl.v
design/Execute/aluInputSelectMux1.v
design/Execute/aluInputSelectMux2.v
design/Execute/alu.v
design/Execute/pcAdderInputMux.v
design/Execute/pcAdder.v
design/Execute/forwardUnit.v
design/Execute/forwardMux1.v
design/Execute/forwardMux2.v

# Memory Access
design/PipelineRegisters/executeToMemoryRegister.v
design/MemoryAccess/nextPcValueSelect.v
design/MemoryAccess/dataMemory.v

# Write Back
design/PipelineRegisters/memoryToWriteBackRegister.v
design/WriteBack/writeBackMux.v