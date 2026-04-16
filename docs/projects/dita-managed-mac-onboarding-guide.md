# DITA Sample: Getting Started with Your Managed Mac

## Overview

This sample presents a DITA-based adaptation of an end-user macOS onboarding guide for employees receiving a company-managed Mac. The original documentation was written as a linear Markdown guide. This version restructures the same onboarding scenario into a modular DITA documentation set using separate topic types and a DITA map.

The sample covers common onboarding tasks such as connecting to Wi-Fi, signing in with a company account, completing multi-factor authentication (MFA), allowing managed setup to finish, connecting to Zscaler, accessing Microsoft 365 applications, using Self Service, confirming setup readiness, and troubleshooting common issues.

Rather than presenting the content as a single continuous guide, this sample organizes the information into reusable XML topics based on content type.

---

## DITA Documentation Set Structure

This sample includes the following DITA components:

### DITA map
- `managed-mac-onboarding.ditamap`

### Concept topic
- `managed-mac-overview.dita`

### Reference topics
- `managed-mac-prerequisites.dita`
- `managed-mac-readiness-check.dita`
- `managed-mac-support-info.dita`

### Task topics
- `managed-mac-initial-setup.dita`
- `managed-mac-zscaler.dita`
- `managed-mac-apps.dita`

### Troubleshooting topic
- `managed-mac-troubleshooting.dita`

---

## What This Sample Demonstrates

This sample demonstrates how onboarding documentation can be adapted into a structured authoring format using DITA. It shows:

- Topic-based writing
- Separation of concept, task, reference, and troubleshooting content
- Structured XML authoring
- DITA map organization
- Modular documentation design
- Adaptation of existing Markdown content into DITA

---

## Why This Matters

This sample shows how the same documentation problem can be approached in two formats:

- A Markdown-based quick-start guide for end users
- A DITA-based modular documentation set using structured XML

Together, these samples demonstrate flexibility across documentation formats and an understanding of both user-focused writing and structured content principles.

---

## Source File Location

The DITA source files for this sample are stored in the portfolio repository under:

`docs/assets/dita/managed-mac-onboarding/`

---

## View the Source Files

- **View DITA project folder:** [managed-mac-onboarding](../assets/pdfs/dita/managed-mac-onboarding/)
- **View DITA map:** [managed-mac-onboarding.ditamap](../assets/dita/managed-mac-onboarding/managed-mac-onboarding.ditamap)
- **View overview topic:** [managed-mac-overview.dita](../assets/dita/managed-mac-onboarding/topics/managed-mac-overview.dita)
- **View initial setup task:** [managed-mac-initial-setup.dita](../assets/dita/managed-mac-onboarding/topics/managed-mac-initial-setup.dita)
- **View troubleshooting topic:** [managed-mac-troubleshooting.dita](../assets/dita/managed-mac-onboarding/topics/managed-mac-troubleshooting.dita)

---

## Example Topic Breakdown

Below is the topic organization used in this sample:

| Topic | Type | Purpose |
|---|---|---|
| `managed-mac-overview.dita` | Concept | Explains what managed Mac setup includes |
| `managed-mac-prerequisites.dita` | Reference | Lists required information and setup items |
| `managed-mac-initial-setup.dita` | Task | Guides the user through first-time setup |
| `managed-mac-zscaler.dita` | Task | Explains how to connect to Zscaler |
| `managed-mac-apps.dita` | Task | Covers Microsoft 365 access and Self Service |
| `managed-mac-readiness-check.dita` | Reference | Provides a setup completion checklist |
| `managed-mac-support-info.dita` | Reference | Explains when to contact IT and what to provide |
| `managed-mac-troubleshooting.dita` | Troubleshooting | Organizes common issues and remedies |

---

## Sample XML Excerpt

Example from the task topic `managed-mac-initial-setup.dita`:

```xml
<task id="managed-mac-initial-setup">
  <title>Set Up Your Managed Mac for First Use</title>
  <shortdesc>Follow these steps to power on the Mac, connect to Wi-Fi, sign in, complete MFA, and allow managed setup to finish.</shortdesc>
  <taskbody>
    <prereq>
      <p>Make sure you have your company email address, password, MFA method, access to Wi-Fi, and your Mac power adapter before you begin.</p>
    </prereq>
    <steps>
      <step>
        <cmd>Connect the Mac to a power source using the provided adapter.</cmd>
      </step>
      <step>
        <cmd>Turn on the Mac and follow the setup screens until you are prompted to connect to Wi-Fi or sign in.</cmd>
      </step>
    </steps>
  </taskbody>
</task>
```

This excerpt shows how procedural content is structured in DITA, using a task topic, short description, prerequisites, and ordered steps.

## Notes
This sample was created as a foundational DITA writing project for a technical writing portfolio. The scope was intentionally limited to core DITA topic types and map structure in order to demonstrate basic structured authoring concepts clearly.

If needed, this sample could later be expanded to include content reuse, conditional processing, or generated output using a DITA publishing toolchain.
