module control_unit(
    input clk, reset,
    output reg [2:0] state
);

    parameter IDLE = 3'd0,
              COMPUTE = 3'd1,
              ASSIGN = 3'd2,
              DONE = 3'd3;

    reg [1:0] counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end
        else begin
            counter <= counter + 1;

            // Slow down transitions for visibility
            if (counter == 2) begin
                case(state)
                    IDLE: state <= COMPUTE;
                    COMPUTE: state <= ASSIGN;
                    ASSIGN: state <= DONE;
                    DONE: state <= DONE;
                endcase
                counter <= 0;
            end
        end
    end

endmodule