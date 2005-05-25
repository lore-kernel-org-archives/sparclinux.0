From: Chris Newport <crn@netunix.com>
Date: Wed, 25 May 2005 23:37:39 +0000
Subject: Re: NR_CPUS and kernel 2.4.30 for sparc64
Message-Id: <42950C43.6030106@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4294E414.80003@wp.pl>
In-Reply-To: <4294E414.80003@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Krzysztof Helt wrote:

> You must set CONFIG_NR_CPUS to one plus the largest "physical cpu"
>
>> number in your machine if you want all processors to be detected
>> properly.  In your case, the correct setting would be 3.
>
>
> This works differnetly than on sparc32 kernel (it works there).
>
It works on Sun4m because all of the processors are confined to a single 
system board.
On Sun4d and Sun4u you can have multiple system boards.
CPU0 is the first CPU slot in the first system board slot. There is no 
universal requirement that any slot is filled [1], so if the only system 
board on an E10k is in slot 15 the 4 possible processors will be numbers 
60 to 63.

Think of it as "how many places do I look to find a possible CPU before 
giving up".
32 is a safe choice on all except the biggest machines and it is wise to 
not change this default unless you have some big iron.

[1] Not strictly true - some versions of the OBP require a CPU to exist 
on board 0 cpu 0.  Some other versions require a CPU to exist in the 
first CPU slot of the first occupied board slot. YMMV. Here be dragons.

