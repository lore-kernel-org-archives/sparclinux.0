From: "Art Haas" <ahaas@airmail.net>
Date: Fri, 26 Mar 2004 12:48:31 +0000
Subject: [PATCH] Fix for arch/sparc/kernel/signal.c and GCC-3.5
Message-Id: <20040326124831.GA30978@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here's a patch that changes things so that the file compiles with
GCC-3.5. The get_user() macro is really hairy, and after looking
at the expanded code, the problem regarding the lvalue cast seems
to lie in that the first argument to the macro is (long)ss_sp,
and the (long) cast is the problem. My changes below remove
the cast, both in the macro and several lines later. I looked
at the file 'sunos_ioctl.c' to see several places where get_user()
was called without problems, and the addition of the 'ptr' variable
resulted from what I saw in that file.

With this change the file compiled with GCC-3.5, and in fact my
'make image modules' completed successfully.  I haven't tried to
boot this kernel yet, as I have other things building on the machine.

I'm not 100% certain this patch is correct, and comments would 
be welcomed. The changes make the compiler happy, but a happy
compiler producing correct code is the ultimate goal.

Art Haas

=== arch/sparc/kernel/signal.c 1.26 vs edited ==--- 1.26/arch/sparc/kernel/signal.c	Fri Feb 27 00:27:45 2004
+++ edited/arch/sparc/kernel/signal.c	Thu Mar 25 22:07:44 2004
@@ -1128,9 +1128,10 @@
 
 	/* Now see if we want to update the new state. */
 	if (ssptr) {
-		void *ss_sp;
+		unsigned long *ptr, ss_sp;
 
-		if (get_user((long)ss_sp, &ssptr->the_stack))
+		ptr = (unsigned long *)&ssptr->the_stack;
+		if (get_user(ss_sp, ptr))
 			goto out;
 		/* If the current stack was set with sigaltstack, don't
 		   swap stacks while we are on it.  */
@@ -1141,7 +1142,7 @@
 		/* Since we don't know the extent of the stack, and we don't
 		   track onstack-ness, but rather calculate it, we must
 		   presume a size.  Ho hum this interface is lossy.  */
-		current->sas_ss_sp = (unsigned long)ss_sp - SIGSTKSZ;
+		current->sas_ss_sp = ss_sp - SIGSTKSZ;
 		current->sas_ss_size = SIGSTKSZ;
 	}
 	ret = 0;
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
