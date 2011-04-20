From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 20 Apr 2011 12:58:53 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <20110420125853.GA4140@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>
> I'm sorry to mess up stuff even more, the patches 1 and 8 in my series  
> does not compile on UP since setup.h isn't included. But even worse is  
> that the boot_cpu_id is always 0 it seems because it is initialized  
> before BSS is cleared, and boot_cpu_id is part of BSS.
>
> Please apply patches [2/8]..[7/8], and drop [1/8] and [8/8]. It is  
> better we do it the way you proposed (drop boot_cpu patch). I'm sorry  
> that I ever brought up the boot_cpu_id stuff, as that had nothing to do  
> with the genirq patches, and I'm sorry for taking your time like this.

I agree. Lets get the genirq related stuff in and fix the boot_cpu_id stuff
properly later.
Added to my TODO list.

The issue with boot_cpu_id being cleared is btw not new - but
I should have caught that anyway.

	Sam
