for i in range(32):
    # print(f".in{i:02d}({{in[N-1:{i}], {{{i}{{1'b0}}}}}}),") #Shift left logical
    # print(f".in{i:02d}({{{{{i}{{1'b0}}}}, in[N-1:{i}]}}),") #Shift right logical
    # print(f".in{i:02d}({{{{{i}{{in[N-1]}}}}, {{in[N-1:{i}]}}}}),") #Shift right arithmetic
    print(f"x{i:02d} = decoder[{i}] ? wr_data:x{i:02};")
