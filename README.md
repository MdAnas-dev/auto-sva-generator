# Automated SVA Generator — Tcl + Perl

An end-to-end automated pipeline that mines temporal signal patterns from EDA simulation waveforms and synthesises SystemVerilog Assertion (SVA) properties — without manual intervention.

> **VIT Vellore | SENSE Department | 2025–26**
> Course: VLSI Design & Verification

---

## How It Works

```
RTL Simulation  →  sim_extract.tcl  →  signals.csv  →  sva_generator.pl  →  auto_assertions.sv
   (ModelSim)       (signal dump)     (intermediate)    (pattern mining)     (SVA output)
```

1. Run your RTL simulation and execute `sim_extract.tcl` inside the simulator shell
2. The Tcl script queries all signals and dumps time-value transitions to `signals.csv`
3. Run `sva_generator.pl` on the CSV — it performs pairwise temporal correlation
4. Generated SVA properties are written to `auto_assertions.sv`
5. Integrate the `.sv` file back into your testbench and re-simulate to validate

---

## Files

| File | Description |
|------|-------------|
| `tcl/sim_extract.tcl` | Runs inside ModelSim/QuestaSim — extracts all signal transitions to CSV |
| `perl/sva_generator.pl` | Pattern miner — reads CSV, identifies temporal relationships, writes SVA |
| `examples/auto_assertions_example.sv` | Sample output from AHB-Lite bus controller validation |

---

## Quick Start

### Step 1 — Signal extraction (inside ModelSim)
```tcl
vsim -do tcl/sim_extract.tcl your_tb
# Output: signals.csv
```

### Step 2 — Generate assertions
```bash
perl perl/sva_generator.pl signals.csv auto_assertions.sv 0.90 8
# Args: input_csv  output_sv  confidence_threshold  max_clock_offset
```

### Step 3 — Validate
Add `auto_assertions.sv` to your testbench compile list and re-simulate. All generated assertions should pass on the original trace.

---

## Algorithm

For every signal pair (A, B) and clock offset k (1 to max_offset):

```
Confidence(A→B, k) = |{ t : A transitions at t AND B transitions at t+k }|
                     / |{ t : A transitions at t }|
```

If `Confidence >= threshold`, generate:
```systemverilog
property p_A_implies_B;
    @(posedge clk) disable iff (!rst_n)
    A |=> ##k B;
endproperty
```

---

## Experimental Results (AHB-Lite Bus Controller)

| Metric | Value |
|--------|-------|
| Signals analysed | 42 |
| Simulation trace length | 500 ns / 2,000 cycles |
| Signal pairs evaluated | 1,722 |
| Assertions generated | 31 |
| Assertions passing re-simulation | 31 / 31 (100%) |
| Design-intent precision | 87% (27 of 31 meaningful) |
| Pattern mining runtime | < 2 seconds |
| FPGA LUT overhead | 3% |

---

## Compatibility

- **Simulators:** ModelSim, QuestaSim, VCS (Synopsys), Xcelium (Cadence), Icarus Verilog
- **Perl:** Standard Perl 5 — no external modules required
- **Generated SVA:** Compatible with Synopsys DC, Cadence Genus, Quartus, JasperGold

---

## Authors

- Mohammed Anas (24BVD0097)
- Aryan Vaity (24BVD0001)

**Faculty Mentor:** Abhishek Narayan Tripathi — School of Electronics Engineering (SENSE), VIT Vellore
