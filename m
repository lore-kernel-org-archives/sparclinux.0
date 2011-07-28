From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 28 Jul 2011 13:08:02 +0000
Subject: Re: Sparc memcpy question
Message-Id: <CAGRGNgUCipgL=m_oyGo7qUxn=mA3VMy_u--fmXZCJsVQSVnh=g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Roland,

First things first, you're asking the wrong person. =)

This sounds like a sparc specific question, so it should really be
addressed to the sparclinux mailing list as that's where the sparc
people hang out. I've CC'd that list in this mail.

On Thu, Jul 28, 2011 at 20:40, Roland Vossen <rvossen@broadcom.com> wrote:
> Hello Julian,
>
> I am testing our brcm80211 driver on a sparc64 machine. When executing a
> memcpy, I encountered an exception:
>
> memcpy(fffff8001cf3f46c, fffff8001cf3f57e, 4); results in:
>
> Kernel unaligned access at TPC[10489624] brcms_c_ioctl+0x64/0x740 [brcmsmac]
>
> I was under the impression that there are no alignment requirements for the
> pointers to memcpy, but perhaps I am wrong.

There are, they just happen to be small enough that you haven't noticed.

As far as I know, every architecture has some alignment requirements.
Sparc's are the most onerous. I don't know the full details, but I
believe that it needs to be aligned to the size of any reads. (so
reading an int - 4 bytes => 4 byte alignment on the addresses)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
