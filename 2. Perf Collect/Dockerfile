#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2-stretch-slim AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS http://+:80

RUN apt-get update \
    && apt-get install -y procps \
    && curl -OL http://aka.ms/perfcollect \
    && chmod +x perfcollect \
    && ./perfcollect install

ENV COMPlus_PerfMapEnabled 1
ENV COMPlus_EnableEventLog 1


FROM mcr.microsoft.com/dotnet/core/sdk:2.2-stretch AS build
ADD start_perfcollect.sh  /app/start_perfcollect.sh
WORKDIR /src
COPY ["DiagnosticScenariosPerfCollect.csproj", ""]
RUN dotnet restore "./DiagnosticScenariosPerfCollect.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DiagnosticScenariosPerfCollect.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DiagnosticScenariosPerfCollect.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DiagnosticScenariosPerfCollect.dll"]