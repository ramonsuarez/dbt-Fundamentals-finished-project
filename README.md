# dbt Fundamentals for Microsoft Fabric

This is an adapted version of the dbt Fundamentals course materials, configured to work with Microsoft Fabric's SQL analytics endpoint using the dbt-fabric connector.

## Prerequisites

1. **Microsoft Fabric Environment**
   - Access to a Microsoft Fabric workspace with admin privileges
   - A Warehouse for the project.

2. **Service Principal Setup**
   ```powershell
   # Create a service principal in Azure AD
   $sp = New-AzADServicePrincipal -DisplayName "dbt-fabric-sp"
   
   # Get the service principal details
   $sp | Select-Object DisplayName, ApplicationId, Secret
   ```
   - Note the `ApplicationId` (client_id) and `Secret` (client_secret)
   - Grant this service principal admin access to your Fabric workspace

3. **Local Development Environment**
   - Python 3.8+ installed
   - dbt-core and dbt-fabric packages
   - git for version control

## Setup Instructions

### Option 1: dbt Cloud Setup (Recommended)

1. **Connect to Your Repository**
   - Log in to your dbt Cloud account
   - Click "New Project" and select "Version Control"
   - Connect to your GitHub/GitLab repository
   - Select the repository containing this project

2. **Configure dbt Connection**
   - In dbt Cloud, go to "Settings" > "Project Settings"
   - Under "Connection", select "Microsoft Fabric"
   - Enter your connection details:
     - Server: `your-workspace-name-here.azuresynapse.net`
     - Database: `your-database-name`
     - Schema: `dbo`
     - Authentication: Service Principal
     - Tenant ID: `your-azure-ad-tenant-id`
     - Client ID: `your-service-principal-client-id`
     - Client Secret: `your-service-principal-secret`

3. **Configure dbt Project**
   - Set the dbt project directory to `/` (root)
   - Set the dbt profile directory to `/`
   - Set the target schema to `dbt_<your_username>` or similar

### Option 2: Local Development (Untested)

*Note: These CLI instructions are provided for reference but have not been fully tested with this project.*

1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-username/dbt-Fundamentals-finished-project.git
   cd dbt-Fundamentals-finished-project
   ```

2. **Create a Virtual Environment**
   ```bash
   python -m venv venv
   .\venv\Scripts\activate  # On Windows
   source venv/bin/activate  # On macOS/Linux
   ```

3. **Install Dependencies**
   ```bash
   pip install dbt-core dbt-fabric
   pip install -r requirements.txt  # If you have additional requirements
   ```

4. **Configure dbt**
   Create or update `~/.dbt/profiles.yml` with your Fabric connection details:
   ```yaml
   dbt_course_in_fabric:
     target: dev
     outputs:
       dev:
         type: fabric
         driver: 'ODBC Driver 17 for SQL Server'
         server: your-workspace-name-here.azuresynapse.net
         database: your-database-name
         schema: dbo
         authentication: serviceprincipal
         tenant_id: your-azure-ad-tenant-id
         client_id: your-service-principal-client-id
         client_secret: your-service-principal-secret
         encrypt: true
         trust_cert: true
   ```

## Loading Sample Data

### dbt Cloud Instructions

1. **Prepare Your Fabric Environment**
   - Ensure you have a Warehouse (not a Lakehouse) in your Fabric workspace
   - The project is pre-configured to use the Warehouse for all read/write operations
   - Note: The dbt-fabric connector can read from Lakehouse but requires a Warehouse for writing

2. **Running dbt Commands**
   - In dbt Cloud, go to "Develop"
   - Use the command bar at the bottom to run dbt commands
   - The project is configured to work with the Warehouse specified in the project files

3. **Common Commands**
   - To load seed data:
     ```bash
     dbt seed
     ```
   - To run specific models:
     ```bash
     dbt run --select staging.jaffle_shop
     ```
   - To run tests:
     ```bash
     dbt test --models stg_jaffle_shop__customers
     ```
   - To generate documentation:
     ```bash
     dbt docs generate
     dbt docs serve
     ```

4. **Important Notes**
   - Run commands one at a time in the command bar
   - The UI doesn't support running the entire project with a single click
   - You'll need to run models in the correct order (staging → marts)
   - Check the command output for any errors or warnings

### Local Development (Untested)
*Note: These CLI instructions are provided for reference but have not been fully tested with this project.*

1. **Prepare Your Fabric Environment**
   - Create a new Lakehouse in your Fabric workspace
   - Note the SQL endpoint details

2. **Load Seed Data**
   ```bash
   # Run all seeds
   dbt seed --target dev
   
   # Or run specific seeds
   dbt seed --select jaffle_shop --target dev
   ```

3. **Run Models**
   ```bash
   # Run all models
   dbt run --target dev
   
   # Run specific models
   dbt run --models staging.jaffle_shop --target dev
   ```

4. **Run Tests**
   ```bash
   # Run all tests
   dbt test --target dev
   
   # Run specific tests
   dbt test --models stg_jaffle_shop__customers --target dev
   ```

5. **Generate Documentation**
   ```bash
   dbt docs generate --target dev
   dbt docs serve
   ```

## Project Structure

```
models/
├── marts/                 # Dimensional models
│   ├── dim_customers.sql
│   ├── dim_product_supplies.sql
│   ├── fct_orders_v1.sql
│   └── fct_orders_v2.sql
├── staging/               # Staging models
│   ├── jaffle_shop/      # Jaffle Shop source data
│   └── stripe/           # Stripe payment data
seeds/                    # Seed data files
├── jaffleshop/
│   ├── raw_customers.csv
│   ├── raw_orders.csv
│   └── ...
tests/                     # Data quality tests
macros/                    # Custom macros
snapshots/                 # Snapshots for SCD Type 2
```

## Adaptations for Fabric

- **Data Types**: Modified to be compatible with Fabric SQL
- **Authentication**: Configured for service principal authentication
- **Materializations**: Optimized view and table materializations for Fabric
- **Seeds**: Included sample data for Jaffle Shop and Stripe

## Troubleshooting

1. **Connection Issues**
   - Verify service principal has admin access to the Fabric workspace
   - Check that the SQL endpoint is running
   - Ensure the ODBC driver is installed

2. **Performance**
   - For large datasets, consider increasing the Fabric capacity
   - Use incremental models for large fact tables

## Resources

- [dbt Documentation](https://docs.getdbt.com/docs/introduction)
- [Microsoft Fabric Documentation](https://learn.microsoft.com/en-us/fabric/)
- [dbt-fabric Documentation](https://docs.getdbt.com/reference/warehouse-setups/fabric-setup)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
