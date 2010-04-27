From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Tue, 27 Apr 2010 18:20:21 +0000
Subject: Re: [PATCH] Disable execmem for sparc
Message-Id: <4BD72AE5.8040407@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4BAA89B9.2030102@redhat.com>
In-Reply-To: <4BAA89B9.2030102@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/27/2010 01:05 PM, Stephen Smalley wrote:
> Ok, thanks for trying.  Could you send a copy of /proc/pid/maps for one
> of these processes that is triggering an execmem check?

Mingetty seems like one of the few that is persistent. With the system
rebooted into a kernel with the original patch applied, and selinux
enabled, here's the info:

[spot@apollo ~]$ ps ax |grep minge
 2174 tty4     Ss+    0:00 /sbin/mingetty tty4
 2175 tty5     Ss+    0:00 /sbin/mingetty tty5
 2176 tty2     Ss+    0:00 /sbin/mingetty tty2
 2177 tty3     Ss+    0:00 /sbin/mingetty tty3
 2178 tty1     Ss+    0:00 /sbin/mingetty tty1
 2179 tty6     Ss+    0:00 /sbin/mingetty tty6

[root@apollo ~]$ cat /proc/2174/maps
00010000-00014000 r-xp 00000000 fd:00 15466577
 /sbin/mingetty
00022000-00024000 rwxp 00002000 fd:00 15466577
 /sbin/mingetty
00024000-00046000 rwxp 00000000 00:00 0
 [heap]
f7d58000-f7ee2000 r-xp 00000000 fd:00 13893929
 /lib/libc-2.11.1.so
f7ee2000-f7ef2000 ---p 0018a000 fd:00 13893929
 /lib/libc-2.11.1.so
f7ef2000-f7ef4000 r--p 0018a000 fd:00 13893929
 /lib/libc-2.11.1.so
f7ef4000-f7ef8000 rwxp 0018c000 fd:00 13893929
 /lib/libc-2.11.1.so
f7ef8000-f7efa000 rwxp 00000000 00:00 0
f7efa000-f7efc000 rw-p 00000000 00:00 0
f7f12000-f7f14000 rw-p 00000000 00:00 0
f7f14000-f7f36000 r-xp 00000000 fd:00 13893922
 /lib/ld-2.11.1.so
f7f44000-f7f46000 r--p 00020000 fd:00 13893922
 /lib/ld-2.11.1.so
f7f46000-f7f48000 rwxp 00022000 fd:00 13893922
 /lib/ld-2.11.1.so
ffacc000-ffaf6000 rw-p 00000000 00:00 0
 [stack]

Please let me know if this is not what you needed.

~spot
