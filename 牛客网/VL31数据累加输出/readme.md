# 这题一堆坑

### 第一个block always_ff 
首先是：需要一个cnt，来记载如果到4（0，1，2，3） valid_b就可以拉高了  
如果 valid_a && ready_a， 则cnt自加  

### 第二个block always_ff 控制valid_b
valid_b拉高的必要条件：
  - 1. cnt 如果是3， 并且valid_a 和 valid_b都是高，则valid_b 可以拉高了
  - 2. 如果ready_b && valid_b 则valid_b拉低(代表和下游握手完成)

### 第三个block always_ff 控制data_out
  - 如果valid_a ready_a ready_b valid_b 都拉高，则data_out<= data_in
    valid_a  ready_a 代表着上游有效，ready_b valid_b 拉高代表下游握手完成，则下一个cc必将是开始的第一个cc
    因此输出等于输入  
  - 如果valid_a ready_a 拉高， data_out <= data_out + data_in

### 最后一个assign 控制ready_a
  - 题目的要求是不能阻塞。所以下游但凡是ready的，上游必须ready。
  - 只要累加器没有valid_b输出（意味着，还可以接受加法），则一定能接受输入
  - 所以写成 ready_a = !valid_b | ready_b;
