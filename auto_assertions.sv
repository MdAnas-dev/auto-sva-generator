// Auto-generated SVA properties
// Tool: sva_generator.pl  |  Confidence threshold: 0.9
// Generated: Sat May 23 13:54:49 2026

module auto_assertions(
    input logic clk,
    input logic rst_n
);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_data_out_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        data_out |=> ##5 clk;
    endproperty
    p_data_out_implies_clk_k5: assert property (p_data_out_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_data_out_implies_tx_valid_k5;
        @(posedge clk) disable iff (!rst_n)
        data_out |=> ##5 tx_valid;
    endproperty
    p_data_out_implies_tx_valid_k5: assert property (p_data_out_implies_tx_valid_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_irq_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        irq |=> ##5 clk;
    endproperty
    p_irq_implies_clk_k5: assert property (p_irq_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_irq_implies_irq_ack_k5;
        @(posedge clk) disable iff (!rst_n)
        irq |=> ##5 irq_ack;
    endproperty
    p_irq_implies_irq_ack_k5: assert property (p_irq_implies_irq_ack_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_mem_addr_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        mem_addr |=> ##5 clk;
    endproperty
    p_mem_addr_implies_clk_k5: assert property (p_mem_addr_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_mem_addr_implies_rd_en_k5;
        @(posedge clk) disable iff (!rst_n)
        mem_addr |=> ##5 rd_en;
    endproperty
    p_mem_addr_implies_rd_en_k5: assert property (p_mem_addr_implies_rd_en_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_rd_en_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        rd_en |=> ##5 clk;
    endproperty
    p_rd_en_implies_clk_k5: assert property (p_rd_en_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_rd_en_implies_data_out_k5;
        @(posedge clk) disable iff (!rst_n)
        rd_en |=> ##5 data_out;
    endproperty
    p_rd_en_implies_data_out_k5: assert property (p_rd_en_implies_data_out_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_rst_n_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        rst_n |=> ##5 clk;
    endproperty
    p_rst_n_implies_clk_k5: assert property (p_rst_n_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_rx_ready_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        rx_ready |=> ##5 clk;
    endproperty
    p_rx_ready_implies_clk_k5: assert property (p_rx_ready_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_rx_ready_implies_irq_k5;
        @(posedge clk) disable iff (!rst_n)
        rx_ready |=> ##5 irq;
    endproperty
    p_rx_ready_implies_irq_k5: assert property (p_rx_ready_implies_irq_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_tx_valid_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        tx_valid |=> ##5 clk;
    endproperty
    p_tx_valid_implies_clk_k5: assert property (p_tx_valid_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_tx_valid_implies_rx_ready_k5;
        @(posedge clk) disable iff (!rst_n)
        tx_valid |=> ##5 rx_ready;
    endproperty
    p_tx_valid_implies_rx_ready_k5: assert property (p_tx_valid_implies_rx_ready_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_wr_en_implies_clk_k5;
        @(posedge clk) disable iff (!rst_n)
        wr_en |=> ##5 clk;
    endproperty
    p_wr_en_implies_clk_k5: assert property (p_wr_en_implies_clk_k5);

    // Confidence: 100.0%  |  Offset: 5 cycle(s)
    property p_wr_en_implies_mem_addr_k5;
        @(posedge clk) disable iff (!rst_n)
        wr_en |=> ##5 mem_addr;
    endproperty
    p_wr_en_implies_mem_addr_k5: assert property (p_wr_en_implies_mem_addr_k5);

endmodule
