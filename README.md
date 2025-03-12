# Decentralized Prescription Drug Tracking System

A blockchain-based solution for managing prescription drugs from issuance to patient usage, built on the Stacks blockchain using Clarity smart contracts.

## Overview

This system provides a set of smart contracts to handle various aspects of prescription drug tracking:

1. Prescription Issuance
2. Pharmacy Fulfillment
3. Patient Usage Tracking
4. Opioid Control

These contracts work together to create a transparent, efficient, and secure prescription drug management system.

## Contracts

### Prescription Issuance Contract

Manages the creation and lifecycle of prescriptions.

Key functions:
- `issue-prescription`: Create a new prescription
- `is-prescription-valid`: Check if a prescription is currently valid

### Pharmacy Fulfillment Contract

Handles the fulfillment of prescriptions by pharmacies.

Key functions:
- `fulfill-prescription`: Record the fulfillment of a prescription
- `get-prescription-fulfillments`: Retrieve fulfillment history for a prescription

### Patient Usage Contract

Manages the logging of medication usage by patients.

Key functions:
- `log-medication-usage`: Record a patient's medication usage
- `get-patient-usage-logs`: Retrieve usage logs for a patient

### Opioid Control Contract

Implements special controls and tracking for opioid prescriptions.

Key functions:
- `register-opioid-prescription`: Register a new opioid prescription
- `update-opioid-fulfillment`: Update the fulfillment status of an opioid prescription
- `check-opioid-limit`: Check if a patient has reached their opioid limit

## Getting Started

1. Clone this repository
2. Install dependencies (if any)
3. Deploy the contracts to a Stacks blockchain network
4. Interact with the contracts using a Stacks wallet or custom frontend

## Testing

Each contract has its own test file in the `tests` directory:

- `prescription-issuance.test.ts`
- `pharmacy-fulfillment.test.ts`
- `patient-usage.test.ts`
- `opioid-control.test.ts`

To run the tests:

1. Ensure you have Vitest installed
2. Run `npm test` or `yarn test` in the project directory

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.

