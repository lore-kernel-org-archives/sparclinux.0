From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 06 Jan 2007 05:22:13 +0000
Subject: Re: [2.6.19.1] ESP regression ?
Message-Id: <20070106052213.GA4880@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <459E1EC7.7050300@systella.fr>
In-Reply-To: <459E1EC7.7050300@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 05, 2007 at 01:35:05PM -0600, Tom 'spot' Callaway wrote:
> 
> Building the SCSI and esp components into the kernel does not change the
> results, it still doesn't work on 2.6.18.1+ on sparc32.
> 
> If anyone has a working sparc32 kernel config that works on a sparc32
> w/esp, please post it here.

Tom,

The 2.6.18 kernel (it is actually 2.6.18.5 plus some patches) we 
currently have in Debian works fine on my SS20. You can find the 
config, kernel, and matching initrd at

http://www.wooyd.org/sparc/

The only patch which touches anything in arch/sparc is also included 
there (bus-id-size.patch), other patches may be viewed at

http://svn.debian.org/wsvn/kernel/dists/sid/linux-2.6/debian/patches/

One esp problem I'm aware of is broken CD-ROM support, the bug report 
with some discussion is available at

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug93894

I've got as far as figuring out that this problem seems to be due to a 
miscompilation with gcc 4.1. If the kernel is built with gcc 4.0, 
CD-ROM actually works again, so it might be some tool chain 
regression. At this point, however, I don't really have time to track 
it down.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
