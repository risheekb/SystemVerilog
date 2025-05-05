import os
test_list = ["test_ch0_sanity","test_all_ch","test_reg_reset","test_wr_rd","test_cmd_list"]


def compile():
  os.system("vlog  +incdir+../../dma_axi64 +incdir+../TOP +incdir+../AXI +incdir+../APB +incdir+../REG +incdir+../PERIPH +incdir+../REF ../TOP/top.sv") 

def elaborate_run(test_name):
  os.system('vsim -c -voptargs=+acc work.top +test_name={0} -do "run -all"'.format(test_name))
  os.system("run -all")



if __name__ == "__main__":
  for test in test_list:
    compile()
    elaborate_run(test)


