From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2017 03:42:43 +0000
Subject: Re: [PATCH RESEND] coredump: Ensure proper size of sparse core files
Message-Id: <20170116.224243.706466650029722351.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161208181151.28127-1-dave.kleikamp@oracle.com>
        <32910821-8b16-1107-20de-b34d029b3e9a@oracle.com>
In-Reply-To: <32910821-8b16-1107-20de-b34d029b3e9a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dave.kleikamp@oracle.com
Cc: viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 11 Jan 2017 13:25:00 -0600

> If the last section of a core file ends with an unmapped or zero page,
> the size of the file does not correspond with the last dump_skip() call.
> gdb complains that the file is truncated and can be confusing to users.
> 
> After all of the vma sections are written, make sure that the file size
> is no smaller than the current file position.
> 
> This problem can be demonstrated with gdb's bigcore testcase on the
> sparc architecture.
> 
> Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>

The lseek() done by dump_skip() should extend the file properly.

Otherwise, everyone would be seeing this problem.

That test case passed all the time when I was last running the GDB
testsuite all the time on sparc64, say 5 years ago.
