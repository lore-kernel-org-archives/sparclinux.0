From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Wed, 12 Dec 2007 23:30:45 +0000
Subject: Re: Why/when use 0x10 and 0x90 for system calls?
Message-Id: <Pine.LNX.4.64.0712130030100.32346@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <1d1b2964cccd05bccee60c12f0abf191@localhost>
In-Reply-To: <1d1b2964cccd05bccee60c12f0abf191@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Dec 11 2007 16:47, Javier Barrio wrote:
>
>Oh, I think I got it:
>
>ta 0x10 seems to actually become in 
>
>trap always HV_FAST_TRAP + 0x10 = ta 0x80+0x10 = ta 0x90
>
>The same applies for 'ta 0x8' for Solaris binary emulation:
>
>0x8 + 0x80 = 0x88
>
>It seems the OS/compiler is smart enough to understand both 0x90 and
>0x10 while strace is not.

If so, you should find '... & 0x80' or similar in the kernel source
and a lack there of in strace :)
