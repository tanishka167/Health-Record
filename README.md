# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

## Getting Started

To get this DApp running, follow the steps below:

### Clone the Repository

```
git clone <repository-url>
```

### Contract Compilation and Deployment

1. Install dependencies:
   ```
   npm install
   ```

2. Compile the contracts:
   ```
   npx hardhat compile
   ```

3. Create a `.env` file:
   - Mention the QuickNode Goerli/Sepoli URL and your private key in the `.env` file.

4. Deploy the smart contract:
   ```
   npx hardhat run scripts/finalDeploy.js --network <network-name>
   ```
   Replace `<network-name>` with the desired network (e.g., Goerli, Sepoli).

### Frontend Setup

1. Ensure you have MetaMask installed in your browser.

2. Navigate to the `client` directory:
   ```
   cd client
   ```

3. Install frontend dependencies:
   ```
   npm install
   ```

4. Start the frontend server:
   ```
   npm start
   ```
## Contributors

- **Prakhar Srivastava** - [ThePrakhar-7717](https://github.com/ThePrakhar-7717)

- Thank you for your support and contributions!
