From: James Clarke <jrtc27@jrtc27.com>
Date: Wed, 26 Oct 2016 16:58:16 +0000
Subject: Re: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <ED08EA5D-6934-4101-AA55-288DFA5B2D98@jrtc27.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20161025.224442.1417439049113609110.davem@davemloft.net>
In-Reply-To: <20161025.224442.1417439049113609110.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

> On 26 Oct 2016, at 16:54, David Miller <davem@davemloft.net> wrote:
>=20
> From: James Clarke <jrtc27@jrtc27.com>
> Date: Wed, 26 Oct 2016 09:28:05 +0100
>=20
>> Any progress on TLB flushing?
>=20
> I was half-way through an implementation when I noticed that
> hypervisor TLB flush handler relative branch bug I posted the
> fix for last night.

Yep, I saw that. Looks like you forgot to update the comment on
__hypervisor_flush_tlb_pending; it still says 16 insns rather than 27.

> I'll keep plugging away at it today.

Great; let me know if you need a guinea pig, as it=E2=80=99s pretty easy fo=
r me to
reproduce.

Thanks,
James