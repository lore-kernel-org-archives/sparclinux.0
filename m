From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 17 Apr 2007 20:52:37 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <1176843157.4182.28.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2007-04-17 at 15:46 -0500, Tom "spot" Callaway wrote:

> This does the trick. Only issue of concern: Mounting CDROMs seems to
> throw:
> 
> Buffer I/O error on device sr0, logical block 2096896
> Buffer I/O error on device sr0, logical block 2096897
> Buffer I/O error on device sr0, logical block 2096898
> Buffer I/O error on device sr0, logical block 2096899
> Buffer I/O error on device sr0, logical block 2096900
> Buffer I/O error on device sr0, logical block 2096901
> Buffer I/O error on device sr0, logical block 2096902
> Buffer I/O error on device sr0, logical block 2096903
> Buffer I/O error on device sr0, logical block 2096896
> Buffer I/O error on device sr0, logical block 2096897
> 
> None of these errors seems fatal, the CDROM mounts fine, and is usable.

Err, to reply to my own email:

It only mounts correctly with -t iso9660. If I try to mount without
specifying type, it throws those Buffer I/O errors and asks me to
manually specify filesystem type:

[root@tmi media]# mount /dev/cdrom /media/cdrom/
printk: 78 messages suppressed.
Buffer I/O error on device sr0, logical block 161888
Buffer I/O error on device sr0, logical block 161888
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 0
Buffer I/O error on device sr0, logical block 1
Buffer I/O error on device sr0, logical block 2
Buffer I/O error on device sr0, logical block 3
Buffer I/O error on device sr0, logical block 4
Buffer I/O error on device sr0, logical block 5
Buffer I/O error on device sr0, logical block 6
mount: you must specify the filesystem type
[root@tmi media]# 
[root@tmi media]# mount -t iso9660 /dev/cdrom /media/cdrom/
mount: block device /dev/cdrom is write-protected, mounting read-only
Unable to load NLS charset iso8859-1
Unable to load NLS charset iso8859-1
[root@tmi media]# 

~spot


