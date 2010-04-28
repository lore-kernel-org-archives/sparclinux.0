From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed, 28 Apr 2010 19:57:57 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <1272484677.6013.319.camel@moss-pluto.epoch.ncsc.mil>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2010-04-27 at 11:47 -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Tue, 27 Apr 2010 14:20:21 -0400
> 
> > [root@apollo ~]$ cat /proc/2174/maps
> > 00010000-00014000 r-xp 00000000 fd:00 15466577
> >  /sbin/mingetty
> > 00022000-00024000 rwxp 00002000 fd:00 15466577
> >  /sbin/mingetty
> > 00024000-00046000 rwxp 00000000 00:00 0
> >  [heap]
> 
> SELINUX probably barfs on the executable heap, the PLT is in the HEAP
> just like powerpc32 and that's why VM_DATA_DEFAULT_FLAGS has to set
> both executable and writable.
> 
> You also can't remove the CONFIG_PPC32 ifdefs in selinux, since
> because of the VM_DATA_DEFAULT_FLAGS setting used still in that arch,
> the heap will always have executable permission, just like sparc does.
> You have to support those binaries forever, whether you like it or not.
> 
> Let's just replace the CONFIG_PPC32 ifdef in SELINUX with CONFIG_PPC32
> || CONFIG_SPARC as in Tom's original patch and let's be done with
> this.
> 
> In fact I would go through all the arch/ header files and check the
> VM_DATA_DEFAULT_FLAGS settings and add the necessary new ifdefs to the
> SELINUX code so that other platforms don't have the pain of having to
> go through this process too.

To avoid maintaining per-arch ifdefs, it seems that we could just
directly use (VM_DATA_DEFAULT_FLAGS & VM_EXEC) as the basis for deciding
whether to enable or disable these checks.   VM_DATA_DEFAULT_FLAGS isn't
constant on some architectures but instead depends on
current->personality, but we want this applied uniformly.  So we'll just
use the initial task state to determine whether or not to enable these
checks.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ebee467..a03fd74 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2999,13 +2999,15 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return file_has_perm(cred, file, av);
 }
 
+static int default_noexec;
+
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
 {
 	const struct cred *cred = current_cred();
 	int rc = 0;
 
-#ifndef CONFIG_PPC32
-	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+	if (default_noexec &&
+	    (prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
 		/*
 		 * We are making executable an anonymous mapping or a
 		 * private file mapping that will also be writable.
@@ -3015,7 +3017,6 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		if (rc)
 			goto error;
 	}
-#endif
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -3076,8 +3077,8 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
-#ifndef CONFIG_PPC32
-	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
+	if (default_noexec &&
+	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
 		    vma->vm_end <= vma->vm_mm->brk) {
@@ -3099,7 +3100,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		if (rc)
 			return rc;
 	}
-#endif
 
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }
@@ -5662,6 +5662,8 @@ static __init int selinux_init(void)
 	/* Set the security state for the initial task. */
 	cred_init_security();
 
+	default_noexec = !(VM_DATA_DEFAULT_FLAGS & VM_EXEC);
+
 	sel_inode_cache = kmem_cache_create("selinux_inode_security",
 					    sizeof(struct inode_security_struct),
 					    0, SLAB_PANIC, NULL);

-- 
Stephen Smalley
National Security Agency

