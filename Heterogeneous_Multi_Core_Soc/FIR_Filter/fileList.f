# Parameters
Processor_Core/design/DefaultParameters/defaultParameters.vh

# Fetch
Processor_Core/design/Fetch/programCounterInputMux.v
Processor_Core/design/Fetch/programCounter.v
Processor_Core/design/Fetch/programCounterIncrementor.v
Processor_Core/design/Fetch/instructionMemory.v

# Pipeline Registers
Processor_Core/design/PipelineRegisters/fetchToDecodeRegister.v
Processor_Core/design/Decode/instructionDecoder.v
Processor_Core/design/Decode/registerFile.v
Processor_Core/design/Decode/controlUnit.v
Processor_Core/design/Decode/immediateGenerator.v
Processor_Core/design/PipelineRegisters/decodeToExecuteRegister.v

# Execute
Processor_Core/design/Execute/aluControl.v
Processor_Core/design/Execute/aluInputSelectMux1.v
Processor_Core/design/Execute/aluInputSelectMux2.v
Processor_Core/design/Execute/alu.v
Processor_Core/design/Execute/pcAdderInputMux.v
Processor_Core/design/Execute/pcAdder.v
Processor_Core/design/Execute/forwardUnit.v
Processor_Core/design/Execute/forwardMux1.v
Processor_Core/design/Execute/forwardMux2.v

# Memory Access
Processor_Core/design/PipelineRegisters/executeToMemoryRegister.v
Processor_Core/design/MemoryAccess/nextPcValueSelect.v
Processor_Core/design/MemoryAccess/dataMemory.v

# Write Back
Processor_Core/design/PipelineRegisters/memoryToWriteBackRegister.v
Processor_Core/design/WriteBack/writeBackMux.v

# processor
Processor_Core/design/processor.v

# Fir
FirController/firController.v

# soc
topSoc.v
topSoc_tb.v
