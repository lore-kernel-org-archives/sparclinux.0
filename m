From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 13 Jul 2008 13:50:55 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <487A083F.9010301@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807101702090.19775@engineering.redhat.com> <87iqvb2skz.fsf@basil.nowhere.org> <Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Mikulas Patocka wrote:
>> Mikulas Patocka <mpatocka@redhat.com> writes:
>>
>>> I'm getting crashes with InitIO A100u2w controller on Sparc64 (I had
>>> to fix the endianity issues in the driver, but that's unrelated).
>>
>> x86-64 (and powerpc) solved this a long time ago by only doing
>> opportunistic merging: as in don't announce to the block layer
>> that you can merge, but try to merge anyways. This way SG lists
>> are not necessarily filled completely, but it's still better
>> than overflowing them in some rare cases.
>>
>> -Andi
> 
> There's option "biomerge" that enables that feature. I'm wondering, if
> there's some situation when it should be used.

It would only help if your SG hardware is slower at processing merges
than the IOMMU.

We found some long ago that was (old MPT Fusion) that gained
a few percent on some benchmarks, but that might be quite different
depending on the particular IO controller and chipset.

Also biomerge was used for the AMD K8 GART "IOMMU" which is
relatively slow, the situation on more modern x86 IOMMUs might be
different. Also the GART IOMMU is small and fragmentation is more
likely.

The situation on the more modern real x86 IOMMU (like in newer Intel or IBM
chipsets) might be also different.

Still I would expect that modern IO controllers are typically fast
enough at processing SG lists that it shouldn't matter much.

-Andi
