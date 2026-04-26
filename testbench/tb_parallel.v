module tb_parallel;

    reg clk = 0;
    reg reset;

    reg [31:0] x_bus;
    reg [31:0] y_bus;

    reg [7:0] cx1 = 15, cy1 = 25;
    reg [7:0] cx2 = 50, cy2 = 60;

    wire [3:0] cluster_out;

    always #5 clk = ~clk;

    // DUT
    parallel_top #(4) uut (
        .clk(clk),
        .reset(reset),
        .x_bus(x_bus),
        .y_bus(y_bus),
        .cx1(cx1),
        .cy1(cy1),
        .cx2(cx2),
        .cy2(cy2),
        .cluster_out(cluster_out)
    );

    integer file;
    integer i;

    reg [7:0] x_rand;
    reg [7:0] y_rand;

    initial begin
        file = $fopen("results.txt", "w");

        if (file == 0) begin
            $display("ERROR: file not opened");
            $stop;
        end

        $display("Starting simulation...");

        for (i = 0; i < 40; i = i + 1) begin

            // Apply reset BEFORE each point
            reset = 1;
            #20;
            reset = 0;

            // Generate random point
            x_rand = $urandom % 100;
            y_rand = $urandom % 100;

            // Put in first slot only
            x_bus = {24'd0, x_rand};
            y_bus = {24'd0, y_rand};

            // Wait enough time for full FSM cycle
            #500;

            // Write output
            $fwrite(file, "%d %d %d\n", x_rand, y_rand, cluster_out[0]);

            // Debug print
            $display("Point %0d: (%0d, %0d) → cluster %0d",
                      i, x_rand, y_rand, cluster_out[0]);

        end

        $fclose(file);

        $display("DONE: results.txt generated");

        #50 $stop;
    end

endmodule