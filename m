From: Nate Karstens <nate.karstens@garmin.com>
Date: Fri, 15 May 2020 15:23:17 +0000
Subject: [PATCH v2] Implement close-on-fork
Message-Id: <20200515152321.9280-1-nate.karstens@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Changli Gao <xiaosuo@gmail.com>


Series of 4 patches to implement close-on-fork. Tests have been
published to https://github.com/nkarstens/ltp/tree/close-on-fork
and cover close-on-fork functionality in the following syscalls:

 * accept(4)
 * dup3(2)
 * fcntl(2)
 * open(2)
 * socket(2)
 * socketpair(2)
 * unshare(2)

Addresses underlying issue in that there is no way to prevent
a fork() from duplicating a file descriptor. The existing
close-on-exec flag partially-addresses this by allowing the
parent process to mark a file descriptor as exclusive to itself,
but there is still a period of time the failure can occur
because the auto-close only occurs during the exec().

One manifestation of this is a race conditions in system(), which
(depending on the implementation) is non-atomic in that it first
calls a fork() and then an exec().

This functionality was approved by the Austin Common Standards
Revision Group for inclusion in the next revision of the POSIX
standard (see issue 1318 in the Austin Group Defect Tracker).

---

This is v2 of the change. See https://lkml.org/lkml/2020/4/20/113
for the original work.

Thanks to everyone who provided comments on the first series of
patches. Here are replies to specific comments:

> I suggest we group the two bits of a file (close_on_exec, close_on_fork)
> together, so that we do not have to dirty two separate cache lines.

I could be mistaken, but I don't think this would improve efficiency.
The close-on-fork and close-on-exec flags are read at different
times. If you assume separate syscalls for fork and exec then
there are several switches between when the two flags are read.
In addition, the close-on-fork flags in the new process must be
cleared, which will be much harder if the flags are interleaved.

> Also the F_GETFD/F_SETFD implementation must use a single function call,
> to not acquire the spinlock twice.

Good point, done.

> How about only allocating the 'close on fork' bitmap the first time
> a process sets a bit in it?

I looked into it and there are side effects I dont't think we want.
For example, if fcntl is used to set the close-on-fork flag, then
there is a chance that it cannot allocate memory, and so we'd have
to return ENOMEM. Seems cleaner to allocate memory up front so that
we know the file has all of the memory it needs.

> You should be able to use the same 'close the fds in this bitmap'
> function for both cases.

I looked into this and I think it is more efficient to prevent the
new process from having a reference to the open file than it is to
temporarily give the new process a reference and then close it later.

> I'm not sure dup_fd() is the best place to check the close-on-fork flag.
> For example, the ksys_unshare() > unshare_fd() > dup_fd() execution path
> seems suspect.

I have a better understanding of clone(2)/unshare(2) now and believe
that dup_fd() is the appropriate place to handle this. clone(2) with
CLONE_FILES set intentionally shares the file descriptor table, so
close-on-fork should not impact that. However, if unshare(2) is later
used to unshare the file descriptor table then the process calling
unshare(2) should automatically close its copy of any file descriptor
with close-on-fork set.

> If the close-on-fork flag is set, then __clear_open_fd() should be
> called instead of just __clear_bit(). This will ensure that
> fdt->full_fds_bits() is updated.

Done. It falls through to the case where the file had not finished
opening yet and leverages its call to __clear_open_fd().

> Need to investigate if the close-on-fork (or close-on-exec) flags
> need to be cleared when the file is closed as part of the
> close-on-fork execution path.

Done. The new file descriptor table starts with all close-on-fork
flags being cleared and dup_fd() gets the close-on-fork flag from
the old file descriptor table.
