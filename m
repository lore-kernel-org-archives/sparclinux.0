From: Andi Kleen <andi@firstfloor.org>
Date: Sat, 12 Jul 2008 12:30:04 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <87iqvb2skz.fsf@basil.nowhere.org>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807101702090.19775@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807101702090.19775@engineering.redhat.com> (Mikulas Patocka's message of "Thu, 10 Jul 2008 17:56:08 -0400 (EDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>

Mikulas Patocka <mpatocka@redhat.com> writes:

> I'm getting crashes with InitIO A100u2w controller on Sparc64 (I had
> to fix the endianity issues in the driver, but that's unrelated).

x86-64 (and powerpc) solved this a long time ago by only doing
opportunistic merging: as in don't announce to the block layer
that you can merge, but try to merge anyways. This way SG lists
are not necessarily filled completely, but it's still better
than overflowing them in some rare cases.

-Andi
