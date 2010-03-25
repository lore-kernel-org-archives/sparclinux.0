From: David Miller <davem@davemloft.net>
Date: Thu, 25 Mar 2010 20:24:58 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <20100325.132458.08954631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 24 Mar 2010 17:52:57 -0400

> Attached is a patch which disables execmem for sparc. Without it,
> selinux does not work at all on SPARC64.
> 
> This patch should be reasonably non-controversial, because this is
> already being done for PPC32.
> 
> Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10, T5220)
>            Dennis Gilmore <dgilmore@redhat.com>
> Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>

What is the reason why it doesn't work, I'm just curious?

Is there some dependency upon executable stacks or executable data
segments always working?  Why can't SELINUX protect be used with
that correctly?

And since we're touching selinux code we need to at a minimum
CC: them so they can have a look at your change.

--------------------
diff -up linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc linux-2.6.32.noarch/security/selinux/hooks.c
--- linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc	2010-03-10 08:28:20.957571926 -0500
+++ linux-2.6.32.noarch/security/selinux/hooks.c	2010-03-10 08:29:15.732698763 -0500
@@ -3010,7 +3010,7 @@ static int file_map_prot_check(struct fi
 	const struct cred *cred = current_cred();
 	int rc = 0;
 
-#ifndef CONFIG_PPC32
+#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
 	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
 		/*
 		 * We are making executable an anonymous mapping or a
@@ -3082,7 +3082,7 @@ static int selinux_file_mprotect(struct 
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
-#ifndef CONFIG_PPC32
+#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
 	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
