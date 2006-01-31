From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 31 Jan 2006 03:15:36 +0000
Subject: Re: afbinit failure with 2.6.15 kernels (can no longer load Elite
Message-Id: <Pine.LNX.4.63.0601301915250.3237@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <1138649666.7197.17.camel@polylepis.inforead.com>
In-Reply-To: <1138649666.7197.17.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 30 Jan 2006, David S. Miller wrote:

> From: Ferris McCormick <fmccor@gentoo.org>
> Date: Mon, 30 Jan 2006 19:34:26 +0000
>
>>
>> With kernel-2.6.15 series, the program for loading Elite graphics
>> microcode fails:
>>
>> Is this a known problem, or is the fix for afbinit known?
>
> It's a known problem, something is buggered up in afbinit
> because the change made to the kernel that creates this
> problem is totally correct.

After looking at the description of the problem, I recalled that I've seen 
something like this reported on the debian-sparc list. It turns out that 
we have a bug #346085 [0] filed exactly for this issue, and Ian Viemeister 
has recently submitted a patch [1] for afbinit which reportedly fixes this 
problem. I don't have a possibility to test it myself.

[0] http://bugs.debian.org/346085
[1] http://bugs.debian.org/cgi-bin/bugreport.cgi/afbinit.c.diff?bug46085;msg;att=1

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
