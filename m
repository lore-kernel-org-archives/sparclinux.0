From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Fri, 13 Dec 2013 19:04:55 +0000
Subject: return value of __copy_from_user_inatomic()
Message-Id: <52AB5A57.3010405@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We're seeing some failing test cases due to sparc64's
__copy_from_user_inatomic returning 1 on an incomplete copy rather than
the number of bytes not copied. This results in
iov_iter_copy_from_user_atomic returning the wrong value to
generic_perform_write().

xfstests generic/246 and LTP writev01 both fail on btrfs and nfs because
of this.

Commit 145e1c00 "sparc64: Fix __copy_{to,from}_user_inatomic defines."
changed the behavior by removing the call to the fixups in
__copy_from_user_inatomic and __copy_to_user_inatomic. I found the
reported problem here: https://lkml.org/lkml/2008/11/1/91 , but I don't
understand why the fixup is the problem. The bzero (memset in the code)
is called against the destination, which is a pagecache page, and the
faulting address is sanity-checked against the boundaries.

reverting commit 145e1c00 fixes those failing test cases, and I wasn't
able to recreate the dbench failure on tmpfs.

Thanks,
Dave
