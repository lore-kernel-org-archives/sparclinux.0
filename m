From: Stephen Smalley <sds@tycho.nsa.gov>
Date: Tue, 27 Apr 2010 17:05:25 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <1272387925.25840.113.camel@moss-pluto.epoch.ncsc.mil>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2010-04-27 at 11:34 -0400, Tom "spot" Callaway wrote:
> On 04/16/2010 08:36 AM, Stephen Smalley wrote:
> > On Thu, 2010-04-15 at 15:25 -0700, David Miller wrote:
> >> From: Stephen Smalley <sds@tycho.nsa.gov>
> >> Date: Thu, 15 Apr 2010 08:43:05 -0400
> >>
> >>> Your eu-readelf output showed why SELinux is checking execmem - the data
> >>> segment has flags RWE and thus a private file mapping is being created
> >>> with PROT_WRITE and PROT_EXEC.  That's a problem with the compiler
> >>> toolchain - report it to them please.  This was a problem with ppc32
> >>> binaries before secure-plt was introduced.
> >>
> >> I don't really intend to implement secure-plt any time soon on sparc
> >> because there simply is no way to do it efficiently.
> >>
> >> And when you talk about "toolchain issues" that all goes my way
> >> anyways, so just direct such queries to me directly since I handle
> >> both the kernel and toolchain bits entirely myself these days.
> >>
> >> So you'll always have to deal with the PLT section on sparc having
> >> write and execute permission.
> > 
> > Ok.  Can someone with sparc hardware try the patch I posted to see if it
> > suffices?
> 
> Apologies for the delay. Your patch does not suffice.
> 
> With your patch applied, this is the result:
> 
> dracut: Mounted root filesystem /dev/mapper/vg_apollo-lv_root
> dracut: Loading SELinux policy
> type04 audit(1272381939.416:2): enforcing=1 old_enforcing=0
> auidB94967295 sesB94967295
> type03 audit(1272381940.696:3): policy loaded auidB94967295
> sesB94967295
> dracut: Switching root
> type00 audit(1272381942.195:4): avc:  denied  { execmem } for
> pid55 comm="consoletype" scontext=system_u:system_r:consoletype_t:s0
> tcontext=system_u:system_r:consoletype_t:s0 tclass=process
<snip>
> Init trails off and the system never goes anywhere.

Ok, thanks for trying.  Could you send a copy of /proc/pid/maps for one
of these processes that is triggering an execmem check?

-- 
Stephen Smalley
National Security Agency

