From: "Art Haas" <ahaas@airmail.net>
Date: Sun, 06 Feb 2005 22:23:39 +0000
Subject: Re: fix cg14 with serial console
Message-Id: <20050206222339.GB24159@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <41FF079C.7070007@mc.net>
In-Reply-To: <41FF079C.7070007@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Feb 04, 2005 at 09:41:42PM -0800, David S. Miller wrote:
> On Fri, 04 Feb 2005 22:04:38 -0600
> Bob Breuer <breuerr@mc.net> wrote:
> > Anyway, for this bug with the cg14, the return value of
> > prom_getproperty() was not checked.  A quick check of 2.6.10 shows
> > that the return value of prom_getproperty() is not used in 25 out
> > of 111 cases for sparc32.  Would it make sense to mark this
> > function with __must_check?  I suppose the cleanups would be too
> > much effort for too little gain.
> 
> That would be a great idea.  In particular, things like
> tree.c:prom_nodematch() should check (and return "0" when
> error occurs).

How does this look? It compiled but is untested in a running kernel.

Art Haas

=== arch/sparc/prom/tree.c 1.1 vs edited ==--- 1.1/arch/sparc/prom/tree.c	2002-02-05 11:40:23 -06:00
+++ edited/arch/sparc/prom/tree.c	2005-02-06 16:18:29 -06:00
@@ -176,8 +176,11 @@
  */
 int prom_nodematch(int node, char *name)
 {
+	int error;
+
 	static char namebuf[128];
-	prom_getproperty(node, "name", namebuf, sizeof(namebuf));
+	error = prom_getproperty(node, "name", namebuf, sizeof(namebuf));
+	if (error = -1) return 0;
 	if(strcmp(namebuf, name) = 0) return 1;
 	return 0;
 }

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
