From: Alexander Clouter <alex@digriz.org.uk>
Date: Sat, 10 Sep 2005 13:40:13 +0000
Subject: sparc family optimising support
Message-Id: <20050910134013.GB7072@inskipp.digriz.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="DSayHWYpDlRfCAAQ"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--DSayHWYpDlRfCAAQ
Content-Type: multipart/mixed; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi All,

Digging around I cannot see any reference to someone having done this befor=
e,=20
and not to come over as a Gentoo Ricer ;) but I rolled out the following=20
patch which does give me a bit more umpft from my old Sun 50Mhz Lunchbox[1].

Missing those integer divides/multiples really hurts her needlessly. :( I=
=20
noticed when compiling 2.6 kernels no -mcpu=3D<cheese> flags appear, or=20
anything equivalent, so thought it would be a good idea to add my own.  The=
=20
effect for my 50Mhz v8 sparc, ssh does connect much faster; I guess thats d=
ue=20
to /dev/random'ness....not sure but I give it the "Works for Me(tm)" stamp =
of=20
approval.  Really I just did all this to get ssh connecting to go faster=20
and this probably helps the IPSec'ing I do on her too :)

As the x86 crowd can optimise in a cute menu for 586, 686, etc I thought us=
=20
sparc users were missing out and should be able to do v8, v9, etc.  To make=
=20
the patch I pretty much lifted the information from the gcc manpages and it=
=20
seems to work.

Comments, flames, praise are welcome of course.  Just curious why something=
=20
like this has not appeared earlier, I'm sure there is a reason that I have=
=20
missed upon?  Would be interesting to know if anyone else finds this useful=
,=20
having gcc default to v7 can be awkward.

My reasoning for defaulting to v8 is that most people, I guess, have a v8=
=20
suitable chip or above and its rather expensive dropping those integer=20
divides/multiples by default; just my opinion, if people think a v7 default=
=20
would be a better idea then go for that.  If you have a v7 chip you would=
=20
normally be aware of its limitations in comparison to the later chips I wou=
ld=20
assume?

Cheers

Alex

[1] http://eintr.net/systems/sun/sparcclassic/

--=20
 ________________________________________=20
/ Scintillation is not always            \
\ identification for an auric substance. /
 ----------------------------------------=20
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sparc-optimisation.diff"
Content-Transfer-Encoding: quoted-printable

diff -r -u linux-2.6.13.orig/arch/sparc/Kconfig linux-2.6.13/arch/sparc/Kco=
nfig
--- linux-2.6.13.orig/arch/sparc/Kconfig	2005-08-29 00:41:01.000000000 +0100
+++ linux-2.6.13/arch/sparc/Kconfig	2005-09-03 19:21:02.000000000 +0100
@@ -229,6 +229,122 @@
=20
 if !SUN4
=20
+choice
+	prompt "Processor family"=20
+		default MV8
+
+config MV7
+	bool "v7"
+	help
+	  Select this for a v7 variant of the SPARC CPU architecture.  This
+	  particular chip series does not include the integer multiply and
+	  divide instructions and gcc by defaults produces code for this
+	  chip; as a result there can be a significant performance hit if
+	  your CPU actually supports this additional instructions.
+
+	  If you have a SPARCStation 1, 2, IPX machine you should opt for
+	  this otherwise keep with the default (v8) if you are unsure.
+
+config MCYPRESS
+	bool "v7 - cypress"
+	help
+	  Select this for a Cypress variant of the SPARC CU architecture
+	  that is based on the v7 instruction set.  Chosing this option will
+	  add further compiler optimisations for the Cypress CY7C602 chip as
+	  found in the SPARCStation/SPARCServer 3xx series of machines.
+
+config MV8
+	bool "v8"
+	help
+	  Select this for a v8 variant of the SPARC CPU architecture.  The
+	  only difference from the v7 code is that there are integer
+	  multiply and divide instructions which significantly speed up the
+	  execution of your code.
+	 =20
+	  This is the default setting as v7 chips are rather rare and the
+	  performance penalty to the more advanced variants is rather high.
+	  Lets face it, if you have a v7 chip, you probably know it or
+	  should know about it :)
+
+config MSUPERSPARC
+	bool "v8 - supersparc"
+	help
+	  Select this for a supersparc variant of the SPARC CPU
+	  architecture.  Choosing this adds futher compiler optimisations
+	  for the SuperSPARC chip as found in the SPARCStation 10, 1000 and
+	  2000 series of computers.
+
+config MHYPERSPARC
+	bool "v8 - hypersparc"
+	help
+	  Select this for a hypersparc variant of the SPARC CPU
+	  architecture.
+
+config MSPARCLITE
+	bool "sparclite"
+	help
+	  Select this for a sparclite variant of the SPARC CPU architecture.
+	  Over the v7 architecture it adds the integer multiply, divide step
+	  and scan instructions.
+
+config MF930
+	bool "sparclite - mf930"
+	help
+	  Select this for a f930 variant of the SPARC CPU architecture that
+	  adds compiler based optimisations for the Fujitsu MB86930 chip;
+	  it has no FPU.
+
+config MF934
+	bool "sparclite - mf934"
+	help
+	  Select this for a f934 variant of the SPARC CPU architecture that
+	  adds compiler based optimisations for the Fujitsu MB86934 chip
+	  which is more recent than the f930 and adds a FPU to its handbag.
+
+config MSPARCLITE86X
+	bool "sparclite - 86x"
+	help
+	  Select this for a 86x variant of the SPARC CPU architecture.
+
+config MSPARCLET
+	bool "sparclet"
+	help
+	  Select this for a sparclet variant of the SPARC CPU architecture.
+	  Over the v7 architecture it adds the integer multiply,
+	  multiply/accumulate and divide step and scan instructions.
+
+config MTSC701
+	bool "sparclet - tsc701"
+	help
+	  Select this for a tsc701 variant of the SPARC CPU architecture
+	  that adds compiler based optimisations for the TEMIC SPARClet
+	  chip.
+
+config MV9
+	bool "v9"
+	help
+	  Select this for a v9 variant of the SPARC CPU architecture.  In
+	  addition to the v8 instruction set 64-bit based integer and
+	  floating-point move instructions, three additional floating-point
+	  condition code registers and conditional move instructions have
+	  been added.
+
+config MULTRASPARC
+	bool "v9 - ultrasparc"
+	help
+	  Select this for a ultraspace variant of the SPARC CPU
+	  architecture that adds compiler based optimisations for the
+	  Sun UltraSPARC I/II chips.
+
+config MULTRASPARC3
+	bool "v9 - ultrasparc3"
+	help
+	  Select this for a ultraspace variant of the SPARC CPU
+	  architecture that adds compiler based optimisations for the
+	  Sun UltraSPARC III chip.
+
+endchoice
+
 config PCI
 	bool "Support for PCI and PS/2 keyboard/mouse"
 	help
diff -r -u linux-2.6.13.orig/arch/sparc/Makefile linux-2.6.13/arch/sparc/Ma=
kefile
--- linux-2.6.13.orig/arch/sparc/Makefile	2005-08-29 00:41:01.000000000 +01=
00
+++ linux-2.6.13/arch/sparc/Makefile	2005-09-03 19:49:07.000000000 +0100
@@ -27,6 +27,23 @@
 head-y :=3D arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o
 HEAD_Y :=3D $(head-y)
=20
+cflags-$(CONFIG_MV7)		+=3D -mcpu=3Dv7
+cflags-$(CONFIG_MCYPRESS)	+=3D -mcpu=3Dcypress
+cflags-$(CONFIG_MV8)		+=3D -mcpu=3Dv8
+cflags-$(CONFIG_MSUPERSPARC)	+=3D -mcpu=3Dsupersparc
+cflags-$(CONFIG_MHYPERSPARC)	+=3D -mcpu=3Dhypersparc
+cflags-$(CONFIG_MSPARCLITE)	+=3D -mcpu=3Dsparclite
+cflags-$(CONFIG_MF930)		+=3D -mcpu=3Df930
+cflags-$(CONFIG_MF934)		+=3D -mcpu=3Df934
+cflags-$(CONFIG_MSPARCLITE86X)	+=3D -mcpu=3Dsparclite86x
+cflags-$(CONFIG_MSPARCLET)	+=3D -mcpu=3Dsparclet
+cflags-$(CONFIG_MTSC701)	+=3D -mcpu=3Dtsc701
+cflags-$(CONFIG_MV9)		+=3D -mcpu=3Dv9
+cflags-$(CONFIG_MULTRASPARC)	+=3D -mcpu=3Dultrasparc
+cflags-$(CONFIG_MULTRASPARC3)	+=3D -mcpu=3Dultrasparc3
+
+CFLAGS +=3D $(cflags-y)
+
 core-y +=3D arch/sparc/kernel/ arch/sparc/mm/ arch/sparc/math-emu/
 libs-y +=3D arch/sparc/prom/ arch/sparc/lib/
=20

--rS8CxjVDS/+yyDmU--

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDIuI9Nv5Ugh/sRBYRAp/lAJ9D9t+dDqlhIY+aAgzSVGsm6DOSjgCaAgWE
c3VvYq9bWVzrzDGXtpCjVoQ=
=AZ1z
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--
