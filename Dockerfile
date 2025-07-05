# Use uma imagem oficial do Python como imagem base.
# python:3.10-slim é uma boa escolha por ser leve.
# FROM python:3.10-slim
FROM python:3.13.4-alpine3.22

# Define o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Copia o arquivo de dependências para o diretório de trabalho.
COPY requirements.txt .

# Instala as dependências do projeto.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Expõe a porta 8000 para que a aplicação possa ser acessada de fora do contêiner.
EXPOSE 8000

# Comando de produção para executar a aplicação.
# Ele usa a variável de ambiente $PORT fornecida por plataformas como o Cloud Run.
# Se $PORT não estiver definida, ele usa 8000 como padrão (útil para testes locais).
# O 'exec' garante que o uvicorn receba os sinais do sistema corretamente.
CMD exec uvicorn app:app --host 0.0.0.0 --port ${PORT:-8000}