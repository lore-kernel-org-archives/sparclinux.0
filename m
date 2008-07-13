From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 13 Jul 2008 13:34:33 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807101702090.19775@engineering.redhat.com>
 <87iqvb2skz.fsf@basil.nowhere.org>
In-Reply-To: <87iqvb2skz.fsf@basil.nowhere.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

> Mikulas Patocka <mpatocka@redhat.com> writes:
>
>> I'm getting crashes with InitIO A100u2w controller on Sparc64 (I had
>> to fix the endianity issues in the driver, but that's unrelated).
>
> x86-64 (and powerpc) solved this a long time ago by only doing
> opportunistic merging: as in don't announce to the block layer
> that you can merge, but try to merge anyways. This way SG lists
> are not necessarily filled completely, but it's still better
> than overflowing them in some rare cases.
>
> -Andi

There's option "biomerge" that enables that feature. I'm wondering, if 
there's some situation when it should be used.

Mikulas
