From: Andi Kleen <andi@firstfloor.org>
Date: Tue, 15 Jul 2008 14:06:13 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <487CAED5.7040102@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080713.202035.172246136.davem@davemloft.net> <20080715024424R.fujita.tomonori@lab.ntt.co.jp> <Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com> <20080715114058A.fujita.tomonori@lab.ntt.co.jp> <Pine.LNX.4.64.0807150759430.12202@devserv.devel.redhat.com> <487C94CC.3090402@firstfloor.org> <Pine.LNX.4.64.0807150913020.21598@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807150913020.21598@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

Mikulas Patocka wrote:
> On Tue, 15 Jul 2008, Andi Kleen wrote:
> 
>> Mikulas Patocka wrote:
>>>>> BTW. what should the block device driver do when it receives a mapping
>>>>> error? (if it aborts the request and it was write request, there
>>>>> will be
>>>>> data corruption).
>>>>
>>>> I'm not sure how a aborted request can corrupt data on disk.
>>>
>>> Writes are done by an async daemon and no one checks for their
>>> completion status. If there are three writes to directory, inode table
>>> and inode bitmap and one of these writes fail, there's no code to undo
>>> the other two. So the filesystem will be corrupted on write failure.
>>
>> Normally journaling in ordered mode takes care of that. The transaction
>> is not committed until all earlier data has been successfully written.
> 
> And if there was write error, then what happens? Retry? Blocking of any
> further updates?

The file system is mounted r/o and the transaction is not committed.
Then on mount it is replayed. Similar for a journal write error.

>
>> And even the other fs typically turn the file system read only
>> on IO error to prevent further corruption.
>
> There is no interface how filesystem could query that buffer marked with
> mark_buffer_dirty was not written. Or is there?

For journaled meta data at least the file system usually checks synchronously
(e.g. by using sync_dirty_buffer() and the handling the commit when all
IO completed successfully) For normal data it is just handled by the normal VFS functions.

-Andi


