From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 17 Jan 2017 07:55:21 +0000
Subject: Re: [PATCH RESEND] coredump: Ensure proper size of sparse core files
Message-Id: <20170117075521.GA19654@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20161208181151.28127-1-dave.kleikamp@oracle.com>
 <32910821-8b16-1107-20de-b34d029b3e9a@oracle.com>
 <20170116.224243.706466650029722351.davem@davemloft.net>
In-Reply-To: <20170116.224243.706466650029722351.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: dave.kleikamp@oracle.com, viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Jan 16, 2017 at 10:42:43PM -0500, David Miller wrote:
> The lseek() done by dump_skip() should extend the file properly.

lseek never extends a file.  It just moves the current file position.
So if you do not have a write after the lseek it does nothing.
