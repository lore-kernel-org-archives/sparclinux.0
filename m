From: Bob Breuer <breuerr@mc.net>
Date: Sat, 05 Feb 2005 04:04:38 +0000
Subject: Re: fix cg14 with serial console
Message-Id: <420445D6.7020700@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41FF079C.7070007@mc.net>
In-Reply-To: <41FF079C.7070007@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David S. Miller wrote:
> Please don't do that so I can test the build of the
> driver even under sparc64.  I made all the sparc FB
> SBUS drivers available on sparc64 for this reason.

My bad, I didn't realize that was the case.  Some of these sparc
bits need as much help as they can get. :)  My intention was to
remove those ifdefs from the code.  I suppose the idea of creating
stubs for the missing prom functions on sparc64 has already been
considered and rejected.

Anyway, for this bug with the cg14, the return value of
prom_getproperty() was not checked.  A quick check of 2.6.10 shows
that the return value of prom_getproperty() is not used in 25 out
of 111 cases for sparc32.  Would it make sense to mark this
function with __must_check?  I suppose the cleanups would be too
much effort for too little gain.

And for good measure, I have appended a revised patch.

Bob


Fix crashing of the cg14 driver when booting with serial console
and a vsimm installed.

diff -X dontdiff -urp linux-2.6.10-clean/drivers/video/cg14.c linux-2.6.10/drivers/video/cg14.c
--- linux-2.6.10-clean/drivers/video/cg14.c	2005-01-12 00:11:02.000000000 -0600
+++ linux-2.6.10/drivers/video/cg14.c	2005-01-31 22:31:36.000000000 -0600
@@ -469,9 +469,9 @@ static void cg14_init_one(struct sbus_de
  	int is_8mb, linebytes, i;

  	if (!sdev) {
-		prom_getproperty(node, "address",
-				 (char *) &bases[0], sizeof(bases));
-		if (!bases[0]) {
+		if (prom_getproperty(node, "address",
+				     (char *) &bases[0], sizeof(bases)) <= 0
+		    || !bases[0]) {
  			printk(KERN_ERR "cg14: Device is not mapped.\n");
  			return;
  		}
