From: Matt Foster <matt@mattfoster.me.uk>
Date: Wed, 05 Jul 2006 21:26:17 +0000
Subject: Re: Hypersparc 2.6 SMP success
Message-Id: <Pine.LNX.4.61.0607052223160.1790@molnir.our.house>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0607052155590.1251@molnir.our.house>
In-Reply-To: <Pine.LNX.4.61.0607052155590.1251@molnir.our.house>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 5 Jul 2006, Matt Foster wrote:

> Using Bob's patch against 2.6.17-rc5 my dual SS20 is up and running.
> Several niggles so far:
>
> 2: Having tmpfs turned on seems to do bad things with spamassassin (the
> SS20 is an inbound mail gateway). Every time spamassassin started it
> would through an ext2 error along the lines of:
> EXT2-fs error (device sdb4): ext2_check_page: bad entry in directory
> #155601: rec_len is smaller than (sorry console buffer wraps at 80 cols)
> and / would remount ro. Having disabled tmpfs in the startup scripts
> this problem has gone away now.
>

Arrggh, that will teach me to open my mouth too soon.
Was just trying to stress the system and see if iptables will fit into a
static kernel as well. When make -j 2 was run I got:
EXT2-fs error (device sda2): ext2_check_page: bad entry in directory
#1734156: unaligned directory entry - offset=0, inode17920803, rec_len(265, name_len1

And the build honked very early on.

This is a different physical drive to the one that was barfing upon
spamassasin startup so I'm not too keen to suspect my hardware is dieing
(never had a blip under 2.2.27). Running a UP version of 2.6.17-pre5
with Bobs SMP patch also has the same problem. Perhaps it is load
related.

Matt


