# lunar
lua framework and utils

## lunar to do list
- [ ] call stack tracer
- [ ] log
- [ ] statechart
- [ ] components
- [ ] mvc
- [ ] coroutine extend
- [ ] module management 

## lunar code style
### 专有变量名
不允许外部命名采用, 为框架类代码专有命名的方式
> __class_name 类名\
> __pdatas 私有变量表, 用来存储私有成员变量 \
> __pfuncs 私有函数表, 用来存储私有函数, 不会主动创建, 一般不建议使用

### 全局变量名
大写字母，单词之间用 _分割
> NUMBER \
> COLOR_WRITE

### 局部变量名
小写字母，单词之间用 _分割
> local_value

### 类变量名
首字符m开头, 驼峰法
> m_valueType 

### 类静态变量名
首字符s开头, _后首字符大写, 驼峰法
> s_TypeName

### 函数
#### 普通函数
>* SetX()
>* setActorID() 
>* get_name()

上述的规范都可以

#### 私有函数
> 以 __ 开头（2个下划线），其他和普通函数一样 \
> __get_name()