# Sample repo for Azure DevOps pipeline

This repo contains:
- src/ApiService (a minimal .NET class library)
- tests/ApiService.Tests (xUnit tests)
- src/WebClient (minimal Node.js project with Jest tests)
- azure-devops-pipeline.yml

## Prerequisites (locally)
- Git
- .NET SDK (8.0 or change TargetFramework)
- Node.js (>=16)
- npm

## Local steps to run tests/build
1. Clone or extract this repo.
2. .NET:
   - From repo root:
     dotnet restore src/ApiService/ApiService.sln
     dotnet build src/ApiService/ApiService.csproj -c Release
     dotnet test tests/ApiService.Tests/ApiService.Tests.csproj -c Release --logger "trx;LogFileName=test-results.trx" --results-directory ./TestResults

   - Test results will be in ./TestResults/test-results.trx

3. Node:
   - cd src/WebClient
   - npm ci
   - npm test
   - JUnit XML will be at src/WebClient/test-results/junit.xml

## Push to Azure DevOps and run pipeline (high-level)
1. Create a Project in Azure DevOps (or use existing).
2. Create a new repo (or push to existing).
   git remote add origin <your-repo-url>
   git branch -M main
   git push -u origin main

3. In Azure DevOps > Pipelines > Create Pipeline > choose repository and YAML
   - Select "Existing Azure Pipelines YAML file" and point to `azure-devops-pipeline.yml` in repo root.
4. Run the pipeline. After completion:
   - View build logs under the run -> Jobs -> job name -> steps -> logs.
   - Download published artifacts from the run -> Artifacts.
   - Test results are visible in the pipeline run under "Tests" if test publishing succeeded.

## Want me to generate this repo as a zip for you to download?
It's already packaged below as a zip file you can download and extract locally.
