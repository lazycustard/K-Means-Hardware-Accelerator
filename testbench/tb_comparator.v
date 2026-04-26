module tb_comparator;

    reg [15:0] d1 = 50;
    reg [15:0] d2 = 80;
    wire cluster_id;

    comparator uut (
        .d1(d1),
        .d2(d2),
        .cluster_id(cluster_id)
    );

    initial begin
        #10;
        $display("Cluster = %d", cluster_id);
        #10 $stop;
    end

endmodule