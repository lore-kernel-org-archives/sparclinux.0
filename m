From: Jim Gifford <maillist@jg555.com>
Date: Fri, 11 Nov 2005 00:32:46 +0000
Subject: Silo - Modern Toolchain - Without elftoaout
Message-Id: <4373E6AE.9030007@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I have a team of people trying to figure out how to remove elftoaout=20
from the Kernel and Silo builds.

We started with silo, because it won't compile with a modern toolchain,=20
and after we get these techniques developed, it could then be merged=20
into the kernel to also remove the depency on elftoaout.

You will need to use a 2.16.1 binutils with a patch that's going to be=20
merged into the main tree.
http://sourceware.org/ml/binutils/2005-10/msg00420.html

Now we got the first.b to build with the patch at the end of this email,=20
which shows our proof concept. When we tried to apply our ideas to=20
second.b that's where we ran into a problem, because of the gzipping =20
and whatever the util program does to the compiled object. If anyone has=20
any suggestions on how to get around that issue, feel free to send me an=20
email, we will try anything. We are thinking we will have to utilize an=20
linker.script, but that's as far as we have gone and hence my email to=20
sparc liinux community.

Patch for first/Makefile

--- Makefile.orig       2005-10-11 14:30:12.000000000 -0700
+++ Makefile    2005-10-11 14:47:54.000000000 -0700
@@ -41,12 +41,12 @@
       $(STRIP) first

first.b: first
-       $(ELFTOAOUT) -o first.b first
+       $(OBJCOPY) -O a.out-sunos-big first first.b
       echo -n 'SILO'$(IMGVERSION) | $(DD) of=3Dfirst.b bs=3D8 conv=3Dnotru=
nc=20
seek=3D3 count=3D1
       $(DD) if=3D/dev/zero of=3Dfirst.b bs=3D4 count=3D1 seek=127

ultra.o: ultra.S
-       $(CC) $(CFLAGS) -c -Wa,-Av9a ultra.S
+       $(CC) $(CFLAGS) -Wa,-Av9a -c ultra.S

ultra: ultra.o
       $(LD) $(LDFLAGS) -o ultra ultra.o
@@ -54,13 +54,13 @@
       $(STRIP) ultra

ultra.b: ultra
-       $(ELFTOAOUT) -o ultra.b ultra
+       $(OBJCOPY) -I elf32-sparc -O a.out-sunos-big ultra ultra.b
       echo -n 'SILO'$(IMGVERSION) | $(DD) of=3Dultra.b bs=3D8 conv=3Dnotru=
nc=20
seek=3D3 count=3D1
       echo -n -e '\340' | $(DD) of=3Dultra.b bs=3D1 count=3D1 seek=3D7=20
conv=3Dnotrunc
       $(DD) if=3D/dev/zero of=3Dultra.b bs=3D4 count=3D1 seek=127

generic.o: generic.S
-       $(CC) $(CFLAGS) -c -Wa,-Av9a generic.S
+       $(CC) $(CFLAGS) -Wa,-Av9a -c generic.S

generic: generic.o
       $(LD) $(LDFLAGS) -o generic generic.o
@@ -68,13 +68,13 @@
       $(STRIP) generic

generic.b: generic
-       $(ELFTOAOUT) -o generic.b generic
+       $(OBJCOPY) -I elf32-sparc -O a.out-sunos-big generic generic.b
       echo -n 'SILO'$(IMGVERSION) | $(DD) of=3Dgeneric.b bs=3D8=20
conv=3Dnotrunc seek=3D3 count=3D1
       echo -n -e '\340' | $(DD) of=3Dgeneric.b bs=3D1 count=3D1 seek=3D7=20
conv=3Dnotrunc
       $(DD) if=3D/dev/zero of=3Dgeneric.b bs=3D4 count=3D1 seek%5

fd.o: fd.S
-       $(CC) $(CFLAGS) -c -Wa,-Av9a fd.S
+       $(CC) $(CFLAGS) -Wa,-Av9a -c fd.S

fd: fd.o
       $(LD) $(LDFLAGS) -o fd fd.o
@@ -82,7 +82,7 @@
       $(STRIP) fd

fd.b: fd
-       $(ELFTOAOUT) -o fd.b fd
+       $(OBJCOPY) -I elf32-sparc -O a.out-sunos-big fd fd.b
       echo -n 'SILO'$(IMGVERSION) | $(DD) of=FD.b bs=3D8 conv=3Dnotrunc=20
seek=3D3 count=3D1
       echo -n -e '\340' | $(DD) of=FD.b bs=3D1 count=3D1 seek=3D7 conv=3Dn=
otrunc
       $(DD) if=3D/dev/zero of=FD.b bs=3D4 count=3D1 seek%5


--=20
----
Jim Gifford
maillist@jg555.com

