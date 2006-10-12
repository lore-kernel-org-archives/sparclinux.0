From: Will Simoneau <simoneau@ele.uri.edu>
Date: Thu, 12 Oct 2006 14:37:26 +0000
Subject: Re: [sparc64] 2.6.18 unaligned accesses in eth1394
Message-Id: <20061012143726.GD21243@ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="76DTJ5CE0DCVQemd"
List-Id: <sparclinux.vger.kernel.org>
References: <20061005211543.GA18539@ele.uri.edu> <20061009.183607.63736982.davem@davemloft.net> <20061010132943.GB18539@ele.uri.edu> <20061010.151751.90998930.davem@davemloft.net>
In-Reply-To: <20061010.151751.90998930.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 15:17 Tue 10 Oct     , David Miller wrote:
> From: Will Simoneau <simoneau@ele.uri.edu>
> Date: Tue, 10 Oct 2006 09:29:43 -0400
>=20
> > I still get:
> >=20
> > Kernel unaligned access at TPC[10162164] ether1394_reset_priv+0x2c/0xe0=
 [eth1394]
> > Kernel unaligned access at TPC[10163148] ether1394_data_handler+0xdd0/0=
x1060 [eth1394]
> >=20
> > The second one triggers on every packet received, the first only trigge=
rs once in a while.
> >=20
> > If you want more gdb info or a disassembly just ask.
>=20
> Hmmm, can you do me a favor?  Build ieee1394 and eth1394 statically
> into your kernel, reproduce, and post the kernel log messages
> and the vmlinux image somewhere where I can fetch them.
>=20
> I should be able to fix this once I have that.
>=20
> Thanks a lot.

This will be difficult as the machine in question isn't one I want to
reboot too often. The running kernel and modules are compiled with debug
info, though; if I send you the relevant .o files will that help?

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFLlMmLYBaX8VDLLURAuNAAKCATrgdjdySNlWjaZ02vhUfBI1r3gCgi+Uz
k4DFen7DOnHjJjBkeBo2ORw=
=tvSH
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
