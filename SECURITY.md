# Security Policy

### Standard Priority Bug

For a bug that is non-sensitive and/or operational in nature rather than a critical vulnerability, please add it as a
GitHub issue.

### Critical bug or security issue

Please report critical security vulnerabilities to
**[security@injectivelabs.org](mailto:security@injectivelabs.org)**.  *Please avoid opening a public issue on the
repository for critical security issues.*

The Injective Labs team will send a response indicating the next steps in handling your
report. After the initial reply to your report, the team will keep you informed
of the progress towards remediation and may ask for additional
information or guidance.

In addition, please include the following information along with your report:

- Your name and affiliation (if any).
- A description of the technical details of the vulnerabilities. It is very important to let us know how we can
  reproduce your findings.
- An explanation of who can exploit this vulnerability, and what they gain when doing so -- write an attack scenario.
  This will help us evaluate your report quickly especially if the issue is complex.
- Whether this vulnerability is public or known to third parties. If it is, please provide details.

If you believe that an existing (public) issue is a critical-security-related issue, please email *
*[security@injectivelabs.org](mailto:security@injectivelabs.org)**. The email should include the issue ID and
a short description of why it should be handled according to this critical security
policy.

If you have found an issue with the Cosmos SDK or Tendermint modules not found in this repo you can report them through
links found here. https://tendermint.com/security/

Alternately you can also notify us of a security issue through, [Discord](https://discord.gg/injective) or Telegram, and
alert the core engineers:

|           | Telegram        | Discord                         |
|-----------|-----------------|---------------------------------|
| Albert    | `@albertchon`   | Albert &#124; Injective#9999    |
| Bojan     | `@bangjelkoski` | Bojan Angjelkoski#7621          |
| Achilleas | `@achilleas_k`  | Achilleas &#124; Injective#1596 |
| Markus    | `@markuswaas`   | Markus Waas#2536                |

### Coordinated Vulnerability Disclosure Policy

We ask security researchers to keep vulnerabilities and communications around vulnerability submissions private and
confidential until a patch is developed. In addition to this, we ask that you:

- Allow us a reasonable amount of time to correct or address security vulnerabilities.
- Avoid exploiting any vulnerabilities that you discover.
- Demonstrate good faith by not disrupting or degrading Injective's services.

### Disclosure Policy

When the security team receives a security bug report, they will assign it to a primary handler. This person will
co-ordinate the fix and release process, involving the following steps:

- Confirm the problem and determine the affected versions.
- Audit code to find any potential similar problems.
- Prepare fixes for all releases still under maintenance.

This process can take some time. Every effort will be made to handle the bug in as timely a manner as possible. However,
it's important that we follow the process described above to ensure that disclosures are handled consistently and to
keep Injective and the projects running on it secure.
