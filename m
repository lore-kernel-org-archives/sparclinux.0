From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 23 Jul 2005 01:07:43 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <Pine.LNX.4.61.0507222100390.2883@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, 16 Jul 2005, Bob Breuer wrote:

> Bob Breuer wrote:
>> 
>> My suspicion is that highmem may cause problems.  I'll try rearranging 
>> the ram this weekend and see if I can make an initrd fail.
>
> Yes, there are problems with highmem on hypersparcs.

Hi Bob,

I've tried disabling CONFIG_HIGHMEM, but even after that I was able to 
trigger the filesystem corruption. As we were not able to find a 
combination of options/patches which would make it run without crashing, 
there are currently no plans to build 2.6.12 sparc32 kernel images for 
Debian.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

