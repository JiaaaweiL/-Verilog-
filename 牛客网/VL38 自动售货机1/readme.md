这个题有问题。会有latch  
next_state = next_state;////?????

仔细看时序图
![image](https://github.com/user-attachments/assets/6f4bb87f-e626-43ca-af75-bf1cc1217fdb)



每一个input只对应半个CC，如果没有latch的话，要状态转移的状态机用时钟下沿采样
