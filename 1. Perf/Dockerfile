#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 443

RUN apt-get update \
    && apt-get install -y linux-tools procps git

RUN git clone --depth 1 https://github.com/brendangregg/FlameGraph

ENV COMPlus_PerfMapEnabled 1
ENV COMPlus_EnableEventLog 1
ENV applicationUrl https://localhost:443


FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
ADD start_perf.sh  /app/start_perf.sh
WORKDIR /src
COPY ["DiagnosticScenariosPerf.csproj", ""]
RUN dotnet restore "./DiagnosticScenariosPerf.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DiagnosticScenariosPerf.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DiagnosticScenariosPerf.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DiagnosticScenariosPerf.dll"]