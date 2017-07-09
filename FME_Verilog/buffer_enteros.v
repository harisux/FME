`timescale 1 ns / 1 ps

module buffer_enteros
  #(parameter bit_depth = 8,
		parameter width_fil = 16,
		parameter width_col = 16)

	 (input wire clk, rst,
	  input wire [bit_depth*width_col-1:0] fila_in,
	  input wire wr, en,
	  output wire [bit_depth*width_col-1:0] fila_out
	 );

//Arreglo 2D registros (de 8 bits)
reg [bit_depth-1:0] mem_reg [0:width_fil-1] [0:width_col-1];
reg [bit_depth-1:0] mem_next [0:width_fil-1] [0:width_col-1];

//Arreglos 2D de entrada y salida
wire [bit_depth-1:0] fila_in_ar [0:width_col-1];
reg [bit_depth-1:0] fila_out_ar [0:width_col-1];

//variables de iteración
integer i,j; 
genvar k;

//Rellenamos el arreglo de entrada
generate
  for (k=0; k<=width_col-1; k=k+1) 
  begin: f1
    assign fila_in_ar[k] = fila_in[bit_depth*k +: bit_depth];
  end
endgenerate

always @(posedge clk, negedge rst) 
begin  
	if (!rst) //se activa en baja
	  begin 		
 	    for (i=0; i<=width_fil-1; i=i+1)
	      begin
	        for (j=0; j<=width_col-1; j=j+1)
		        mem_reg[i][j] <= {bit_depth{1'b0}};
		    end
	  end						
	else if (en)
	  begin
      for (i=0; i<=width_fil-1; i=i+1)
        begin
          for (j=0; j<=width_col-1; j=j+1)
            mem_reg[i][j] <= mem_next[i][j];
        end				
    end
end

//Logica de valor siguiente
always @(*)
begin
	//valor siguiente de la primera fila de registros
	if (!wr) //Escritura
	  begin				
		  for (j=0; j<=width_col-1; j=j+1)		
			  mem_next[0][j] = fila_in_ar[j];
		end
	else //Lectura
		begin
		  for (j=0; j<=width_col-1; j=j+1)
			  mem_next[0][j] = mem_reg[width_fil-1][j];	
	  end
	//valor siguiente de las demas filas
	for (i=1; i<=width_fil-1; i=i+1)
	  begin	 
			for (j=0; j<=width_col-1; j=j+1)
				mem_next[i][j] <= mem_reg[i-1][j];
	  end  
end

//Arreglo de salida
always @(*)
begin
	for (j=0; j<=width_col-1; j=j+1)
		fila_out_ar[j] = mem_reg[width_fil-1][j];
end

//Salida
generate
  for (k=0; k<=width_col-1; k=k+1) 
  begin: f2
    assign fila_out[bit_depth*k +: bit_depth] = fila_out_ar[k];
  end
endgenerate

endmodule


