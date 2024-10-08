# 使用基础镜像，例如 Python 3.9 的镜像
FROM python:3.9-slim

# 安装任何其他必要的工具或依赖项
RUN apt-get update && apt-get install -y git curl

# 设置 Jenkins Agent 所需的环境变量
ENV JENKINS_HOME /home/jenkins

# 创建 Jenkins 工作目录
RUN mkdir -p $JENKINS_HOME/agent && \
    chown -R root:root $JENKINS_HOME

# 将工作目录设为 Jenkins agent
WORKDIR $JENKINS_HOME/agent

# 默认执行 Jenkins Agent 的命令，保持容器运行
CMD ["cat"]
