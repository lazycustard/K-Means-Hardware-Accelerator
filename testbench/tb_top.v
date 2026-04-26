module tb_top;

    reg clk = 0;
    reg reset = 1;

    reg [7:0] x = 10, y = 20;
    reg [7:0] cx1 = 15, cy1 = 25;
    reg [7:0] cx2 = 50, cy2 = 60;

    wire cluster_id;

    // clock
    always #5 clk = ~clk;

    top_module uut (
        .clk(clk),
        .reset(reset),
        .x(x), .y(y),
        .cx1(cx1), .cy1(cy1),
        .cx2(cx2), .cy2(cy2),
        .cluster_id(cluster_id)
    );

    initial begin
        $display("Starting simulation...");

        #20 reset = 0;   // delay reset → see IDLE clearly
        #200 $stop;
    end

endmodule