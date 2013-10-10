From: David Miller <davem@davemloft.net>
Date: Thu, 10 Oct 2013 17:02:01 +0000
Subject: Re: [PATCH] only try to find radeon IGP ROM on X86
Message-Id: <20131010.130201.87409851759938579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1310101444090.15296@math.ut.ee>
	<CADnq5_PNU3OvGMqJXVHVCNpRxpd=sO7V9_2uyMT0kaSdj=enpw@mail.gmail.com>
	<alpine.SOC.1.00.1310101824001.25198@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1310101824001.25198@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: alexdeucher@gmail.com, airlied@gmail.com, sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 10 Oct 2013 18:26:39 +0300 (EEST)

>> On Thu, Oct 10, 2013 at 7:51 AM, Meelis Roos <mroos@linux.ee> wrote:
>> > To prevent hangs on non-PC machines (e.g. sparc64), probe Radeon ROM
>> > from ATI IGP only on X86. Fixes hang in this place and allows PCI radeon
>> > detection to move on to next problem.
>> 
>> NACK.  All this function does it attempt to read the rom from the
>> framebuffer PCI BAR.  If you get hangs reading the BAR, then you have
>> larger problems on your platform.  Also, there are non-x86 platforms
>> that IGP chips which this may break.
> 
> OK. But the code seems to just dereference addresses returned from 
> ioremap, but to the best of my knowledge, these are not universally 
> (like on each arch) safe to read without readb/readw/readl. Should I 
> convert these to readb for test?

That's correct, ioremap() returned pointers must not be directly
dereferenced, and must be accessed through the appropriate accessors.
