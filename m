From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 08:35:55 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <4DAE9AEB.9090808@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Daniel Hellstrom <daniel@gaisler.com>
>Date: Wed, 20 Apr 2011 10:12:25 +0200
>
>  
>
>>Sorry I meant the UP 32-bit SUNs, some if not all SMP 32-bit SUNs
>>apparently use the boot_cpu_id Sam is talking about. Have you tried
>>booting on CPU1 with a UP Linux kernel on the SS1000 machine?
>>    
>>
>
>Regardless, we should make it work.
>  
>
I totally agree with you. And it is important for the LEON family as 
well. New quad-core LEONs are designed to be able to run different 
operating systems on different CPUs, or two linux instances in parallel. 
So the hardware supports it, and I believe the SUNs do too.

>It was terrible when I had to fix this on sparc64.
>  
>
I think it is a quite big job, and not really related. I can drop this 
cleanup patch now and make a proper implementation later this year. What 
I want is get more important stuff working with genirq first.

Daniel
