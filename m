From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 10 Jul 2008 23:57:41 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807101953270.26084@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807101702090.19775@engineering.redhat.com>
 <646765f40807101559q51fbfc50x8e3466e5f202e0c8@mail.gmail.com>
In-Reply-To: <646765f40807101559q51fbfc50x8e3466e5f202e0c8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Calaby <julian.calaby@gmail.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>



On Fri, 11 Jul 2008, Julian Calaby wrote:

> On Fri, Jul 11, 2008 at 07:56, Mikulas Patocka <mpatocka@redhat.com> wrote:
>> Hi
>>
>> I'm getting crashes with InitIO A100u2w controller on Sparc64 (I had to fix
>> the endianity issues in the driver, but that's unrelated).
>>
>> When I examined the crashes, it turned out that SCSI layer passed requests
>> with too many segments. The controller has at most 32 SG entries per
>> request. It sets shost->sg_tablesize to 32, but despite this, larger
>> requests were submitted to it --- this resulted in overwriting random memory
>> and crashes.
>
> [snip]
>
> Should this have been CC'd to linux-scsi too? This sounds like it
> could be a bug at their end.
>
> Thanks,
>
> -- 
> Julian Calaby

This is not a bug in scsi layer, those "nr_hw_segments" miscalculations 
are hapenning in block/blk-merge.c and they can show up with any block 
device driver that has small number of SG entries.

But I can CC it there, just for their information.

Mikulas
