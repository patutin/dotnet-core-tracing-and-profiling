
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS base
WORKDIR /app
EXPOSE 80

ENV ASPNETCORE_URLS http://+:80

RUN dotnet tool install -g dotnet-symbol
RUN dotnet tool install -g dotnet-trace
RUN dotnet tool install -g dotnet-counters
RUN dotnet tool install -g dotnet-dump

RUN ulimit -c unlimited

ENV PATH="/root/.dotnet/tools:${PATH}"



FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
ADD *.sh  /app/
WORKDIR /src
COPY ["Diagnostic.csproj", ""]
RUN dotnet restore "./Diagnostic.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "Diagnostic.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Diagnostic.csproj" -c Release -o /app/publish

FROM base AS final

WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Diagnostic.dll"]