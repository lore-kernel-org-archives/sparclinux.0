From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 20 Nov 2007 21:51:53 +0000
Subject: Re: [BUG 2.6.24-rc2] sparc64 sysctl table check failed
Message-Id: <18243.22265.666335.337129@alkaid.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <200711081000.lA8A0pex016234@alkaid.it.uu.se>
In-Reply-To: <200711081000.lA8A0pex016234@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller writes:
 > From: Mikael Pettersson <mikpe@it.uu.se>
 > Date: Thu, 8 Nov 2007 11:00:51 +0100 (MET)
 > 
 > > Booting 2.6.24-rc2 on my Ultra5 results in:
 >  ...
 > > sysctl table check failed: /kernel/scons-poweroff .1.64 procname does not match binary path procname
 > > Call Trace:
 > >  [000000000046bb88] sysctl_check_table+0x650/0x690
 > >  [000000000046bb9c] sysctl_check_table+0x664/0x690
 > >  [00000000006afe80] sysctl_init+0x20/0x28
 > >  [00000000006a8200] kernel_init+0xf0/0x270
 > >  [0000000000427344] kernel_thread+0x38/0x48
 > >  [00000000005e2954] rest_init+0x18/0x58
 > 
 > Thanks for the report, I'll fix it like this:
 > 
 > commit 6afd943d0374b77af902578cd501d0ba02162e18
 > Author: David S. Miller <davem@sunset.davemloft.net>
 > Date:   Mon Nov 19 21:35:42 2007 -0800
 > 
 >     [SYSCTL_CHECK]: Fix typo in KERN_SPARC_SCONS_PWROFF entry string.
 >     
 >     Based upon a report by Mikael Pettersson.
 >     
 >     Signed-off-by: David S. Miller <davem@davemloft.net>
 > 
 > diff --git a/kernel/sysctl_check.c b/kernel/sysctl_check.c
 > index 4abc6d2..603e727 100644
 > --- a/kernel/sysctl_check.c
 > +++ b/kernel/sysctl_check.c
 > @@ -96,7 +96,7 @@ static struct trans_ctl_table trans_kern_table[] = {
 >  
 >  	{ KERN_PTY,			"pty",		trans_pty_table },
 >  	{ KERN_NGROUPS_MAX,		"ngroups_max" },
 > -	{ KERN_SPARC_SCONS_PWROFF,	"scons_poweroff" },
 > +	{ KERN_SPARC_SCONS_PWROFF,	"scons-poweroff" },
 >  	{ KERN_HZ_TIMER,		"hz_timer" },
 >  	{ KERN_UNKNOWN_NMI_PANIC,	"unknown_nmi_panic" },
 >  	{ KERN_BOOTLOADER_TYPE,		"bootloader_type" },

This silenced the warning for me in 2.6.24-rc3.

Thanks,

/Mikael
