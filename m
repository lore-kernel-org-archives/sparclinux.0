From: Frans Pop <aragorn@tiscali.nl>
Date: Mon, 14 Feb 2005 01:50:51 +0000
Subject: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502140251.00645.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart1621493.Oja2QsaRp6"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart1621493.Oja2QsaRp6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I've tested the 2.6.10 kernel for Debian on my Sparc Ultra 10 and it seems
the atyfb driver is broken.

The symptoms are that as soon as the driver is loaded the screen is blanked
and the monitor indicates that DPMS suspend has been activated (both the
green power led and the orange led are lit).
The machine boots correctly otherwise and is fully accessible over SSH.

I have traced the moment the problem was introduced to between
2.6.10-rc1 [1] and -rc2.
I've verified that the problem was not yet fixed in 2.6.11-rc3-bk2.

I've seen on linux.bkbits.net that there were quite a few changes in the
framebuffer drivers between rc1 and rc2, most coordinated by you. I hope
you can help identify the cause of this issue.

I've also seen from changeset 1.1938.285.97 that there was a somewhat
similar problem for PowerBooks.

I'll be happy to test any patches (or do debugging, provided you can give
me some instructions).

Kind regards,
Frans Pop

[1] I compiled 2.6.10-rc1 with added changeset 1.1938.212.5 to fix build error.


lspci info:
0000:01:02.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 9a)

Snip from kern.log after boot with 2.6.10-rc2:
ARCH: SUN4U
[...]
atyfb: 3D RAGE (Mach64 GT) [0x4754 rev 0x02]
atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
atyfb: setting up CRTC
atyfb: set primary CRT to 640x480 PP composite N
atyfb: CRTC_H_TOTAL_DISP: 4f0063
atyfb: CRTC_H_SYNC_STRT_WID: c0052
atyfb: CRTC_V_TOTAL_DISP: 1df020c
atyfb: CRTC_V_SYNC_STRT_WID: 201ea
atyfb: CRTC_OFF_PITCH: 14000000
atyfb: CRTC_VLINE_CRNT_VLINE: 0
atyfb: CRTC_GEN_CNTL: b000200
atyfb: atyfb_set_par
atyfb:  Set Visible Mode to 640x480-8
atyfb:  Virtual resolution 640x3225, pixclock_in_ps 39751 (calculated 39751)
atyfb:  Dot clock:           25 MHz
atyfb:  Horizontal sync:     31 kHz
atyfb:  Vertical refresh:    59 Hz
atyfb:  x  style: 25.6225 640 664 760 800   480 491 493 525
atyfb:  fb style: 39751  40 640 24 96 32 480 11 2
debug atyfb: Mach64 non-shadow register values:
debug atyfb: 0x2000:  004F0063 000C0052 01DF020C 000201EA
debug atyfb: 0x2010:  00580000 14000000 08000020 0B000200
debug atyfb: 0x2020:  00480AA0 00C0079A 00000000 00000000
debug atyfb: 0x2030:  00000000 00000031 00000000 00000000
debug atyfb: 0x2040:  00000000 00000000 00000000 00000000
debug atyfb: 0x2050:  00000000 00000000 00000000 00000000
debug atyfb: 0x2060:  ABB3ADBB ABAF2DBF 00000000 00000000
debug atyfb: 0x2070:  00000000 00000000 00003020 00000000
debug atyfb: 0x2080:  00000000 00000000 00000000 00000000
debug atyfb: 0x2090:  00A63000 00000000 00000000 00000000
debug atyfb: 0x20A0:  7B23A040 00000000 00000000 05000001
debug atyfb: 0x20B0:  004210B3 00010000 00010000 00000000
debug atyfb: 0x20C0:  00FF0000 86010182 00000000 00000000
debug atyfb: 0x20D0:  00000100 00000000 00000000 00003842
debug atyfb: 0x20E0:  9A004754 0000001D 00000000 00000000
debug atyfb: 0x20F0:  00000000 00008E0D E17FFCF8 00000000

debug atyfb: Mach64 PLL register values:
debug atyfb: 0x00:  CDD52414 A80343FD 8E82E701 A61B0000
debug atyfb: 0x10:  CDD52414 A80343FD 8E82E701 A61B0000
debug atyfb: 0x20:  CDD52414 A80343FD 8E82E701 A61B0000
debug atyfb: 0x30:  CDD52414 A80343FD 8E82E701 A61B0000

Console: switching to colour frame buffer device 80x30
atyfb: fb0: ATY Mach64 frame buffer device on PCI

--nextPart1621493.Oja2QsaRp6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCEAQEgm/Kwh6ICoQRApENAJ4r696JbHB+WYjN/mVfahP3INbgswCfdVLQ
dKk99Ndn8B3yFdsRUuwFVdY=
=+G3m
-----END PGP SIGNATURE-----

--nextPart1621493.Oja2QsaRp6--
