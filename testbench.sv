module fir_filter_tb;

    logic clk, rst;
    logic signed [7:0] x_in;
    logic signed [15:0] y_out;

    fir_filter #(.N(4)) dut(.clk(clk), .rst(rst), .x_in(x_in), .y_out(y_out));

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        x_in = 0;
        #10;
        rst = 0;

        repeat (8) begin
            @(posedge clk);
            x_in = $random % 20;
            $display("Time %0t | Input = %0d | Output = %0d", $time, x_in, y_out);
        end

        #20;
        $finish;
    end
endmodule
