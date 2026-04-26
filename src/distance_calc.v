module distance_calc(
    input [7:0] x, y,
    input [7:0] cx, cy,
    output [15:0] dist
);

    wire [7:0] dx, dy;

    assign dx = (x > cx) ? (x - cx) : (cx - x);
    assign dy = (y > cy) ? (y - cy) : (cy - y);

    assign dist = dx*dx + dy*dy;

endmodule