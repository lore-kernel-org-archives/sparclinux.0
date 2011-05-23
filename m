From: Daniel Hellstrom <daniel@gaisler.com>
Date: Mon, 23 May 2011 08:49:36 +0000
Subject: Re: [PATCH 0/2] sparc32,leon: PCI patches
Message-Id: <4DDA1FA0.6080002@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DB68838.1020304@gaisler.com>
In-Reply-To: <4DB68838.1020304@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Fri, 20 May 2011 16:22:33 +0200
>
>  
>
>>I agree that it is a better solution in that case and in other cases
>>too. The problem will be for me to write a PCI Library in the limited
>>context of the PROM, it is much more complex that writing a PCI host
>>driver. The non-free PCI specification alone is heavy, compatibility
>>between PCI revisions and then there is the bridge
>>specification... ugg, I will probably have to leave that to the next
>>generation :)
>>    
>>
>
>I guess if it's really that bad we can merge your PCI changes for
>now, please resubmit them.
>  
>
Thanks, it means a lot to us.

>Julian:
>When I looked at this earlier, I was thinking that we might want to
>introduce a new KConfig variable, maybe CONFIG_LEON_PCI, to hide all
>this stuff behind so we don't have to do any complicated ifdefery or
>change any existing ifdefs.

I will add a PCIC and a LEON_PCI Kconfig option that depends on 
!LEON/LEON and PCI, as julian/sam suggests. I'm busy at the moment with 
other stuff it a pity these problem wasn't brought forward until now, is 
the merge window open until the end of the week?

Thanks,
Daniel
