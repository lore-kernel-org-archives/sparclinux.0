From: Jurij Smakov <jurij@wooyd.org>
Date: Wed, 08 Jun 2005 04:36:40 +0000
Subject: Re: nuke string.h micro-optimizations from orbit
Message-Id: <Pine.LNX.4.61.0506080031130.4381@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20050607031302.GA2621@holomorphy.com>
In-Reply-To: <20050607031302.GA2621@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 7 Jun 2005, William Lee Irwin III wrote:

> It seems like we get further. I've seen similar oopsen in tty_wakeup on
> shutdown but am not terribly surprised if it could strike us earlier.
> Anyhow, a regression test would be enlightening, as you say. I'll drop
> it in favor of trying "safer" things in the event this is breaking it.

Without the initrd (with esp driver compiled in), it goes much further, as 
far as mounting the real root. Unfortunately, it hangs right at the point 
when init is supposed to start. Last messages I see are:

Attached scsi disk sda at scsi0, channel 0, id 3, lun 0
rtc_sun_init: Registered Mostek RTC driver.
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP established hash table entries: 4096 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 4096 bind 4096)
NET: Registered protocol family 1
NET: Registered protocol family 17
EXT2-fs warning (device sda1): ext2_fill_super: mounting ext3 filesystem as ext2

VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 152k freed

... and here it hangs. I'll poke around to see if I can tell anything 
about why init fails to start.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
