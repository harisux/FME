`timescale 1 ns / 1 ps

module buffer_enteros_tst;

localparam bit_depth = 8;
localparam width_fil = 16;
localparam width_col = 16;

//señales del dut
reg clk, rst, wr, en;
reg [bit_depth*width_col-1:0] fila_in;
wire [bit_depth*width_col-1:0] fila_out;

//señales, constantes, variables
reg [bit_depth-1:0] rand_val [0:width_fil-1];
integer error_flag = 0;
integer i,j;

//instanciamos el dut
buffer_enteros #(.bit_depth(bit_depth), .width_fil(width_fil), .width_col(width_col))
dut (.clk(clk), .rst(rst), .fila_in(fila_in), .wr(wr), .en(en), .fila_out(fila_out));

//clock y reset
initial 
begin 
	rst = 1'b0;
	#20 rst = 1'b1;
	forever
	begin
		#5 clk = 1'b1;
		#5 clk = 1'b0;
	end
end	

//Monitor y generación del waveform
initial // monitor
	begin: MONITOR
		integer mcd;
		mcd = $fopen("monitor.txt");
		$fmonitor(mcd, "TIME: %0t, fila_in: %h", $realtime, fila_in);
		$fmonitor(mcd, "TIME: %0t, wr: %b", $realtime, wr);
		$fmonitor(mcd, "TIME: %0t, en: %b", $realtime, en);						
		$fmonitor(mcd, "TIME: %0t, fila_out: %h", $realtime, fila_out);			
		//$dumpfile();
		//$dumpvars (1, dut);
		//$dumpports(dut);
	end

//Comparacion de valores esperados y obtenidos
task expect; 
	input [bit_depth*width_col-1:0] expect_fila_out;

	if (fila_out !== expect_fila_out)
  	begin
			$display("\t Error!!");			
			$display("\t \t fila_out => Expected: %h, Got: %h", expect_fila_out, fila_out);
			$display("\t TIME: %0t", $realtime);
			error_flag = 1;   
		end 
endtask

//Generacion de filas de entrada
function [bit_depth*width_col-1:0] gen_fila_in;
  input [bit_depth-1:0] val;
  integer k;
  begin
    for (k=0; k<=width_col-1; k=k+1)    
      gen_fila_in[bit_depth*k +: bit_depth] = val;      
  end
endfunction

//codigo de test (estimulos)
initial 
  begin
    #30;
    en = 1'b1;        
    wr = 1'b0; //Escritura           
    #160; //16 periodos de clock     
    wr = 1'b1;//Lectura
  end
  
initial
  begin: TEST    
    #20; //20-2.5 (5 unidades, centrado en el flanco de subida)
          
    //Escribimos en el buffer    
    $display("***************Escritura***************");
    for (i=0; i<=width_fil-1; i=i+1)   
    begin
      rand_val[i] = $urandom(i)%255;     
      $display ("Entrada: %h", gen_fila_in(rand_val[i]));
      $display("\t TIME: %0t", $realtime);
      #10 fila_in = gen_fila_in(rand_val[i]);
    end   
    
    //#5; //Centrado en el flanco de bajada
    
    //Leemos del buffer
    $display("****************Lectura****************");         
    for (i=0; i<=width_fil-1; i=i+1)      
      #10 expect(gen_fila_in(rand_val[i]));    
     
    if (error_flag !== 1)
      $display ("TEST PASSED");			
    
  end

endmodule


