From: Jason Wever <weeve@gentoo.org>
Date: Tue, 24 Oct 2006 01:19:54 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061023191954.011eea15@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_MyrEH1oa3HChpx5UP_JGeDU"
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
To: sparclinux@vger.kernel.org

--Sig_MyrEH1oa3HChpx5UP_JGeDU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Oct 2006 12:31:51 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

Sorry for the late reply here.

> I fixed these recently, I believe the fix for that is in 2.6.18.1

I tried 2.6.18.1 but the same warnings were still there.  I'll
attempt to pull the git tree for 2.6.18.x and see if I can reproduce
there.

> I'll look into the IRQ problems but the power device registered it's
> IRQ just fine on my SB100 in current 2.6.19-GIT.

Hrm, I pulled the git source this afternoon and still get the same
thing:

ebus0: [flashprom] [eeprom] [idprom]
power: Control reg at 1fe02000800 ... powerd running.
power: Control reg at 1fe02000800 ... powerd running.
IRQ handler type mismatch for IRQ 8
Call Trace:
 [00000000004232f4] power_probe+0xb0/0x100
 [0000000000427628] of_device_probe+0x50/0x70
 [00000000005a5a20] really_probe+0x48/0xf0
 [00000000005a5bd0] __driver_attach+0x44/0x68
 [00000000005a50d4] bus_for_each_dev+0x38/0x6c
 [00000000005a540c] bus_add_driver+0x60/0x190
 [00000000007be7f0] pcibios_init+0x88/0x90
 [0000000000416a44] init+0xa8/0x298
 [0000000000417478] kernel_thread+0x38/0x48
 [0000000000416c4c] rest_init+0x18/0x2c
power: Error, cannot register IRQ handler.

I tried building with both CONFIG_CC_OPTIMIZE_FOR_SIZE enabled and
disabled but it didn't appear to make any difference.  Not sure if it
would matter or not but I'm using OBP 4.17.1 here.

Thanks,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_MyrEH1oa3HChpx5UP_JGeDU
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFPWo8dKvgdVioq28RAu+yAJ94r6ec0fho/p1Iuuc+rSulim0ssQCfdiwI
/jPzGRluv+Au7qloGzSTPZg=
=M9vQ
-----END PGP SIGNATURE-----

--Sig_MyrEH1oa3HChpx5UP_JGeDU--
