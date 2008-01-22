From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jan 2008 06:25:52 +0000
Subject: Re: [PATCH] sparc64: fix of section mismatch warnings
Message-Id: <20080121.222552.178885438.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121202210.GA552@uranus.ravnborg.org>
In-Reply-To: <20080121202210.GA552@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 22 Jan 2008 06:14:01 +0100

> In eg. psycho_pbm_init() we have:
> 	pbm->scan_bus = psycho_scan_bus;
> 
> I found only one usage of pbm->scan_bus:
> static void __init pci_scan_each_controller_bus(void)
> {
> 	struct pci_pbm_info *pbm;
> 
> 	for (pbm = pci_pbm_root; pbm; pbm = pbm->next)
> 		pbm->scan_bus(pbm);
> }
> 
> This function is marked __init so it looks OK from this suage to
> annotate the functions __init.

Ok, we've established that you and I know it's fine.  Great :-)

I was more concerned with the larger question that contexts like this,
assignment of __init function pointers to dynamic data structure
members, is not checked.

The checker has no way to make sure that pbm->scan_bus() is only
made in __init contexts, even though we can plainly see that is
the case here.

What would be really clever would be a way to mark datastructure
members as "this is a pointer to an __init function".
