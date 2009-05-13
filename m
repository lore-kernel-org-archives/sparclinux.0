From: "Hong H. Pham" <hong.pham@windriver.com>
Date: Wed, 13 May 2009 16:50:01 +0000
Subject: Re: [PATCH] sparc64: fix and optimize irq distribution
Message-Id: <4A0AFA39.1080203@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
In-Reply-To: <1242156589-14806-1-git-send-email-hong.pham@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

Thanks for the feedback!  I'll post a new patch with changes per your suggestions.
Regards,
Hong


> Please include the nice benchmark numbers in the changelog.
> It is good to know the effect of a patch and how to measure it.

> If you use:
> obj-$(CONFIG_SPARC64_SMP)   += cpumap.o
> then
>> +#ifdef CONFIG_SMP
> 
> you can drop this ifdef.
> 
> 	Sam
