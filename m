From: Jason Wever <weeve@gentoo.org>
Date: Wed, 18 Oct 2006 12:38:04 +0000
Subject: Re: Problems booting 2.6.18 on SunBlade 100/150
Message-Id: <20061018063804.7780b75a@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_v+P3efv__PZz4185RxWV+wO"
List-Id: <sparclinux.vger.kernel.org>
References: <200401070729.56891.pkarlsen@mandriva.com>
In-Reply-To: <200401070729.56891.pkarlsen@mandriva.com>
To: sparclinux@vger.kernel.org

--Sig_v+P3efv__PZz4185RxWV+wO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 17 Oct 2006 18:56:44 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> Ok, I figured it out.  Please test the patch below as soon as you can,
> it seems to work on my SB100.

The patch allows me to boot 2.6.18 and 2.6.19-rc2 on a Blade 100
(kernels built with gcc-4.1.1 on Gentoo).

In what may be in relation to the loosening of the resource conflict
message suppression, I see two call traces related to registering
devices in 2.6.18 that I don't recall seeing in 2.6.17 and one IRQ
handler problem  in 2.6.19-rc2.    If these aren't related, then
just ignore this part of the message :)  Errors are below:

2.6.18 errors:
kobject_add failed for isa@7 with -EEXIST, don't try to register things
with the
 same name in the same directory.
Call Trace:
 [0000000000427504] of_device_register+0x2c/0x60
 [00000000006e403c] scan_one_device+0x8b8/0x924
 [00000000006e40bc] scan_tree+0x14/0x3c
 [00000000006e40cc] scan_tree+0x24/0x3c
 [00000000006e4180] of_bus_driver_init+0x9c/0xa4
 [0000000000416a58] init+0x9c/0x28c
 [00000000004174b8] kernel_thread+0x38/0x48
 [0000000000416c60] rest_init+0x18/0x2c
/pci@1f,0/isa@7: Could not register of device.
kobject_add failed for pmu@3 with -EEXIST, don't try to register things
with the
 same name in the same directory.
Call Trace:
 [0000000000427504] of_device_register+0x2c/0x60
 [00000000006e403c] scan_one_device+0x8b8/0x924
 [00000000006e40bc] scan_tree+0x14/0x3c
 [00000000006e40cc] scan_tree+0x24/0x3c
 [00000000006e4180] of_bus_driver_init+0x9c/0xa4
 [0000000000416a58] init+0x9c/0x28c
 [00000000004174b8] kernel_thread+0x38/0x48
 [0000000000416c60] rest_init+0x18/0x2c



2.6.19-rc2 errors:
ebus0: [flashprom] [eeprom] [idprom]
power: Control reg at 1fe02000800 ... powerd running.
power: Control reg at 1fe02000800 ... powerd running.
IRQ handler type mismatch for IRQ 8
Call Trace:
 [00000000004232f4] power_probe+0xb0/0x100
 [0000000000427770] of_device_probe+0x50/0x70
 [0000000000544a6c] really_probe+0x48/0xf0
 [0000000000544c10] __driver_attach+0x44/0x68
 [000000000054411c] bus_for_each_dev+0x38/0x6c
 [0000000000544444] bus_add_driver+0x60/0x19c
 [00000000006ea814] pcibios_init+0x88/0x90
 [0000000000416a44] init+0xa8/0x298
 [0000000000417478] kernel_thread+0x38/0x48
 [0000000000416c4c] rest_init+0x18/0x2c
power: Error, cannot register IRQ handler.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_v+P3efv__PZz4185RxWV+wO
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFNiAwdKvgdVioq28RAm/aAJ9DR2cahyENdkH3QVE8riWWtK3KEgCgiR0Y
dgfzZkSITktNI+ooEskzqek=
=mzpy
-----END PGP SIGNATURE-----

--Sig_v+P3efv__PZz4185RxWV+wO--
