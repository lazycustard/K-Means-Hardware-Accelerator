# K-Means Hardware Accelerator
![Verilog](https://img.shields.io/badge/Verilog-FF0000?style=for-the-badge&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![ModelSim](https://img.shields.io/badge/ModelSim-EDA%20Simulator-blue?style=for-the-badge)

A Verilog-based hardware accelerator that implements the K-Means clustering algorithm on FPGA. The project includes both a sequential single-point processor and a parallel N-point processor.

## Overview

K-Means is an unsupervised machine learning algorithm that partitions data points into K clusters by minimizing within-cluster variance. This project implements a hardware version of K-Means with K=2 (two clusters) using Verilog, targeting FPGA implementation.

The algorithm works in two main stages:
1. **Distance Computation**: Calculate Euclidean distance from each point to each centroid
2. **Cluster Assignment**: Assign each point to the nearest centroid

## Architecture

### Module Hierarchy

```
top_module (Sequential)
├── control_unit     - FSM controller
├── distance_calc x2 - Euclidean distance calculators
└─- comparator       - Cluster assignment logic

parallel_top (Parallel, N points)
└── top_module x N   - N instances operating in parallel
```

### Components

| Module | Description |
|--------|-------------|
| `control_unit.v` | 4-state FSM (IDLE, COMPUTE, ASSIGN, DONE) controlling the pipeline |
| `distance_calc.v` | Computes squared Euclidean distance: dist = (dx)^2 + (dy)^2 |
| `comparator.v` | Compares two distances and outputs cluster assignment |
| `top_module.v` | Top-level sequential processor for one data point |
| `parallel_top.v` | Parameterized parallel processor processing N points simultaneously |

### FSM State Machine

```
IDLE -> COMPUTE -> ASSIGN -> DONE
         ^                    |
         |____________________| (loops back to IDLE)
```

The FSM uses a 2-bit counter to slow transitions for visibility. Each state occupies 3 clock cycles.

## File Structure

```
KMeansGpu/
├── src/
│   ├── control_unit.v      - FSM controller
│   ├── distance_calc.v     - Distance calculation module
│   ├── comparator.v        - Distance comparator
│   ├── top_module.v        - Sequential top-level module
│   └── parallel_top.v      - Parallel N-point processor
├── testbench/
│   ├── tb_distance.v       - Testbench for distance_calc
│   ├── tb_comparator.v     - Testbench for comparator
│   ├── tb_top.v            - Testbench for top_module
│   └── tb_parallel.v       - Testbench for parallel_top (generates results.txt)
├── results.txt             - Output from parallel simulation (40 data points)
├── animate.py              - Python visualization script
├── wave.do                 - ModelSim wave dofile
├── README.md               - This file
└── work/                   - Simulation work directory
```

## Simulation

### Requirements
- ModelSim (or compatible Verilog simulator)
- Python 3 with matplotlib and numpy (for visualization)

### Running Individual Testbenches

To compile and run individual testbenches in ModelSim:

```bash
# Compile all source modules
vlog src/distance_calc.v src/comparator.v src/control_unit.v src/top_module.v src/parallel_top.v

# Run distance_calc testbench
vsim -do "vlog testbench/tb_distance.v; run -all" work.tb_distance

# Run comparator testbench
vsim -do "vlog testbench/tb_comparator.v; run -all" work.tb_comparator

# Run top_module testbench
vsim -do "vlog testbench/tb_top.v; run -all" work.tb_top

# Run parallel testbench (generates results.txt)
vsim -do "vlog testbench/tb_parallel.v; run -all" work.tb_parallel
```

### Load Waveform Display

After running a simulation in ModelSim, load the waveform signals:

```
do wave.do
```

## Output Format

The `results.txt` file contains one line per data point:
```
X Y ClusterID
```
- X, Y: 8-bit coordinates (0-99)
- ClusterID: 0 or 1 indicating cluster assignment

Example:
```
27 28 0
24 40 0
40 19 0
...
```

## Visualization

The `animate.py` script visualizes the clustering results:

```bash
python animate.py
```

This displays an animated scatter plot with:
- Red points: Cluster 0
- Blue points: Cluster 1
- Black X marker: Centroid of Cluster 0
- Green X marker: Centroid of Cluster 1

The animation shows points being added one at a time with dynamically updated centroids.
 ![Image Alt](https://github.com/lazycustard/K-Means-Hardware-Accelerator/blob/main/results/Kmeans%20Visualization.png)

## Hardware Parameters

| Parameter | Value |
|-----------|-------|
| Coordinate width | 8 bits (0-255 range) |
| Distance width | 16 bits (squared distance) |
| FSM states | 4 (IDLE, COMPUTE, ASSIGN, DONE) |
| Clock cycles per state | 3 (controlled by 2-bit counter) |
| Default N (parallel) | 4 points |

## Key Design Decisions

1. **Squared Distance**: Uses squared Euclidean distance to avoid expensive square root computation. Since the square root function is monotonic, minimizing squared distance is equivalent to minimizing actual distance.

2. **Sequential vs Parallel**: `top_module` processes one point at a time, while `parallel_top` instantiates N processing units for parallel throughput.

3. **Bus Packing**: The parallel module uses packed buses `[8*N-1:0]` to transfer multiple coordinates in a single cycle, then slices them using indexed part-select `x_bus[8*i +: 8]`.

4. **Reset Behavior**: Each data point triggers a reset to restart the FSM, ensuring clean state transitions.

## Extending to K > 2

To support more than 2 clusters:
1. Add more `distance_calc` instances (one per centroid)
2. Extend `comparator` to a multi-way comparison or use a tree of 2-way comparators
3. Increase `cluster_id` bit width to log2(K) bits
4. Update `control_unit` FSM if additional states are needed


## License

This project is licensed under the MIT License- see the [LICENSE](LICENSE) file for details.
