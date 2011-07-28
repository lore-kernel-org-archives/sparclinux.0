From: David Miller <davem@davemloft.net>
Date: Thu, 28 Jul 2011 13:23:58 +0000
Subject: Re: Sparc memcpy question
Message-Id: <20110728.062358.2158813297482098296.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAGRGNgUCipgL=m_oyGo7qUxn=mA3VMy_u--fmXZCJsVQSVnh=g@mail.gmail.com>
In-Reply-To: <CAGRGNgUCipgL=m_oyGo7qUxn=mA3VMy_u--fmXZCJsVQSVnh=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 28 Jul 2011 23:08:02 +1000

> On Thu, Jul 28, 2011 at 20:40, Roland Vossen <rvossen@broadcom.com> wrote:
>> I am testing our brcm80211 driver on a sparc64 machine. When executing a
>> memcpy, I encountered an exception:
>>
>> memcpy(fffff8001cf3f46c, fffff8001cf3f57e, 4); results in:
>>
>> Kernel unaligned access at TPC[10489624] brcms_c_ioctl+0x64/0x740 [brcmsmac]
>>
>> I was under the impression that there are no alignment requirements for the
>> pointers to memcpy, but perhaps I am wrong.
> 
> There are, they just happen to be small enough that you haven't noticed.
> 
> As far as I know, every architecture has some alignment requirements.
> Sparc's are the most onerous. I don't know the full details, but I
> believe that it needs to be aligned to the size of any reads. (so
> reading an int - 4 bytes => 4 byte alignment on the addresses)

GCC is inlineing the memcpy, and when doing so it can legally use load
and store instructions based upon the alignment of the types passed
into the memcpy() call.

memcpy() is defined such that compilers are allowed to optimize the
call based upon the typing information of the pointers passed into
the call.  That is exactly what it is doing here.

What the brcm80211 driver is doing needs to be fixed.  It needs
to align objects to their correct alignment.

This is not a Sparc problem, please therefore take it up with the
driver maintainer.

Thanks.
