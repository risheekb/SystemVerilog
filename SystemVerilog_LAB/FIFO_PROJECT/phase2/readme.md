# Synchronous FIFO

This project implements a **Synchronous FIFO (First In, First Out)** buffer, and includes a set of Makefile targets for simulation, waveform visualization, coverage analysis, and project cleanup.

## Makefile Help:
----------------

### Targets:

- **post_sim**  
  Runs the simulation for one of the specified test cases. You can choose from the following test cases:
  - `BaseTest`
  - `FullTest`
  - `EmptyTest`
  - `ClearTest`
  - `OneTest`
  - `InvalidTest`
  - `All` (Runs all test cases)

  **Usage Example**:
  ```sh
  make post_sim TEST=BaseTest
  ```

- **waveform**  
  Opens the waveform in Visualizer to view the simulation results after running `post_sim`. You can inspect the signal activity of the Synchronous FIFO design.

  **Usage**:
  ```sh
  make waveform
  ```

- **coverage**  
  Opens the coverage in Visualizer to view the simulation coverage report after running `post_sim`. It helps verify the functional areas exercised during the simulation.

  **Usage**:
  ```sh
  make coverage
  ```

- **clean**  
  Removes intermediate and generated files, such as object files, waveform files, and coverage reports.

  **Usage**:
  ```sh
  make clean
  ```

---

## How to Use:

1. **Run a Simulation**:  
   To run a specific test case, use the `post_sim` target. Replace `BaseTest` with the test case you want to run. For example:
   ```sh
   make post_sim TEST=BaseTest
   ```

2. **View Waveforms**:  
   After running the simulation, you can view the waveforms using the `waveform` target:
   ```sh
   make waveform
   ```
   This will open the waveform viewer, where you can analyze the simulation signals for the Synchronous FIFO design.

3. **View Coverage**:  
   To view the coverage of your simulation, run:
   ```sh
   make coverage
   ```
   This will generate a coverage report to show the parts of the design that were exercised during the simulation.

4. **Clean the Project**:  
   To remove all generated files (like simulation files, waveform files, and coverage reports), use the `clean` target:
   ```sh
   make clean
   ```

## License

```

### Explanation:
1. **Makefile Help Section**: The **Makefile Help** section now includes the `post_sim`, `waveform`, `coverage`, and `clean` targets with descriptions of what each target does and how to use them.
   - **`post_sim`**: Allows running the simulation with a specified test case.
   - **`waveform`**: Opens the waveform viewer to check the signals.
   - **`coverage`**: Opens the coverage visualizer to check the coverage results.
   - **`clean`**: Cleans the project by removing all generated files.

2. **How to Use Section**: This section provides step-by-step usage instructions for running the simulation, viewing waveforms, viewing coverage, and cleaning up.

---

