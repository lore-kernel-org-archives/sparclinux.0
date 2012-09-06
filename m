From: Adam Jackson <ajax@redhat.com>
Date: Thu, 06 Sep 2012 16:51:17 +0000
Subject: Re: PCI Radeon RV100 detection hang on sparc64
Message-Id: <1346950277.3912.152.camel@atropine>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-RrYCJRft0sL5q9A7ERb2"
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1209061032360.371@math.ut.ee>
To: Meelis Roos <mroos@linux.ee>
Cc: sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org


--=-RrYCJRft0sL5q9A7ERb2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-06 at 17:41 +0300, Meelis Roos wrote:

> [drm] radeon defaulting to kernel modesetting.
> [drm] radeon kernel modesetting enabled.
> PCI: Enabling device: (0000:02:02.0), cmd 82
> [drm] initializing kernel modesetting (RV100 0x1002:0x5159 0x1002:0x0908)=
.
> [drm] register mmio base: 0x10000000
> [drm] register mmio size: 32768
> [drm:radeon_device_init] *ERROR* Unable to find PCI I/O BAR

This particular message looks like it might actually be harmless, all
the code paths that use the I/O BAR can use the MMIO mirror of it
instead.  No idea how well tested that is, but at any rate it's not
what's breaking your setup.

> And here the machine hangs. Debugging printk-s reveal that it does not=
=20
> find any active I/O port resources and then continues into initializing=
=20
> the card. Down in igp_read_bios_from_vram() it successfully ioremaps=20
> memory region 0 (vram_base=3D1ff08000000 and size=3D40000) and tries to r=
ead=20
> 2 bytes from there and hangs on reading bios[0].

This is probably because...

> 02:02.0 VGA compatible controller: Advanced Micro Devices [AMD] nee ATI R=
V100 QY [Radeon 7000/VE] (prog-if 00 [VGA controller])
>         Subsystem: Advanced Micro Devices [AMD] nee ATI XVR-100 (supplied=
 by Sun)
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping+ SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0 (2000ns min)
>         Interrupt: pin A routed to IRQ 16
>         Region 0: Memory at 08000000 (32-bit, prefetchable) [size=3D64M]
>         Region 1: I/O ports at 0400 [disabled] [size=3D256]
>         Region 2: Memory at 10000000 (32-bit, non-prefetchable) [size=3D3=
2K]
>         Region 3: [virtual] Memory at fffffe0100000000 (32-bit, non-prefe=
tchable) [size=3D1]
>         Region 4: [virtual] Memory at fffffe0100000000 (32-bit, non-prefe=
tchable) [size=3D1]
>         Region 5: [virtual] Memory at fffffe0100000000 (32-bit, non-prefe=
tchable) [size=3D1]
>         Expansion ROM at 10020000 [disabled] [size=3D128K]

... the ROM BAR looks like it's not routed.

On x86 you could fix this by booting with 'pci=3Drom' to force the ROM BAR
to be routed regardless of firmware setup, no idea how that's meant to
work on sparc though.

- ajax

--=-RrYCJRft0sL5q9A7ERb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlBI1IYACgkQW4otUKDs0NMPzgCfaXmCGskXCAxzceCJkujZasJ7
q/AAnj/Dp4c6ck8Iq0r9U69mAFnOBzG8
=H4O1
-----END PGP SIGNATURE-----

--=-RrYCJRft0sL5q9A7ERb2--

