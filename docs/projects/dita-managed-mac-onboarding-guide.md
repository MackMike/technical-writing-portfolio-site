# DITA Sample: Getting Started with Your Managed Mac

## Overview

This sample presents a DITA-based adaptation of an end-user macOS onboarding guide for employees receiving a company-managed Mac. The original documentation was written as a linear Markdown guide. This version restructures the same onboarding scenario into a modular DITA documentation set using separate topic types and a DITA map.

The sample covers common onboarding tasks such as connecting to Wi-Fi, signing in with a company account, completing multi-factor authentication (MFA), allowing managed setup to finish, connecting to Zscaler, accessing Microsoft 365 applications, using Self Service, confirming setup readiness, and troubleshooting common issues.

Rather than presenting the content as a single continuous guide, this sample organizes the information into reusable XML topics based on content type.

---

## Why This Sample Is Presented as Source

DITA is a structured XML authoring format used to create modular documentation that can be published in multiple output formats. Because this portfolio sample is intended to demonstrate foundational DITA authoring skills, it is presented as source rather than rendered HTML output.

Presenting the source files makes it possible to show:

- Topic-based organization
- Separation of concept, task, reference, and troubleshooting content
- Use of a DITA map to organize a documentation set
- Basic structured XML authoring practices
- Adaptation of an existing Markdown guide into modular DITA topics

For this sample, the structure of the documentation is part of the work being demonstrated.

---

## How to Read This Sample

If you are not familiar with DITA, the easiest way to review this sample is:

1. Open the **DITA map** first to see how the documentation set is organized.
2. Review the **concept topic** to see how explanatory information is separated from instructions.
3. Review one or two **task topics** to see how procedural steps are structured.
4. Review the **reference topics** to see how checklist and support information is organized.
5. Review the **troubleshooting topic** to see how common issues and remedies are grouped.

This approach shows how the original onboarding guide was divided into reusable topic types rather than written as a single linear document.

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

## View the Source Files on GitHub

Replace the placeholder links below with your actual GitHub URLs.

- **View DITA project folder:** [managed-mac-onboarding](https://github.com/MackMike/technical-writing-portfolio-site/tree/main/docs/assets/pdfs/dita/managed-mac-onboarding)
- **View DITA map:** [managed-mac-onboarding.ditamap](https://github.com/MackMike/technical-writing-portfolio-site/blob/main/docs/assets/pdfs/dita/managed-mac-onboarding/managed-mac-onboarding.ditamap)
- **View overview topic:** [managed-mac-overview.dita](https://github.com/MackMike/technical-writing-portfolio-site/blob/main/docs/assets/pdfs/dita/managed-mac-onboarding/topics/managed-mac-overview.dita)
- **View initial setup task:** [managed-mac-initial-setup.dita](https://github.com/MackMike/technical-writing-portfolio-site/blob/main/docs/assets/pdfs/dita/managed-mac-onboarding/topics/managed-mac-initial-setup.dita)
- **View troubleshooting topic:** [managed-mac-troubleshooting.dita](https://github.com/MackMike/technical-writing-portfolio-site/blob/main/docs/assets/pdfs/dita/managed-mac-onboarding/topics/managed-mac-troubleshooting.dita)

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

```
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
