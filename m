From: "Keith M. Wesolowski" <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 20:28:40 +0000
Subject: Re: [PATCH] Fix for arch/sparc/kernel/signal.c and GCC-3.5
Message-Id: <20040329202840.GB24518@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040326124831.GA30978@artsapartment.org>
In-Reply-To: <20040326124831.GA30978@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Mar 26, 2004 at 06:48:31AM -0600, Art Haas wrote:

>  	/* Now see if we want to update the new state. */
>  	if (ssptr) {
> -		void *ss_sp;
> +		unsigned long *ptr, ss_sp;
>  
> -		if (get_user((long)ss_sp, &ssptr->the_stack))
> +		ptr = (unsigned long *)&ssptr->the_stack;
> +		if (get_user(ss_sp, ptr))

I don't think I like the use of unsigned long * here; the real type of
ssptr->the_stack is char *, so why not just use it?  Does this work
for you?

=== arch/sparc/kernel/signal.c 1.26 vs edited ==--- 1.26/arch/sparc/kernel/signal.c	Thu Feb 26 22:27:45 2004
+++ edited/arch/sparc/kernel/signal.c	Mon Mar 29 12:20:33 2004
@@ -1128,9 +1128,9 @@
 
 	/* Now see if we want to update the new state. */
 	if (ssptr) {
-		void *ss_sp;
+		char *ss_sp;
 
-		if (get_user((long)ss_sp, &ssptr->the_stack))
+		if (get_user(ss_sp, &ssptr->the_stack))
 			goto out;
 		/* If the current stack was set with sigaltstack, don't
 		   swap stacks while we are on it.  */


-- 
Keith M Wesolowski
