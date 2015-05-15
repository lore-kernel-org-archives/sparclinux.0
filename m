From: Eric Snowberg <eric.snowberg@oracle.com>
Date: Fri, 15 May 2015 03:53:31 +0000
Subject: Re: [PATCH v2] sparc64: pci slots information is not populated in sysfs
Message-Id: <33CF0123-CC23-4CAD-BAE0-CEF751ADC00A@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430254277-208174-1-git-send-email-eric.snowberg@oracle.com>
In-Reply-To: <1430254277-208174-1-git-send-email-eric.snowberg@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


> On May 13, 2015, at 9:55 PM, David Miller <davem@davemloft.net> wrote:
>=20
> From: Eric Snowberg <eric.snowberg@oracle.com>
> Date: Tue, 28 Apr 2015 16:51:17 -0400
>=20
>> Add PCI slot numbers within sysfs for sun4v hardware. Larger
>> sun4v systems contain nested PCI bridges and slots further
>> down on these bridges were not being populated within sysfs.
>> Also add ACPI style PCI slot numbers within sysfs for sun4v
>> hardware since the OF 'slot-names' information is not available
>> on all sun4v platforms.
>>=20
>> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
>>=20
>> ---
>> Changes in v2:
>>  - Addresses Julian Calaby's comments: moved hypervisor test
>>      outside the while loop and updated the typo in the
>>      commit comment.
>=20
> This property definitely exists in sun4u systems, "Ultra 45" and "Sun
> Fire V245" at a minimum.
>=20
> You can see this clearly by merely perusing the prtconf dumps in my
> 'prtconfs' GIT repository.
>=20
> So it makes no sense at all the limit this code to sun4v systems.

Ok, I=E2=80=99ll send out a v3 patch with these changes.