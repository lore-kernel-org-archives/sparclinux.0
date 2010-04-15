From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Thu, 15 Apr 2010 12:43:05 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <1271335385.26565.28.camel@moss-pluto.epoch.ncsc.mil>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2010-03-26 at 11:33 -0400, Stephen Smalley wrote:
> On Thu, 2010-03-25 at 15:48 -0500, Dennis Gilmore wrote:
> > On Thursday 25 March 2010 03:24:58 pm David Miller wrote:
> > > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > > Date: Wed, 24 Mar 2010 17:52:57 -0400
> > > 
> > > > Attached is a patch which disables execmem for sparc. Without it,
> > > > selinux does not work at all on SPARC64.
> > > > 
> > > > This patch should be reasonably non-controversial, because this is
> > > > already being done for PPC32.
> > > > 
> > > > Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10, T5220)
> > > > 
> > > >            Dennis Gilmore <dgilmore@redhat.com>
> > > > 
> > > > Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>
> > > 
> > > What is the reason why it doesn't work, I'm just curious?
> > > 
> > > Is there some dependency upon executable stacks or executable data
> > > segments always working?  Why can't SELINUX protect be used with
> > > that correctly?
> > 
> > what happens is that almost all binaries end up with execmem set  and selinux 
> > prevents them from running.  the system fails to even get close to coming up 
> > in a usable state
> > 
> > Dec 31 18:00:40 sparcbook kernel: type00 audit(8.160:3): avc:  denied  { 
> > execmem } for  pid 8 comm="consoletype" 
> > scontext=system_u:system_r:consoletype_t:s0 
> > tcontext=system_u:system_r:consoletype_t:s0 tclass=process
> > Dec 31 18:00:40 sparcbook kernel: type00 audit(8.315:4): avc:  denied  { 
> > execmem } for  pid!1 comm="hostname" 
> > scontext=system_u:system_r:hostname_t:s0 
> > tcontext=system_u:system_r:hostname_t:s0 tclass=process
> > Dec 31 18:00:40 sparcbook kernel: type00 audit(8.520:5): avc:  denied  { 
> > execmem } for  pid!3 comm="mount" scontext=system_u:system_r:mount_t:s0 
> > tcontext=system_u:system_r:mount_t:s0 tclass=process
> > Dec 31 18:00:40 sparcbook kernel: type00 audit(8.570:6): avc:  denied  { 
> > execmem } for  pid 3 comm="readahead-colle" 
> > scontext=system_u:system_r:readahead_t:s0 
> > tcontext=system_u:system_r:readahead_t:s0 tclass=process
> > 
> > is a small sample of the logs you get  not everything fails but almost 
> > everything
> 
> I think we need to understand why this is happening - it usually
> reflects a toolchain problem (that was the case in the ppc32 situation,
> and was later fixed in Fedora through an updated toolchain and rebuilt
> userland).  eu-readelf -l /bin/hostname shows what?

(never received your reply but found it in the mailing list archives)

Your eu-readelf output showed why SELinux is checking execmem - the data
segment has flags RWE and thus a private file mapping is being created
with PROT_WRITE and PROT_EXEC.  That's a problem with the compiler
toolchain - report it to them please.  This was a problem with ppc32
binaries before secure-plt was introduced.

In the meantime, I'd be interested in knowing whether we truly need to
disable all of the exec* checking or if we can in fact just disable this
specific case, ala:

Re-enable full SELinux exec* checking on ppc32 since the compiler
toolchain has long since been fixed and userland has been rebuilt, and
introduce a special case for sparc that only disables the execmem check
for private file mappings but retains it for anonymous mappings and
retains the other exec* checks.

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 63c2d36..9a4d0e4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3004,8 +3004,11 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 	const struct cred *cred = current_cred();
 	int rc = 0;
 
-#ifndef CONFIG_PPC32
+#if defined(CONFIG_SPARC)
+	if ((prot & PROT_EXEC) && !file) {
+#else
 	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
+#endif
 		/*
 		 * We are making executable an anonymous mapping or a
 		 * private file mapping that will also be writable.
@@ -3015,7 +3018,6 @@ static int file_map_prot_check(struct file *file, unsigned long prot, int shared
 		if (rc)
 			goto error;
 	}
-#endif
 
 	if (file) {
 		/* read access is always possible with a mapping */
@@ -3076,7 +3078,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	if (selinux_checkreqprot)
 		prot = reqprot;
 
-#ifndef CONFIG_PPC32
 	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
 		if (vma->vm_start >= vma->vm_mm->start_brk &&
@@ -3099,7 +3100,6 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 		if (rc)
 			return rc;
 	}
-#endif
 
 	return file_map_prot_check(vma->vm_file, prot, vma->vm_flags&VM_SHARED);
 }



-- 
Stephen Smalley
National Security Agency

