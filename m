From: Georg Chini <georg.chini@triaton-webhosting.com>
Date: Tue, 08 Feb 2005 16:42:53 +0000
Subject: Re: Xorg does not work on sparc32 in 2.6 (except on cg14)
Message-Id: <4208EC0D.4040109@triaton-webhosting.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1107553760.3951.211.camel@localhost.localdomain>
In-Reply-To: <1107553760.3951.211.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Tom 'spot' Callaway wrote:

> This is being BTFIXEDUP to pte_pfn. 
> 
> Removing the if (srmmu_device_memory(pte_val(pte))) check stops the
> oops, but it doesn't make X work. The screen goes blank, but the X
> session never appears.
> 

Hi,

maybe this is an error in the driver for TGX. My SS5 has a TCX card and
I had the same problem (screen blank but no X visible). Some other drivers
showed the problem too. As I am no kernel programmer, I sent something that
makes it work for me (but no real patch) in December. I think it didn't
make it into the kernel yet. Perhaps your problem is similar.
Have a look at the archive, just search for TCX. Hope this helps.

Regards
        Georg

