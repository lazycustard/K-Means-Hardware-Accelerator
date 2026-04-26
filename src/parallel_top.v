module parallel_top #(parameter N = 4)(
    input clk, reset,

    // Packed inputs (N points)
    input [8*N-1:0] x_bus,
    input [8*N-1:0] y_bus,

    // Centroids
    input [7:0] cx1, cy1,
    input [7:0] cx2, cy2,

    output [N-1:0] cluster_out
);

genvar i;

generate
    for (i = 0; i < N; i = i + 1) begin : units

        wire [7:0] x_i;
        wire [7:0] y_i;

        // Slice each 8-bit value
        assign x_i = x_bus[8*i +: 8];
        assign y_i = y_bus[8*i +: 8];

        top_module u (
            .clk(clk),
            .reset(reset),
            .x(x_i),
            .y(y_i),
            .cx1(cx1),
            .cy1(cy1),
            .cx2(cx2),
            .cy2(cy2),
            .cluster_id(cluster_out[i])
        );

    end
endgenerate

endmodule