module comparator(
    input [15:0] d1, d2,
    output reg cluster_id
);

    always @(*) begin
        if (d1 < d2)
            cluster_id = 0;
        else
            cluster_id = 1;
    end

endmodule