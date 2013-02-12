From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 12 Feb 2013 19:36:09 +0000
Subject: Re: Should SPARC use cpuidle?
Message-Id: <20130212193609.GA15694@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au> <51197D8B.6010407@kernel.org> <20130212173505.GA2155@merkur.ravnborg.org> <511A837B.8020804@kernel.org> <511A83D8.7020202@kernel.org>
In-Reply-To: <511A83D8.7020202@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Feb 12, 2013 at 01:03:04PM -0500, Len Brown wrote:
> 
> >> Can you please move the definition of sparc_idle to processor_32.h
> >> It is sparc32 specific - and then we do not need the __ASSEMBLY__ guards
> >> as the sparc32 variant are not used from assembler.
> > 
> > sure, let me know if attached works.
> 
> ugh, not accustomed to sending patches via thunderbird.
> hopefully this attachment works...
> 

> >From 358ca5d7e02c4559ad3fbf8135421e4a3753e979 Mon Sep 17 00:00:00 2001
> From: Len Brown <len.brown@intel.com>
> Date: Sat, 9 Feb 2013 23:27:26 -0500
> Subject: [PATCH] sparc idle: rename pm_idle to sparc_idle
> Reply-To: Len Brown <lenb@kernel.org>
> Organization: Intel Open Source Technology Center
> 
> (pm_idle)() is being removed from linux/pm.h
> because Linux does not have such a cross-architecture concept.
> 
> sparc uses an idle function pointer in its architecture
> specific code.  So we re-name sparc use of pm_idle to sparc_idle.
> 
> Maybe some day, SPARC will cut over to cpuidle...
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Acked-by: David S. Miller <davem@davemloft.net>
Build tested - OK.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
