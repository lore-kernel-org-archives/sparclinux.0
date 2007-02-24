From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Sat, 24 Feb 2007 15:23:45 +0000
Subject: Re: (Sparc64) 2.6.20 seems to ignore initramfs
Message-Id: <Pine.LNX.4.61.0702241622150.16527@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <200702231108.10185.andrew@walrond.org> <200702231446.20929.andrew@walrond.org>
 <45DF056C.2010806@wpkg.org> <200702231547.24667.andrew@walrond.org>
In-Reply-To: <200702231547.24667.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Walrond <andrew@walrond.org>
Cc: Tomasz Chmielewski <mangoo@wpkg.org>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


On Feb 23 2007 15:47, Andrew Walrond wrote:
>On Friday 23 February 2007 15:17, Tomasz Chmielewski wrote:
>>
>> Try to decrease the initramfs size just to know if it boots correctly.
>>
>> I.e., put just a sh/bash/ash/dash binary there (probably /dev/console
>> node, too), executed in init.
>>
>> Then, try to start the kernel with initramfs embedded in the kernel,
>> then as initrd etc. - this will show if the fault is on your side, or
>> kernel's.
>
>I have tracked this down to a broken version of gnu cpio (latest release, 2.7) 
>which was used to create the initramfs archive. Bloody annoying since this 
>has bitten me before! Last time I even sent the maintainer a bug report, and 
>apparently a fix is in CVS waiting for the next release. Ho hum.

Forgot the -c flag, right?



Jan
-- 
