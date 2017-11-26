From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sun, 26 Nov 2017 09:49:52 +0000
Subject: Silo on RAID 1
Message-Id: <1511689792.4483.9.camel@xs4all.nl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dear team,

How am i gonna sole this error, with a fresh Silo install on RAID 1?

~ # cat /target/boot/silo.conf

root=/dev/md1
partition=0
default=Linux
read-only
timeout0

image=/vmlinuz
        label=Linux
        initrd=/initrd.img

image=/vmlinuz.old
        label=LinuxOLD
        initrd=/initrd.img.old

~ # /target/sbin/silo -r /target

/etc/silo.conf appears to be valid
Fatal error: File systems other than ext2, ext3, ufs and romfs not yet
supported

~ # df
<snap>

/dev/md0 93207 26714 61681 30% /target/boot
/dev/md1 139839652 1000748 131665692 1% /target
/dev/md2 26766048 45096 25338260 0% /target/home

~ # mount
<snap>

/dev/md0 on /target/boot type ext2
(rw,relatime,block_validity,barrier,user_xattr,acl)

/dev/md1 on /target type ext4 (rw,relatime,errors=remount-
ro,data=ordered)

/dev/md2 on /target/home type ext4 (rw,relatime,data=ordered)

Thanks,

Frans van Berckel
