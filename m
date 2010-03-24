From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 24 Mar 2010 21:52:57 +0000
Subject: [PATCH] Disable execmem for sparc
Message-Id: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000403070008070804010202"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000403070008070804010202
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Attached is a patch which disables execmem for sparc. Without it,
selinux does not work at all on SPARC64.

This patch should be reasonably non-controversial, because this is
already being done for PPC32.

Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10, T5220)
           Dennis Gilmore <dgilmore@redhat.com>
Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>

Thanks in advance,

~spot

--------------000403070008070804010202
Content-Type: text/plain;
 name="linux-2.6-sparc-selinux-mprotect-checks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-2.6-sparc-selinux-mprotect-checks.patch"

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

--------------000403070008070804010202--
