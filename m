From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 30 Dec 2010 20:56:12 +0000
Subject: sparc32 and GCC - build and boot failures
Message-Id: <20101230205612.GA12356@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In the need for updated toolchains for sparc and sparc64 I
have started adding support for sparc in crosstool-ng[*].

In this process I have tested several gcc versions.
I tried to build for and test a kernel on my sparc classic box (32 bit).

gcc version      Result
4.4.1            OK  (kernel builds and the final kernel can boot)
4.4.2            Not tested
4.4.3            Not tested
4.4.4            BAD (Kernel can build but fails during boot)
4.4.5            BAD (Kernel can build but fails during boot)
4.5.1            BAD (Build fails with a spill related ICE - http://gcc.gnu.org/bugzilla/show_bug.cgi?id5664)
4.5.2            OK  (kernel builds and boots)

This is all provided for information only in case others
decides to play with recent gcc versions on sparc (32 bit).


The boot failure I see manifest itself like this in the boot log:

Freeing initrd memory: 4108k freed
BUG: Bad page state in process swapper  pfn:0037a
page:f09ad7a0 count:0 mapcount:0 mapping:  (null) index:0x0
page flags: 0x80000(buddy)
[f006b918 : free_hot_cold_page+0x18/0x1cc ]
[f001d614 : free_initrd_mem+0x9c/0xd0 ]
...
And later it hangs with "rcu_sched_state detected stall on CPU 0 (t000 jiffies)

I have not tried to track down the cause of the boot failure.
A quick search did not reveal any gcc bugzilla entry.


[*] I tried to build a toolchain manually but I never found a
decent HOWTO - so gave up and went for crosstool-ng.
Adding sparc support to crosstool-ng also helps much
more people than a random howto somewhere on the net.

I will announce it on this list when crosstol-ng
has sparc support included.

See http://ymorin.is-a-geek.org/projects/crosstool
for more info on crosstool-ng.

	Sam
