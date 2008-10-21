From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 21 Oct 2008 05:23:09 +0000
Subject: [PATCH] sparc: Add checkstack support
Message-Id: <20081021052309.GA26928@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add sparc support to checkstack.

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: linux/scripts/checkstack.pl
=================================--- linux.orig/scripts/checkstack.pl	2008-10-21 05:48:49.000000000 +0100
+++ linux/scripts/checkstack.pl	2008-10-21 06:10:35.000000000 +0100
@@ -14,6 +14,7 @@
 #	M68k port by Geert Uytterhoeven and Andreas Schwab
 #	AVR32 port by Haavard Skinnemoen <hskinnemoen@atmel.com>
 #	PARISC port by Kyle McMartin <kyle@parisc-linux.org>
+#	sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
 #
 #	Usage:
 #	objdump -d vmlinux | scripts/checkstack.pl [arch]
@@ -94,6 +95,9 @@
 	} elsif ($arch =~ /^blackfin$/) {
 		#   0:   00 e8 38 01     LINK 0x4e0;
 		$re = qr/.*[[:space:]]LINK[[:space:]]*(0x$x{1,8})/o;
+	} elsif ($arch eq 'sparc') {
+		# f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
+		$re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
 	} else {
 		print("wrong or unknown architecture \"$arch\"\n");
 		exit
