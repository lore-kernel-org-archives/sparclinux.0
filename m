From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Tue, 29 May 2007 20:10:53 +0000
Subject: Re: [PATCH] Linux always started with 9600 8N1
Message-Id: <Pine.LNX.4.61.0705292208380.11140@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <20070526.154745.30164056.davem@davemloft.net>
 <Pine.LNX.4.61.0705271816310.7344@yvahk01.tjqt.qr> <20070527.141622.30184020.davem@davemloft.net>
 <20070527.144702.55507425.davem@davemloft.net>
In-Reply-To: <20070527.144702.55507425.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org


On May 27 2007 14:47, David Miller wrote:
>
>> So even writes to so-called 'read-only' sections of the kernel image
>> will work and therefore I don't understand what the bug could be other
>> than the compiler "optimizing" away the write to the constant string
>> in which case the compiler should have warned about it.
>
>I just stared at the drivers/serial/suncore.s assembler a little
>bit and this is indeed what appears to be happening, the compiler
>is optimizing the stores away completely yet not doing so much
>as emitting a warning, how rude :-)

I do not think it can throw a meaningful warning. After all, whether
dereferencing and writing to a char* actually touches

(a) rw memory
(b) ro memory
(c) rw memory which we'd like to be ro ;-)

is not known to the compiler. Of course, one may add more complicated
code to cover simple cases like the one in suncore.c, but that may
as well just gives us more can't-figure-out-correctly-on-my-own warnings
like "possible uninitialized value used" (int n; set_n(&n); use_n(n);) /
where adding more code to cover all detectable cases increases complexity
too much.


	Jan
-- 
