module tb_distance;

    reg [7:0] x = 10, y = 20;
    reg [7:0] cx = 15, cy = 25;
    wire [15:0] dist;

    distance_calc uut (
        .x(x), .y(y),
        .cx(cx), .cy(cy),
        .dist(dist)
    );

    initial begin
        #10;
        $display("Distance = %d", dist);
        #10 $stop;
    end

endmodule