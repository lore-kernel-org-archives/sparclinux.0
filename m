From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Fri, 26 Mar 2010 15:33:50 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <1269617630.1031.191.camel@moss-pluto.epoch.ncsc.mil>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 2010-03-25 at 15:48 -0500, Dennis Gilmore wrote:
> On Thursday 25 March 2010 03:24:58 pm David Miller wrote:
> > From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> > Date: Wed, 24 Mar 2010 17:52:57 -0400
> > 
> > > Attached is a patch which disables execmem for sparc. Without it,
> > > selinux does not work at all on SPARC64.
> > > 
> > > This patch should be reasonably non-controversial, because this is
> > > already being done for PPC32.
> > > 
> > > Tested-by: Tom "spot" Callaway <tcallawa@redhat.com> (Ultra 10, T5220)
> > > 
> > >            Dennis Gilmore <dgilmore@redhat.com>
> > > 
> > > Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>
> > 
> > What is the reason why it doesn't work, I'm just curious?
> > 
> > Is there some dependency upon executable stacks or executable data
> > segments always working?  Why can't SELINUX protect be used with
> > that correctly?
> 
> what happens is that almost all binaries end up with execmem set  and selinux 
> prevents them from running.  the system fails to even get close to coming up 
> in a usable state
> 
> Dec 31 18:00:40 sparcbook kernel: type00 audit(8.160:3): avc:  denied  { 
> execmem } for  pid 8 comm="consoletype" 
> scontext=system_u:system_r:consoletype_t:s0 
> tcontext=system_u:system_r:consoletype_t:s0 tclass=process
> Dec 31 18:00:40 sparcbook kernel: type00 audit(8.315:4): avc:  denied  { 
> execmem } for  pid!1 comm="hostname" 
> scontext=system_u:system_r:hostname_t:s0 
> tcontext=system_u:system_r:hostname_t:s0 tclass=process
> Dec 31 18:00:40 sparcbook kernel: type00 audit(8.520:5): avc:  denied  { 
> execmem } for  pid!3 comm="mount" scontext=system_u:system_r:mount_t:s0 
> tcontext=system_u:system_r:mount_t:s0 tclass=process
> Dec 31 18:00:40 sparcbook kernel: type00 audit(8.570:6): avc:  denied  { 
> execmem } for  pid 3 comm="readahead-colle" 
> scontext=system_u:system_r:readahead_t:s0 
> tcontext=system_u:system_r:readahead_t:s0 tclass=process
> 
> is a small sample of the logs you get  not everything fails but almost 
> everything

I think we need to understand why this is happening - it usually
reflects a toolchain problem (that was the case in the ppc32 situation,
and was later fixed in Fedora through an updated toolchain and rebuilt
userland).  eu-readelf -l /bin/hostname shows what?

> > 
> > And since we're touching selinux code we need to at a minimum
> > CC: them so they can have a look at your change.
> > 
> > --------------------
> > diff -up linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc
> > linux-2.6.32.noarch/security/selinux/hooks.c ---
> > linux-2.6.32.noarch/security/selinux/hooks.c.mprotect-sparc	2010-03-10
> > 08:28:20.957571926 -0500 +++
> > linux-2.6.32.noarch/security/selinux/hooks.c	2010-03-10 08:29:15.732698763
> > -0500 @@ -3010,7 +3010,7 @@ static int file_map_prot_check(struct fi
> >  	const struct cred *cred = current_cred();
> >  	int rc = 0;
> > 
> > -#ifndef CONFIG_PPC32
> > +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
> >  	if ((prot & PROT_EXEC) && (!file || (!shared && (prot & PROT_WRITE)))) {
> >  		/*
> >  		 * We are making executable an anonymous mapping or a
> > @@ -3082,7 +3082,7 @@ static int selinux_file_mprotect(struct
> >  	if (selinux_checkreqprot)
> >  		prot = reqprot;
> > 
> > -#ifndef CONFIG_PPC32
> > +#if !defined(CONFIG_PPC32) && !defined(CONFIG_SPARC)
> >  	if ((prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> >  		int rc = 0;
> >  		if (vma->vm_start >= vma->vm_mm->start_brk &&
> > --
> > To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
-- 
Stephen Smalley
National Security Agency

