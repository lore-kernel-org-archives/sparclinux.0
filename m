From: Frans Pop <aragorn@tiscali.nl>
Date: Mon, 14 Feb 2005 15:34:46 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502141634.55293.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4704902.vqzDkujYah"
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl>
In-Reply-To: <200502140251.00645.aragorn@tiscali.nl>
To: sparclinux@vger.kernel.org

--nextPart4704902.vqzDkujYah
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 14 February 2005 12:32, Ben Collins wrote:
> There's the problem right there. This is all wrong for sparc. Should be
> something like 1024x768, and atleast 70Hz refresh.

Hmm. Not sure if that's the whole problem. I tried booting with
video=atyfb:1024x768@75 (which I know is OK for my monitor).

This results in the output in kern.log below, but the display still
remains blank. I do agree that it is a problem though: with the older
kernels the system used to boot with a quite high resolution.

Cheers,
FJP

P.S Forgot to mention that an Ultra 10 is architecture sparc64.


atyfb: 3D RAGE (Mach64 GT) [0x4754 rev 0x02]
atyfb: 2M SGRAM (1:1), 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 MHz XCLK
atyfb: setting up CRTC
atyfb: set primary CRT to 1024x768 NN composite N
atyfb: CRTC_H_TOTAL_DISP: 7f009d
atyfb: CRTC_H_SYNC_STRT_WID: 340082
atyfb: CRTC_V_TOTAL_DISP: 2ff0330
atyfb: CRTC_V_SYNC_STRT_WID: 280307
atyfb: CRTC_OFF_PITCH: 20000000
atyfb: CRTC_VLINE_CRNT_VLINE: 0
atyfb: CRTC_GEN_CNTL: b000202
atyfb: atyfb_set_par
atyfb:  Set Visible Mode to 1024x768-8
atyfb:  Virtual resolution 1024x2016, pixclock_in_ps 22349 (calculated 22349)
atyfb:  Dot clock:           44 MHz
atyfb:  Horizontal sync:     35 kHz
atyfb:  Vertical refresh:    84 Hz
atyfb:  x  style: 44.16644 1024 1048 1208 1264   768 776 784 817
atyfb:  fb style: 22349  56 1024 24 160 33 768 8 8
debug atyfb: Mach64 non-shadow register values:
debug atyfb: 0x2000:  007F009D 00340082 02FF0330 00280307
debug atyfb: 0x2010:  00700000 20000000 08000060 0B000202
debug atyfb: 0x2020:  004805FA 009C0443 00000000 00000000
debug atyfb: 0x2030:  00000000 00000031 00000000 00000000
debug atyfb: 0x2040:  00000000 00000000 00000000 00000000
debug atyfb: 0x2050:  00000000 00000000 00000000 00000000
debug atyfb: 0x2060:  00000000 AAAAAA0F 00000000 00000000
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
debug atyfb: 0x00:  CDD52414 A80342E1 8E82E701 A61B0000
debug atyfb: 0x10:  CDD52414 A80342E1 8E82E701 A61B0000
debug atyfb: 0x20:  CDD52414 A80342E1 8E82E701 A61B0000
debug atyfb: 0x30:  CDD52414 A80342E1 8E82E701 A61B0000

Console: switching to colour frame buffer device 128x48
atyfb: fb0: ATY Mach64 frame buffer device on PCI

--nextPart4704902.vqzDkujYah
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCEMUfgm/Kwh6ICoQRAkHCAKC4rrr0gMETxaly59M0YcIiFml1PQCdErFr
qGfB0wlN/DZRK4dEJN7KMRA=
=41d2
-----END PGP SIGNATURE-----

--nextPart4704902.vqzDkujYah--
