From: Jason Wever <weeve@gentoo.org>
Date: Mon, 05 Sep 2005 15:41:31 +0000
Subject: Re: PCI device issues between Blade 100 and Blade 100
Message-Id: <20050905094131.085f25b9@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature_Mon__5_Sep_2005_09_41_31_-0600_4=4pTKIhalfGjvG0"
List-Id: <sparclinux.vger.kernel.org>
References: <20050904153024.630204cb@enterprise.weeve.org>
In-Reply-To: <20050904153024.630204cb@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Signature_Mon__5_Sep_2005_09_41_31_-0600_4=4pTKIhalfGjvG0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 04 Sep 2005 21:14:17 -0700 (PDT)
"David S. Miller" <davem@davemloft.net> wrote:

> Error -16 from request_irq() means EBUSY, ie. another device
> has registered a handler for that interrupt number already.
> This usually means some driver has failed to specify SA_SHIRQ
> in it's request_irq() call.  It's either the EHCI driver (not
> very likely) or whatever other device has already registered
> with that IRQ, you can figure that out using /proc/interrupts
> output.

Thanks for the info.  Looking into this a bit more, it appears that the
RTC on ebus0 loaded via the bbc_i2c driver is already using the same
interrupt.

Looking at the ehci driver messages, it shows (among other things);
ehci_hcd 0001:00:01.2: request interrupt 10,20e failed

Then looking for interrupt 10 in /proc/interrupts shows;
10:          0          0  rtc:224

--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature_Mon__5_Sep_2005_09_41_31_-0600_4=4pTKIhalfGjvG0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDHGcrdKvgdVioq28RAi4/AJ44eufQAThv9U5sMpp/YSumKZlZlgCfUgM1
pUY4fcBRCKcIpkMmGkd8iOs=
=waLu
-----END PGP SIGNATURE-----

--Signature_Mon__5_Sep_2005_09_41_31_-0600_4=4pTKIhalfGjvG0--
