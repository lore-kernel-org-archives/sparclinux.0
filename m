From: joshk@triplehelix.org (Joshua Kwan)
Date: Fri, 14 May 2004 20:11:19 +0000
Subject: Re: initrd testing
Message-Id: <20040514201119.GC29680@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GZVR6ND4mMseVXL/"
List-Id: <sparclinux.vger.kernel.org>
References: <20040513202146.GD1098@phunnypharm.org>
In-Reply-To: <20040513202146.GD1098@phunnypharm.org>
To: sparclinux@vger.kernel.org


--GZVR6ND4mMseVXL/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 14, 2004 at 01:56:25PM -0600, Peter Karbaliotis wrote:
> I also saw this on a Sun Ultra 2.
>=20
> Sun Ultra 2 UPA/Sbus (2 x UltraSPARC 200 MHz)
> ...
> loaded kernel version 2.4.26
> Loading initial ramdisk ( 1477684 bytes at 0x01x phys, 0x60800000 virt)
> ...
> RAMDISK: Couldn't find valid RAM disk image starting at 0
> Freeing initrd memory: 1443k freed
> cramfs: wrong magic
> sh-2021: reiserfs_read_super: can not find reiserfs on ramdisk (1,0)
> kernel panic: VFS: Unable to mount root fs on 00:00
>   Press L1-A to return to the boot prom
>=20
>=20
> The 20040511 daily image boots up fine on this system.

Erk. That's a _regression_! Not good... Ben, did your patch interfere
with anything that would have made this not work? Also, this is CDROM,
right? Also, did you use a netinst/businesscard image, the
cdrom-mini.iso, or what?

I tried a boot floppy on my sparc32 box. It seemed to boot OK, but
possibly because SILO is not responible for the initrd for floppy
installs.

--=20
Joshua Kwan

--GZVR6ND4mMseVXL/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQKUn5aOILr94RG8mAQJrpQ/+LYFT2pfrVC5rvqdt4swCwEsnzyHBjk++
tqwnSKdSsbbJFKjF6U4qh7ae8N/47yrQuwImdC0BgtPxRR4DbXevHz353HmAzyoK
Udsxckg2NzRqII1i23PuDddUlqMJ1nWfyodgXbHYR5YbRaXndA/JVlnSaNhgyenr
naHvnd9AlFM0vDGv8LeHETtdWZSxiXjZtkZxtgcu5OSpLvhI8t2BzWf8P1jGVJLz
By806L0ALNsTM9TkadStVNflrK0HZZiv6jqt+KldKeAPQdit8pGy3s42j4Dsy9GM
G5erKi4O2we36XI/LdLaXlaQaakAzZB0kylLTUvsVV/OTzJ1jZEBlDPToncEdv4g
YnY3aQoW3Bgt1VWGeRPEBXxyT+dHY6t/65HazGysETtrs4MMIUmQNMII0Xy7ElC5
Bn0PIjbyQEndjSNnpnhvIpaT/7ssKX2XOaG1edYfyhoYcilTEYrco9YCf8tqpMoL
NbYV+i5Wp3fWJy4HQ+NX71TGWAIrBMxZumvTBddIbD76CFw74aBaMOupxrbhB6aF
LWGgDWpjwd7jJRNBTlbuF1/wEWdR0lfo6H2SY+eqReIrmbdpAkEL3NkLWzvEQpD7
+SlkQod741MOybSNCSeM8FOqrGMLboqccj7EMWGFrOFq0GwdrSdFLZnry27vAzbQ
LQRtIh7+uZQ=
=LbZx
-----END PGP SIGNATURE-----

--GZVR6ND4mMseVXL/--
