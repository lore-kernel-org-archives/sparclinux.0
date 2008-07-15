From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 15 Jul 2008 13:16:52 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807150913020.21598@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080713.202035.172246136.davem@davemloft.net>
 <20080715024424R.fujita.tomonori@lab.ntt.co.jp>
 <Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com>
 <20080715114058A.fujita.tomonori@lab.ntt.co.jp>
 <Pine.LNX.4.64.0807150759430.12202@devserv.devel.redhat.com>
 <487C94CC.3090402@firstfloor.org>
In-Reply-To: <487C94CC.3090402@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Tue, 15 Jul 2008, Andi Kleen wrote:

> Mikulas Patocka wrote:
>>>> BTW. what should the block device driver do when it receives a mapping
>>>> error? (if it aborts the request and it was write request, there will be
>>>> data corruption).
>>>
>>> I'm not sure how a aborted request can corrupt data on disk.
>>
>> Writes are done by an async daemon and no one checks for their
>> completion status. If there are three writes to directory, inode table
>> and inode bitmap and one of these writes fail, there's no code to undo
>> the other two. So the filesystem will be corrupted on write failure.
>
> Normally journaling in ordered mode takes care of that. The transaction
> is not committed until all earlier data has been successfully written.

And if there was write error, then what happens? Retry? Blocking of any 
further updates?

> And even the other fs typically turn the file system read only
> on IO error to prevent further corruption.

There is no interface how filesystem could query that buffer marked with 
mark_buffer_dirty was not written. Or is there?

Mikulas
