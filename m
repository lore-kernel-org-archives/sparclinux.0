From: Will Simoneau <simoneau@ele.uri.edu>
Date: Wed, 20 Sep 2006 17:21:23 +0000
Subject: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-Id: <20060920172123.GA9334@ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I upgraded from 2.6.17.7 to 2.6.18 today, and in dmesg I have 5 of these
messages in a row:

Kernel unaligned access at TPC[100be8c8] ehci_hub_control+0x350/0x680 [ehci=
_hcd]

This message wasn't there before... I suppose it is pretty harmless as
the kernel is supposed to handle unaligned accesses (right?) but this is
the first time it's happened.

According to gdb (my first time using it...),
drivers/usb/host/ehci-hub.c:280 is to blame:

(gdb) list *ehci_hub_control+0x350
0x8d0 is in ehci_hub_control (drivers/usb/host/ehci-hub.c:280).
275      struct usb_hub_descriptor  *desc
276   ) {
277      int      ports =3D HCS_N_PORTS (ehci->hcs_params);
278      u16      temp;
279  =20
280      desc->bDescriptorType =3D 0x29;
281      desc->bPwrOn2PwrGood =3D 10; /* ehci 1.0, 2.3.9 says 20ms max */
282      desc->bHubContrCurrent =3D 0;
283  =20
284      desc->bNbrPorts =3D ports;

System is a Sun U80 4x450 with 2.5G and a USB2 PCI card. GCC for the
kernel is 4.1.1 (with gentoo patchset). The only USB2 device is an
external Sony dual layer DVD writer.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFEXiTLYBaX8VDLLURAgDsAKC2rmhf98QKjvglx4FOond3/JyTRQCff1Lc
scEkEtIpxKOkccMXky3OwkM=
=6TjD
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
