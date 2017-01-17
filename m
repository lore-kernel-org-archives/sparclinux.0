From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2017 20:44:53 +0000
Subject: Re: [PATCH RESEND] coredump: Ensure proper size of sparse core files
Message-Id: <20170117.154453.1379705071819128189.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <32910821-8b16-1107-20de-b34d029b3e9a@oracle.com>
        <20170116.224243.706466650029722351.davem@davemloft.net>
        <20170117075521.GA19654@infradead.org>
In-Reply-To: <20170117075521.GA19654@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hch@infradead.org
Cc: dave.kleikamp@oracle.com, viro@zeniv.linux.org.uk, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 16 Jan 2017 23:55:21 -0800

> On Mon, Jan 16, 2017 at 10:42:43PM -0500, David Miller wrote:
>> The lseek() done by dump_skip() should extend the file properly.
> 
> lseek never extends a file.  It just moves the current file position.
> So if you do not have a write after the lseek it does nothing.

Ok, then the only other feedback I have is that we should probably
defer this truncate() call until the last possible dump write occurs
rather than right after the VMA loop.
