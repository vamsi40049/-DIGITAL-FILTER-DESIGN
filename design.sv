module fir_filter #(parameter N = 4)(
    input logic clk,
    input logic rst,
    input logic signed [7:0] x_in,
    output logic signed [15:0] y_out
);

    logic signed [7:0] coeffs[N-1:0] = '{8'd2, 8'd4, 8'd4, 8'd2};  // Example coefficients
    logic signed [7:0] shift_reg[N-1:0];
    logic signed [15:0] acc;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            for (int i = 0; i < N; i++)
                shift_reg[i] <= 0;
            y_out <= 0;
        end else begin
            for (int i = N-1; i > 0; i--)
                shift_reg[i] <= shift_reg[i-1];
            shift_reg[0] <= x_in;

            acc = 0;
            for (int i = 0; i < N; i++)
                acc += coeffs[i] * shift_reg[i];

            y_out <= acc;
        end
    end
endmodule
