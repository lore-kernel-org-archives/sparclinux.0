From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 02 Jan 2004 21:01:37 +0000
Subject: Re: [sparc32] EXPORT_SYMBOL_DOT & EXPORT_SYMBOL_PRIVATE
Message-Id: <1073077297.4474.116.camel@zorak>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2003-12-24 at 02:37, Keith M Wesolowski wrote:

> Anyway, please try this nasty patch.  If it works for you, it needs to
> be made into a generic facility for exporting symbols starting with .,
> so that people will stop breaking our interface.  I notice that this
> slightly changes the semantics of PRIVATE in that the symbol name will
> now end up in ksymtab_strings, which it previously did not.  Surely
> someone will explain to me why that's bad.

So the good news is that this appears to fix the PRIVATE symbols. The
bad news is that it creates a unique error with the DOT symbols. Now,
modpost spits out a lot of the following (for all the DOT symbols, not
just umul):

WARNING: arp_tables.ko needs unknown symbol umul

Now, this seems legitimate, since umul isn't in System.map. We have
these entries though:

05d2f21f A __crc___sparc_dot_umul
f022a4f8 r __ksymtab___sparc_dot_umul
f022d7d4 r __kcrctab___sparc_dot_umul
f022f8a0 r __kstrtab___sparc_dot_umul

BUT, we're missing __umul. Looking a few lines up in the System.map,
this is obvious (divdi3 as the example):

b391983a A __crc___divdi3
f0118964 T __divdi3
f022a4d8 r __ksymtab___divdi3
f022d7c4 r __kcrctab___divdi3
f022f878 r __kstrtab___divdi3

The logical conclusion seems to be that ___sparc_dot_umul needs to be in
System.map, but that doesn't seem to be what modpost is looking for, it
seems to want __umul.

Thoughts? 

~spot
---
Tom "spot" Callaway <tcallawa(a)redhat*com> LCA, RHCE 
Red Hat Sales Engineer || Aurora SPARC Linux Project Leader

"The author's mathematical treatment of the conception of purpose is
novel and highly ingenious, but heretical and, so far as the present
social order is concerned, dangerous and potentially subversive. Not to
be published." -- Aldous Huxley's "Brave New World"

