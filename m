From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 27 May 2012 15:04:33 +0000
Subject: Re: Sparc32: BTFIXUPSET_CALL(pmd_clear, . . .)-related issue in older versions of the kernel
Message-Id: <20120527150433.GA19538@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK1sNPDMcX=D+=1uxVpX5HOgKyCzXr1EeUx7Eyky2j-2n3q0Ng@mail.gmail.com> <CAK1sNPDNz3E3PLq4mB6VagWu0BsGdhQVcew2YDmaG+JJBup3ug@mail.gmail.com>
In-Reply-To: <CAK1sNPDNz3E3PLq4mB6VagWu0BsGdhQVcew2YDmaG+JJBup3ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ilya Malakhov <ilmalakhovthefirst@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

Hi Ilya.

Cc: sparclinux + David S. Miller.

On Sun, May 27, 2012 at 04:03:50PM +0400, Ilya Malakhov wrote:
> =A0Hi.
>=20
> =A0While analyzing a rather nasty problem with an application running at
> sun4m sparc32 hosts with "Fujitsu TurboSparc" and "TI Viking/MXCC"
> MMUs, I realized, that as a 4Kb "Page Table" was freed, only the first
> element in the corresponding `pmdv[]' array in
>=20
> typedef struct { unsigned long pmdv[16]; } pmd_t;
>=20
> was actually cleared, rather than all the 16 ones.
>=20
> =A0The reason for that was the use of `BTFIXUPCALL_SWAPO0G0' instead of
> `BTFIXUPCALL_NORM' for `pmd_clear' in case of "default" SRMMU (except
> for some specific types of SRMMU) during initialization:
> =A0. .
> BTFIXUPSET_CALL(pmd_clear, srmmu_pmd_clear, BTFIXUPCALL_SWAPO0G0);
> =A0. .
>=20
> =A0That would probably be OK if pmd_t were `struct { unsigned long pmd;
> }' as it used to be ten years ago, but seems to be erroneous nowadays,
> doesn't it?
>=20
> =A0From a user's point of view this leads to poorly diagnosable
> problems. E.g., after a series of mmaps and munmaps one may find
> himself in a situation, where different virtual addresses are mapped to
> the same physical one.
>=20
Sounds like a problem that have taken long time to track down!

> =A0A recent commit by David Miller, where pmd_clear() is un-btfixupped,
> is likely to solve this problem in future versions of the kernel.
We were very glad to kill off this btfixup thing.


> I wonder, if any patches for older ones should be expected.

If someone submits a patch for this it is likely to happen - hint!
That patch should explicit reference the commit in upstrem
that fixes the same bug.

Otherwise - no.

	Sam
