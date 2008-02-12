From: Daniel Smolik <marvin@mydatex.cz>
Date: Tue, 12 Feb 2008 22:19:00 +0000
Subject: Re: [Bugme-new] [Bug 9943] New: on E450 after shutdown doesn't go
Message-Id: <47B21B54.5090005@mydatex.cz>
List-Id: <sparclinux.vger.kernel.org>
References: <20080212141009.ba27e1b0.akpm@linux-foundation.org>
In-Reply-To: <20080212141009.ba27e1b0.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Andrew Morton napsal(a):
> (please respond via emailed reply-to-all, not via the bugzilla web
> interface)
>=20
> On Tue, 12 Feb 2008 13:54:55 -0800 (PST)
> bugme-daemon@bugzilla.kernel.org wrote:
>=20
>> http://bugzilla.kernel.org/show_bug.cgi?id=9943
>>
>>            Summary: on E450 after shutdown doesn't go to OK or power off
>>            Product: Platform Specific/Hardware
>>            Version: 2.5
>>      KernelVersion: 2.6.24.2
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: normal
>>           Priority: P1
>>          Component: SPARC64
>>         AssignedTo: platform_sparc64@kernel-bugs.osdl.org
>>         ReportedBy: marvin@mydatex.cz
>>
>>
>> Latest working kernel version: 2.6.20
>> Earliest failing kernel version: 2.6.24.2
>> Distribution: Debian Etch
>> Hardware Environment: Sun E450 2xCPU400MHz/1GB Ram
>> Software Environment: kernel
>> Problem Description: after shutdown kernel doesn't power off machine or =
jump to
>> OK prompt
>>
>> Steps to reproduce:
>> as root type poweroff
>>
>=20
> A regression..
>=20
> I'm seeing the same problem in 2.6.25-rc1 on x86_64, due to something whi=
ch
> changed in the softlockup detector (it's a mystery and debugging is in
> progress).  Setting CONFIG_DETECT_SOFTLOCKUP=3Dn "fixes" it.
>=20
> But 2.6.24 is OK.
>=20
May be on X86 but on Sparc64 this doesn't solve problem.
I have CONFIG_DETECT_SOFTLOCKUP=3Dn  in my config.

				Dan



