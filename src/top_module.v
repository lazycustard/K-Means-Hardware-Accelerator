module top_module(
    input clk, reset,
    input [7:0] x, y,
    input [7:0] cx1, cy1,
    input [7:0] cx2, cy2,
    output reg cluster_id
);

    wire [15:0] d1, d2;
    wire [2:0] state;
    wire comp_out;

    // FSM
    control_unit ctrl (
        .clk(clk),
        .reset(reset),
        .state(state)
    );

    // Distance calculations
    distance_calc dcalc1 (
        .x(x), .y(y),
        .cx(cx1), .cy(cy1),
        .dist(d1)
    );

    distance_calc dcalc2 (
        .x(x), .y(y),
        .cx(cx2), .cy(cy2),
        .dist(d2)
    );

    // Comparator
    comparator comp (
        .d1(d1),
        .d2(d2),
        .cluster_id(comp_out)
    );

    // Controlled output update
    always @(posedge clk or posedge reset) begin
        if (reset)
            cluster_id <= 0;
        else if (state == 3'd2) // ASSIGN state
            cluster_id <= comp_out;
    end

endmodule