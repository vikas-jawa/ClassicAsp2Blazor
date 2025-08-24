# ClassicAsp2Blazor 🧭

A practical guide and toolkit for migrating legacy Classic ASP applications to modern, component-based Blazor Server apps.

## 🚀 Project Goals

Classic ASP applications are still widely used in enterprise environments, but they lack the scalability, maintainability, and performance of modern web frameworks. This project aims to:

- Provide a structured migration path from Classic ASP to Blazor.
- Offer reusable components and patterns that replicate common ASP behaviors in Blazor.
- Demonstrate best practices for modernizing legacy codebases.

## 🛠️ Features

- ✅ Sample Classic ASP pages and their Blazor equivalents
- ✅ Common UI patterns re-implemented in Blazor
- ✅ Using Dapper in the project
- ✅ Customer create and view example
- ✅ Azure DevOps build pipeline
- ✅ Migration strategy 

## 📁 Project Structure

```plaintext
ClassicAsp2Blazor/
├── Src/                     # Legacy ASP pages for reference
├   ├── ClassicAsp2Blazor/   # Contains the sample project
├   ├── Tests/               # Contains sample unit and integration tests
├── Data/                    # Contains sample script
└── Pipelines/               # Contains sample Azure DevOps pipeline
```

## 🗄️ Data Migration Strategy
- The Data folder contains necessary structure to organize the data

### Schema
- This folder contains the script that can create tables. 

### Stored Procedures
- This folder contains sql scripts to create stored procedure

### Scripts
- This folder contains the scripts to run on database.  
- The first script run is `dbo.20250810184100_initialScriptExecution.sql`
- Scripts are created and the structure of the sql is `dbo.<yyyyMMddHHmmss>_<scriptname>.sq'`

### scriptRunner.ps1
- This is currently empty but based on the requirements, powershell script can be added to execute the scripts
- Based on timestamps, the the execution history is available in the `__ScriptExecutionHistory` table
- Add the record in the execution history where the `[ScriptVersion]` will be the timestamp part

## 📄 Pipelines (YAML sample)
- `azure-pipeline.yml` contains the sample that generates the artifacts

## 🧪 Testing
- Two projects available for adding `Unit Tests` and `Integration Test`
- These projects are run in the sample yml pipeline (above)

## 📁 Src

### Middleware
- Sample middleware added `RequestLoggingMiddleware.cs`

### Exceptions
- ServiceException class added to throw exception with id to front end.
- The id (GUID) will be displayed to the user when error occurs and that can be used by admin to trace the error in logs

### Models
- **DbParameters:** contains classes that will be used to pass parameters (properties name shoud map sql parameters)
- **Dtos:**         contains classes that will be used to return the data (properties name shoud map return columns names)
- **ViewModel:**    Can be used to display on the UI
- **ModelValidationExtension.cs:**  Contains the logic to find if the model is valid based on the DataAnnotations

### Services
- **Interface:** Contains interfaces including base class interface, which contains sqlconnection
- **Implementation:** Contains implementation of the interfaces

## 🛠️ Tools
Two of many NuGet Packages used in the project (but there are more):

### Serilog
- Logging package
- Configured in the `appsettings.json`
- More details: https://serilog.net/

### Dapper
Micro ORM
- Website: https://github.com/DapperLib/Dapper

## Architecture
![Architecture Diagram](https://github.com/vikas-jawa/ClassicAsp2Blazor/blob/main/Docs/architecture.png)

## Error
The shown guid can be found in the logs to trace the error

![Architecture Diagram](https://github.com/vikas-jawa/ClassicAsp2Blazor/blob/main/Docs/error.png)