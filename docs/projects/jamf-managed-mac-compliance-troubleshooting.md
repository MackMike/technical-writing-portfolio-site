# Troubleshooting Compliance Failures on Jamf-Managed Macs

This article describes how to diagnose and remediate a Jamf-managed Mac that appears noncompliant in Jamf Pro or in a downstream compliance workflow. Use it to determine whether the issue is caused by stale inventory, broken MDM enrollment, failed policy execution, missing configuration, or an actual device-state problem.

## Audience

- macOS device management engineers
- Desktop support technicians
- Help Desk teams supporting Jamf-managed Macs

## Scope

Use this workflow when a Mac:

- is marked noncompliant by Jamf-dependent controls or an integrated security platform
- loses access to corporate resources because of device state
- appears healthy locally but is missing required controls in Jamf Pro
- has stale or inconsistent inventory data

## Common Failure Domains

Most compliance failures fall into one of the following categories:

- stale inventory
- broken or incomplete MDM enrollment
- missing or failed configuration profile deployment
- failed Jamf policy execution
- FileVault or recovery key escrow failure
- unsupported macOS version
- missing required security tools
- delayed or failed MDM command execution

## Before You Begin

Collect the following:

- computer name
- serial number
- assigned user
- macOS version
- Jamf Pro **Last Check-In**
- Jamf Pro **Last Inventory Update**
- FileVault status
- recent policy failures
- recent lifecycle events such as erase, upgrade, hardware repair, or reenrollment

If available, also collect:

- the exact compliance error
- relevant policy logs
- profile deployment status
- screenshots of local profile or FileVault status

## Workflow Summary

Follow this sequence:

1. Confirm the Jamf Pro record is current
2. Validate MDM enrollment and profile presence
3. Check MDM command behavior
4. Compare local state to Jamf inventory
5. Validate FileVault and escrow
6. Review configuration profiles
7. Review Jamf policy execution
8. Confirm required security tools are healthy
9. Validate macOS version and update state
10. Apply remediation based on the identified failure domain
11. Re-enroll only if standard remediation does not restore management health

---

## 1. Confirm the Jamf Pro Record Is Current

In Jamf Pro, review the computer record.

Validate:

- **Last Check-In**
- **Last Inventory Update**
- management status
- assigned user
- recent scope changes affecting compliance

### Interpretation

- **Current check-in with stale inventory** usually points to recon failure or inventory submission issues.
- **Stale check-in and stale inventory** usually point to loss of management connectivity or broken enrollment.
- **Current record with failed compliance** usually means the Mac is enrolled but missing a required control.

### Remediation

If local access is available, submit fresh inventory:

```bash
sudo jamf recon
```

Then recheck the inventory timestamp in Jamf Pro.

If inventory updates successfully, verify whether the compliance status clears after downstream systems refresh.

If recon fails, continue to policy, enrollment, and profile validation.

---

## 2. Validate MDM Enrollment and Profile Presence

On the Mac:

1. Open **System Settings**
2. Go to **Privacy & Security**
3. Review **Profiles** or **Device Management**
4. Confirm the Jamf MDM profile is present

In Jamf Pro, confirm the device is still managed.

### Signs of Enrollment Problems

- the MDM profile is missing
- the Mac appears in Jamf Pro, but management actions fail
- the profile appears present locally, but the device does not receive commands
- the device was recently erased, restored, migrated, or manually unenrolled

### Remediation

If the MDM profile is missing or clearly invalid:

- do not start with policy troubleshooting
- verify whether the Mac was manually unenrolled
- verify whether Automated Device Enrollment is still expected for the device
- proceed to the **Re-enrollment** section if the MDM relationship is broken

If the profile is present, continue to MDM command validation.

---

## 3. Check MDM Command Behavior

In Jamf Pro, review recent MDM command history for the Mac.

Look for:

- pending commands that never complete
- failed profile installation commands
- repeated retries
- update-related commands that remain unacknowledged

### Interpretation

- unacknowledged commands may indicate a broken MDM channel
- successful command delivery with no local change may indicate a local device issue
- repeated profile command failures often point to enrollment or profile conflicts

### Remediation

If low-risk testing is allowed in your environment:

- send a simple MDM command
- confirm whether the command is acknowledged

If MDM commands consistently fail while the device appears online, move to profile and reenrollment remediation.

If commands succeed, continue with local state validation.

---

## 4. Compare Local State to Jamf Inventory

Do not assume Jamf inventory reflects the current local state.

Compare Jamf Pro data with the Mac for:

- macOS version
- FileVault status
- installed security tools
- profile presence
- user assignment, where relevant

### Remediation

If the local state is correct but Jamf is stale:

1. Run:

```bash
sudo jamf recon
```

2. Recheck the device record
3. Confirm any custom extension attributes update
4. Verify whether downstream compliance tooling has refreshed

If the local state is not correct, fix the underlying configuration issue rather than forcing repeated inventory updates.

---

## 5. Validate FileVault and Escrow

On the Mac, verify FileVault status:

```bash
fdesetup status
```

Or in System Settings:

1. Open **System Settings**
2. Go to **Privacy & Security**
3. Select **FileVault**

In Jamf Pro, verify:

- FileVault is reported as enabled
- the personal recovery key is escrowed, if required
- inventory reflects the current encryption state

### Common Failure Patterns

- FileVault is enabled locally but not reflected in Jamf Pro
- FileVault is enabled but recovery key escrow is missing
- FileVault is not enabled because the user never completed enablement
- token-related issues prevented activation

### Remediation

If FileVault is enabled locally but not reflected in Jamf:

- run ```sudo jamf recon```
- verify escrow workflow status
- confirm the Mac has checked in after enablement

If FileVault is not enabled:

- confirm the expected Jamf policy or configuration is still scoped
- verify whether deferred enablement requires a logout or restart
- review token dependencies if your environment uses workflows that depend on secure token or bootstrap token

If escrow is missing but FileVault is on:

- review the escrow workflow
- trigger the organization’s standard escrow remediation process
- do not assume full reenrollment is required unless escrow remediation fails and the MDM relationship is also unhealthy

---

## 6. Review Configuration Profiles

In Jamf Pro, confirm that required profiles are installed and current.

Typical profiles include:

- password policy
- restrictions
- certificates
- Wi-Fi or VPN
- PPPC payloads
- System Extensions
- Network Extensions
- organization-specific security settings

Locally, confirm the expected profiles are present in **Profiles** or **Device Management**.

### Common Failure Patterns

- a profile is scoped in Jamf but missing on the Mac
- a profile installation command failed
- a payload conflicts with another management source
- a profile is installed, but dependent approval is still missing
- a profile was removed locally or by a lifecycle event

### Remediation

If a required profile is missing:

1. Confirm the device is in scope
2. Confirm MDM commands are completing
3. Review whether a conflicting profile or another management source exists
4. Redeploy the profile from Jamf Pro if your workflow permits
5. Validate profile presence locally after redeployment

If the profile still does not install and MDM commands are failing, proceed to reenrollment.

---

## 7. Review Jamf Policy Execution

If compliance depends on software deployment or remediation logic, review the relevant Jamf policies.

In Jamf Pro, check:

- policy scope
- trigger
- execution frequency
- package result
- script result
- failure history

If local access is available, you can run:

```bash
sudo jamf policy
```

Or a custom trigger:

```bash
sudo jamf policy -event <custom_trigger>
```

### Common Failure Patterns

- package installation failures
- script exit errors
- permissions issues
- network timeouts
- Rosetta dependency issues on Apple silicon
- policies waiting for restart or logout
- correct scope but incorrect trigger expectations

### Remediation

If a policy failed:

1. Review the package or script error
2. Correct the local blocker if known
3. Re-run the policy or trigger the relevant custom event
4. Confirm that the expected application, setting, or file is now present
5. Run ```sudo jamf recon``` if inventory-backed compliance depends on the result

If the policy does not run at all:

- verify scope
- verify trigger method
- verify the Jamf binary is functioning
- verify the Mac can reach Jamf Pro

---

## 8. Confirm Required Security Tools Are Installed and Healthy

Validate all required tools for your environment, such as:

- endpoint protection
- EDR
- VPN client
- certificate utility
- Jamf Connect, if used
- any security or identity application used by your compliance workflow

### Remediation

If a required tool is missing:

- identify the Jamf policy or package that should install it
- verify scope and trigger
- deploy or redeploy the tool
- confirm required permissions or extensions are approved

If the tool is installed but unhealthy:

- review local application logs
- confirm background services are running
- verify the app has the correct permissions
- reinstall only if standard remediation fails

After remediation, update inventory if compliance depends on installed application reporting:

```bash
sudo jamf recon
```

---

## 9. Validate macOS Version and Update State

Check the Mac’s current macOS version and update state.

Validate:

- installed macOS version
- pending updates
- restart-required state
- update deferrals, if used
- whether Jamf-driven update workflows succeeded

### Remediation

If the Mac is below the supported baseline:

- use your standard update workflow
- verify whether an MDM update command was sent and acknowledged
- confirm whether the user deferred a required restart
- complete the update and restart the Mac

After the update:

1. confirm the OS version locally
2. run ```sudo jamf recon```
3. verify the updated version appears in Jamf Pro

If the local OS is current but Jamf reports an older version, treat it as an inventory issue unless other evidence suggests management failure.

---

## 10. Standard Remediation Actions

Apply the least disruptive remediation first.

### Refresh Inventory

Use when local state appears correct but Jamf data is stale.

```bash
sudo jamf recon
```

### Re-run Jamf Policies

Use when a required app, script, or setting failed to deploy.

```bash
sudo jamf policy
```

Or:

```bash
sudo jamf policy -event <custom_trigger>
```

### Redeploy Profiles

Use when the Mac is enrolled and MDM commands work, but a required profile is missing or failed to install.

- confirm scope
- resend or redeploy the profile from Jamf Pro
- validate the profile locally after deployment

### Reinstall Required Security Tools

Use when the compliance dependency is an app or agent that is missing, damaged, or not reporting.

- confirm the expected package or policy
- reinstall using your standard Jamf workflow
- verify the app is healthy after deployment

### Resolve FileVault or Escrow Gaps

Use when encryption is the only failed control.

- validate local encryption state
- validate escrow state in Jamf Pro
- re-run the approved FileVault or escrow remediation workflow
- avoid unnecessary reenrollment unless MDM is also unhealthy

---

## 11. When to Remove and Re-enroll

Re-enrollment should not be the first remediation step. Use it when the management relationship itself is broken.

### Indications for Re-enrollment

Proceed to re-enrollment if one or more of these are true:

- the MDM profile is missing
- MDM commands consistently fail or remain unacknowledged
- required profiles cannot be deployed despite correct scope
- inventory cannot be updated through normal Jamf workflows
- the Mac was manually unenrolled or partially removed from management
- the device was erased, restored, or migrated and no longer matches its Jamf state
- the Jamf record and local management state are clearly out of sync

### Pre-Checks Before Re-enrollment

Before removing anything, verify:

- whether the Mac is assigned to Automated Device Enrollment
- whether the user can complete setup steps if reenrollment requires user interaction
- whether FileVault recovery and escrow information is preserved according to policy
- whether security tools or certificates will be removed and must be restored

### Recommended Re-enrollment Approach

Use the organization’s approved reenrollment workflow. In general:

1. Document the current state
   - serial number
   - assigned user
   - FileVault status
   - missing profiles
   - failed policies
   - compliance errors

2. Remove broken management artifacts only if approved by your process
   - avoid ad hoc removal unless your organization has a documented procedure

3. Re-enroll the Mac using the approved Jamf method
   - Automated Device Enrollment, if applicable
   - user-initiated enrollment, if allowed by policy

4. Confirm the following after enrollment
   - the MDM profile is present
   - Jamf Pro shows a current check-in
   - inventory updates successfully
   - required profiles install
   - required policies run
   - FileVault and escrow report correctly
   - required security tools are present and healthy

5. Run a final inventory update if needed:

```bash
sudo jamf recon
```

### Important

If your environment uses Automated Device Enrollment as the standard trusted path, a full erase-and-reprovision may be preferred over manual cleanup and reenrollment. Follow local policy.

---

## 12. Validation After Remediation

After any remediation, verify:

- Jamf Pro **Last Check-In** is current
- Jamf Pro **Last Inventory Update** is current
- the MDM profile is present locally
- required configuration profiles are installed
- required security tools are installed and healthy
- FileVault and escrow status are correct
- the current macOS version is accurately reflected
- downstream compliance status has refreshed

Do not close the issue until both the local device state and the Jamf record are consistent.

---

## Escalation Criteria

Escalate after standard remediation only if the issue remains in one of the following categories:

- MDM channel failure
- repeated profile deployment failure
- persistent Jamf policy or package failure
- FileVault or escrow issues that do not respond to approved recovery steps
- infrastructure or APNs communication issues
- repeated reenrollment failure
- compliance integration issues outside Jamf Pro

## Escalation Checklist

Include:

- computer name
- serial number
- assigned user
- macOS version
- Last Check-In timestamp
- Last Inventory Update timestamp
- FileVault status
- escrow status
- MDM profile status
- missing or failed profiles
- failed policies or custom triggers
- required security tools status
- exact compliance symptom
- remediation steps already performed
- recent lifecycle changes

## Summary

When a Jamf-managed Mac fails compliance:

1. verify the Jamf Pro record is current
2. validate MDM enrollment
3. review MDM command behavior
4. compare local state with inventory
5. validate FileVault and escrow
6. review profiles and policy execution
7. remediate the specific failed control
8. re-enroll only when the management relationship is broken
9. confirm that local and Jamf-reported state match before closing the issue