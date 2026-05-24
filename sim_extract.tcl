# sim_extract.tcl
# Signal extractor for the SVA auto-generation framework.
# Run inside ModelSim/QuestaSim after simulation completes:
#   vsim -do sim_extract.tcl tb_dut
#
# Output: signals.csv with columns: time, signal, value

proc extract_signals {top outfile} {
    set fp [open $outfile w]
    puts $fp "time,signal,value"

    set sigs [find signals -recursive $top/*]
    set count 0

    foreach sig $sigs {
        set transitions [examine -time all $sig]
        foreach {t v} $transitions {
            puts $fp "$t,$sig,$v"
        }
        incr count
    }

    close $fp
    puts "$count signals extracted to $outfile"
}

# --- Entry point ---
# Change /tb_top to match your testbench hierarchy
extract_signals /tb_top signals.csv
quit -f
