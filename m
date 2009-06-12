From: Robert Reif <reif@earthlink.net>
Date: Fri, 12 Jun 2009 13:21:24 +0000
Subject: [PATCH] silo: move second to make room for larger kernel
Message-Id: <4A325654.3050201@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020507080104010801030906"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------020507080104010801030906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch changes the location that second is loaded to make room for 
larger kernels.

On sparc32 a kernel is loaded at 0x4000 and second is loaded
at 0x280000. That means that the largest kernel that can be loaded
is 0x27c000 (2605056) bytes.  Sparc32 kernels have been larger
than that for years and it has recently been almost impossible
to strip down a kernel small enough to actually load.

OBP initializes 3 megs of memory and second is loaded at 2.5
meg.  second is only 40k bytes so most of the last 1/2 meg is
wasted.  This patch moves second to 0x2e0000 which leaves
room for a 128k byte second.

This doesn't fix the sparc32 boot problems because you still
need to compile everything as modules and strip the executable
but it is a short term fix.

The long term fix is to make the sparc32 kernel relocatable
like sparc64.  The first step is to make silo load a large sparc32
kernel.  A patch has been submitted 2 years ago
http://marc.info/?l=linux-sparc&m=117952409730426&w=2
that fixes the silo side.  I have tested that patch and it does
fix the problem of decompressing a large kernel.  However
sparc32 kernel is not relocatable so silo tries to move the
kernel down to low memory (0x4000) but refuses because there
is no room for a large kernel.  I think that patch should go
into silo so the silo will be ready for relocatable sparc32
kernels.

Linux head_32.S has some issues with large kernels.  It
is capable of relocating itself from 0x4000 up to higher
memory but has a hard coded size limit of 0x300000. I
tried relocating a smaller image by changing the header
version to 0x300 which should support relocation and
silo was OK with that but the kernel boot failed with an
illegal instruction so the kernel is not OK with being
loaded at an arbitrary location yet. 

I'm looking into changing linux to be relocatable from
an arbitrary address but that requires that the 2 year
old large kernel patch be applied first.

Signed-off-by: Robert Reif <reif@earthlink.net>



--------------020507080104010801030906
Content-Type: text/plain;
 name="silo.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="silo.diff.txt"

diff --git a/Rules.make b/Rules.make
index 4e722f9..f36e2d4 100644
--- a/Rules.make
+++ b/Rules.make
@@ -11,8 +11,8 @@ NM=nm
 ELFTOAOUT=elftoaout
 BIN2H=../common/bin2h
 
-SMALL_RELOC=0x280000
-LARGE_RELOC=0x380000
+SMALL_RELOC=0x2E0000
+LARGE_RELOC=0x3E0000
 
 cc-option-yn = $(shell if $(CC) $(CFLAGS) $(1) -S -o /dev/null -xc /dev/null \
 		> /dev/null 2>&1; then echo "y"; else echo "n"; fi;)

--------------020507080104010801030906--
