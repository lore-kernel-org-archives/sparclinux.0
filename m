From: Mikael Pettersson <mikpe@it.uu.se>
Date: Wed, 11 Jul 2007 01:11:27 +0000
Subject: Re: [BUG sparc64] 2.6.22-rc broke X on Ultra5
Message-Id: <200707110111.l6B1BRp0001640@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <18002.44181.639121.720839@alkaid.it.uu.se>
In-Reply-To: <18002.44181.639121.720839@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 09 Jul 2007 00:35:28 -0700 (PDT), David Miller wrote:
>From: Dmitry Artamonow <mad_soft@inbox.ru>
>Date: Sun, 8 Jul 2007 22:05:08 +0400
>
>> On 23:02 Fri 06 Jul     , David Miller wrote:
>> > 
>> > > Seems that your patch was not the only related change between -rc4 and -rc5.
>> > > Anyway, X still doesn't work with -rc5 so probably problem is somewhere
>> > > else. I sent you privately strace logs for X with 2.6.22-rc5.
>> > 
>> > Some more progress, there seems to be code in the X server that
>> > hard-codes the I/O and MEM space sizes based upon the PCI
>> > IDs of the Sun PCI host controller.  Barf...
>> > 
>> > Does it make further progress with the following patch?
>> > 
>> Well, no. I applied it against -rc7 and Xorg still doesn't work (as far as
>> I can tell by its console output - until tomorrow I have only remote access
>> to my U10). Sent you another portion of logs.
>> Just in case, here's results from your testcase program:
>> 
>> vanilla 2.6.22-rc7:
>> x0:0x8e100080
>> x8:0x00000006
>> 
>> 2.6.22-rc7 + patch:
>> x0:0x8e100020
>> x8:0x00000000
>
>Something is very very wrong.  That's the last thing in the world my
>patch should cause to happen.  rc4 to rc5 also contained no changes
>that should have made that problem go away, so something else
>is afoot.
>
>I have X fully working on my ultra5 with a one-line patch to
>Ubuntu-feisty's xserver source tree which should be entirely
>irrelevant to your cases.
>
>I've tried everything to reproduce that test program failure on
>any of my systems and I can't, so could you do some detective
>work to try and see if maybe it's PREEMPT or a miscompile or
>something like that?
>
>I'm out of ideas, so your help in doing the debugging to figure
>out where this comes from since I can't make it happen here is
>appreciated :-)

(I've been offline lately, SPARC-wise, hence the late reply.)

Kernel 2.6.22 final:
- X won't start with similar errors as before in 2.6.22-rc
- your PCI test program gives the correct outputs:
  x0:0x8e100080
  x8:0x00000006
- adding your patch to skip pci_host_bridge_write_pci_cfg()
  in pci_common.c broke the test program, but X still won't
  start as before

So far I've compiled the kernel with gcc-4.2.0. Recompiling
2.6.22 vanilla with gcc-3.4.6 makes no difference: X doesn't work.

I can post the full .config if needed, but it has nothing exotic
in it AFAIK. Even PREEMPT is disabled (and always has been).

/Mikael
