# 非整数倍数据位宽转换24 to 128（还能优化，还不是最终版本，能过测试是能过的）

### 24 和128的最小公倍数是多少？是 384 384/24 = 16
  - 所以16个输入 对应3个输出 成为一个周期
  - 需要一个data_locker 去锁存数据，大小是128bit

### 输出逻辑 
  - 打五拍，第一个然后截取第六个输入的前八位给第一个输出
    也就是： 24*5 + 8 = 128 正确，余下16（24-8）位
  - 第六拍剩余的16 + 4拍整的 96 + 第 11 拍的前16拍  16+96 + 18 = 128
  - 第11拍剩下8个 + 后整5拍 一共128

## 状态机

### 老规矩 always_ff 
  [3:0] cnt， 如果valid 自增1，增到15再归零

### always_ff 
  - 用来锁存data， 如果valid，将data_in 放低位
  - 所以应该是data_locker <= {data_locker[103 : 0], data_in}

### always_ff
  - 用来控制输出data_out 和valid out。参照输出逻辑写就好了
  - 多写一点儿：当cnt = 5/10/15 以及valid_in 拉高的时候，拉高valid_out
  - 第一次的数据拼接是 {locker[119:0], data_in[23:16]}
  - 第二次拼接的数据是 {locker[111:0], data_in[23:8]}
  - 第三次拼接的数据是 {locker[103:0], data_in}
