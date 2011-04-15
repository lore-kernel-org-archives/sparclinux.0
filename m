From: Ben Hutchings <ben@decadent.org.uk>
Date: Fri, 15 Apr 2011 03:39:12 +0000
Subject: pata_cmd64x provokes bus error on Sun Fire 480R or 880
Message-Id: <1302838752.5282.741.camel@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-y+VkwHECz+UpkQs+q3US"
List-Id: <sparclinux.vger.kernel.org>
References: <20110414111838.5205.29518.reportbug@tantalus.iwr.uni-heidelberg.de>
	 <1302782688.5282.684.camel@localhost>
	 <20110414135725.GD13256@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20110414135725.GD13256@lemon.iwr.uni-heidelberg.de>
To: linux-ide@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>, 622745@bugs.debian.org, debian-sparc@lists.debian.org


--=-y+VkwHECz+UpkQs+q3US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Debian received a bug report that pata_cmd64x fails on some SPARC
machines, whereas cmd64x works.  The bug report is logged at
<http://bugs.debian.org/622745>.

On Thu, 2011-04-14 at 15:57 +0200, Hermann Lauer wrote:
> On Thu, Apr 14, 2011 at 01:04:48PM +0100, Ben Hutchings wrote:
> > Does your custom kernel use the old IDE cmd64x driver?
> >=20
> > What happens if you add 'blacklist=3Dpata_cmd64x' to the kernel command
> > line for the Debian kernel?
>=20
> Not better, see below. I attached the config of the self compiled kernel
> for comparisons.
>=20
> Greetings
>  Hermann
>=20
> Starting the hotplug events dispatcher: udevd[  164.169235] udev[344]: st=
arting version 164
> .
> Synthesizing the initial hotplug events...done.
> Waitin[  164.654174] udev[380]: renamed network interface eth0 to eth2
> g for /dev to be fully populated...[  164.779803] /pci@8,700000: PCI Erro=
r, primary error type[Master Abort]
> [  164.779990] ERROR(2): Cheetah error trap taken afsr[0010080000000000] =
afar[000007ffef000410] TL1(0)
> [  164.780002] ERROR(2): TPC[10247bdc] TNPC[10247be0] O7[10247cdc] TSTATE=
[4411e01602]
> [  164.780009] ERROR(2): TPC<ata_sff_check_status+0x4/0x10 [libata]>
> [  164.780079] ERROR(2): M_SYND(0),  E_SYND(0), Privileged
> [  164.780089] ERROR(2): Highest priority error (0000080000000000) "Bus e=
rror response from system bus"
> [  164.780102] ERROR(2): D-cache idx[0] tag[0000000000000000] utag[000000=
0000000000] stag[0000000000000000]
> [  164.780114] ERROR(2): D-cache data0[0000000000000000] data1[0000000000=
000000] data2[0000000000000000] data3[0000000000000000]
> [  164.780128] ERROR(2): I-cache idx[0] tag[0000000000000000] utag[000000=
0000000000] stag[0000000000000000] u[0000000000000000] l[0000000000000000]
> [  164.780141] ERROR(2): I-cache INSN0[0000000000000000] INSN1[0000000000=
000000] INSN2[0000000000000000] INSN3[0000000000000000]
> [  164.780153] ERROR(2): I-cache INSN4[0000000000000000] INSN5[0000000000=
000000] INSN6[0000000000000000] INSN7[0000000000000000]
> [  164.780164] ERROR(2): E-cache idx[ef000400] tag[0000028feb922802]
> [  164.780174] ERROR(2): E-cache data0[0000000000000006] data1[fffff8a3fa=
d752c0] data2[0000000000000000] data3[0000000000000000]
> [  164.780187] Kernel panic - not syncing: Irrecoverable deferred error t=
rap.
> [  164.780192]=20
> [  164.780197] Call Trace:
> [  164.780217]  [0000000000429398] cheetah_deferred_handler+0x49c/0x4ec
> [  164.780234]  [0000000000405e30] c_deferred+0x18/0x24
> [  164.780255]  [0000000010247bdc] ata_sff_check_status+0x4/0x10 [libata]
> [  164.780276]  [00000000102415a4] __ata_port_freeze+0x34/0x50 [libata]
> [  164.780297]  [000000001024169c] ata_eh_freeze_port+0x20/0x3c [libata]
> [  164.780316]  [0000000010235998] ata_host_start+0x120/0x1b4 [libata]
> [  164.780339]  [00000000102488b8] ata_pci_sff_activate_host+0x14/0x1e4 [=
libata]
> [  164.780361]  [0000000010248d94] ata_pci_bmdma_init_one+0xc0/0x124 [lib=
ata]
> [  164.780375]  [0000000010354148] cmd64x_init_one+0xf0/0x104 [pata_cmd64=
x]
> [  164.780394]  [00000000005f08c8] local_pci_probe+0x10/0x24
> [  164.780404]  [00000000005f0b50] pci_device_probe+0x4c/0x84
> [  164.780424]  [0000000000663380] driver_probe_device+0xa8/0x158
> [  164.780434]  [0000000000663484] __driver_attach+0x54/0x80
> [  164.780444]  [0000000000662bac] bus_for_each_dev+0x3c/0x84
> [  164.780454]  [0000000000662494] bus_add_driver+0xa8/0x244
> [  164.780464]  [0000000000663780] driver_register+0xb8/0x168
> [  164.780475] Press Stop-A (L1-A) to return to the boot prom
> [  167.770834] /pci@8,700000: bytemask[0004] was_block(0) space(I/O)
> [  167.850103] /pci@8,700000: PCI AFAR [0000000000000408]
> [  167.916774] /pci@8,700000: PCI Secondary errors [(none)]


--=20
Ben Hutchings
Once a job is fouled up, anything done to improve it makes it worse.

--=-y+VkwHECz+UpkQs+q3US
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATae92ee/yOyVhhEJAQpKwg/+NDKvyjTPeEtCaSqBk921K0s2LTQcUlpx
m0IcMog8CPx31GdUXfB/A4JyX3dLCXm6hbccTOr+N20LYX/sMfIW+QGO0K0Ub51s
G741lWYMJrgNpz8+oQ9ZWExg707M9P3t+hV9YbYlilefF/Rmk+80VCbw4fXiUgKJ
ygkGgy28SSuw/mWuQY9b1y3eqJNWx0c/bfl2Tjw9wFzXeTw+fqzp6XW/fIvJtYqs
/H3Mcm4Mt7Ju1Ru7pHFJMK+k7meCan+HS7OtPVMl4i+00OnAKANKxY2UGhBXSGuB
JRb/uQJtX1Z4aTGQdOHSoaRsbiK3DaT1EQPuvAcWNisv3y+kLLa2ENxXIpFigkG9
T603ZzsaDc0K/u3NSCoiAFCjJxNvT+Xdkx3PWXe9nL/3G033hSsOGOVdcVSliLyB
J0PWoycQEfEPEuO9dOSezSRZC1Mnp+5TIfCjAgwA09TfumAZu9la8ISPmkx16KJB
E3v2ciXMj6aDH/j+LUG20IO8TtiBdQUXODdD5ZHnvfPQoCuygVPyM0eZi58xYqiV
XpzNXKeHYuBeqXHphigtoUaGa+cwWRBdEViWa6NrkTnte0MQEJW+SNTrrHxzRDeq
9UfRtOkoK1H8h6M/2+JkZvl78GK3jkmxYMdA8FozHdrQ32PshW1m7Ufn3YFkBe3q
aSBIpwdU1Sg=
=TGgF
-----END PGP SIGNATURE-----

--=-y+VkwHECz+UpkQs+q3US--
