From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 06:39:01 +0000
Subject: Re: [4/3] fix initrd memcpy
Message-Id: <20041221063901.GF771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221045627.GC771@holomorphy.com>
In-Reply-To: <20041221045627.GC771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 20 Dec 2004 20:56:27 -0800 William Lee Irwin III wrote:
>> The latter hunk of the forwarded patch has already been applied, so
>> please apply the patch as it appears in the un-forwarded part. I've
>> taken some liberties in adding the Acked/Signed-off lines in what I
>> hope is an agreeable way.
>
On Mon, Dec 20, 2004 at 10:28:38PM -0800, David S. Miller wrote:
> For this one it may be advisable to kill this silly attempt
> to optimize constant count memcpy()'s.  GCC knows very well
> when to do a __builtin_memcpy() expansion vs. a real memcpy
> call.
> All the memcpy --> __memcpy is doing is making it so that the
> memcpy assembler doesn't need to retain and return the original
> destination pointer argument.
> Sparc64 was doing silly stuff like this too, and it simplified
> things a lot to just kill all of these macroized optimizations.
> I did that as follows:

This looks tremendously cleaner. I'll look for an ack to see if there
are actively participating users lingering about with toolchains that
do something unintelligible out of paranoia and then send an analogue
of this upstream.


-- wli
