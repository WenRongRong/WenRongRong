# 记录
## 1. alpha-expression
库函数，主要计算了：
- log函数
- sign符号函数
- rank 排序
- delay 移动
- ts_cov协方差
- ts-std 标准差
- ts_corr相关系数
- scale 归一
- ts_delta 序列差值
- ts_signed_power带符号的指数
- ts_wgt_sum 加权求和
- ts_wgt_mean加权求平均
- ts_tma 时间移动平均
- ts_tms时间移动求和
- ts_..时间序列最大值、最小值、均值、中位数、等
- ts_rank 时间序列窗口排序
    
    这里用到了一个bottleneck.move.move_rank[这个模块参考这里](https://bottleneck.readthedocs.io/en/latest/bottleneck.move.html)
- ts_sum 时间序列窗口滚动求和
- ts_prod 乘积，686行，为啥我感觉这个符号不对呢？
- 

## 2.alpha-expression-test
[单元测试框架](https://docs.python.org/zh-tw/3/library/unittest.html)
