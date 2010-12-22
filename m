From: David Miller <davem@davemloft.net>
Date: Wed, 22 Dec 2010 19:53:15 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <20101222.115315.112600041.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alex Buell <alex.buell@munted.org.uk>
Date: Wed, 22 Dec 2010 09:19:04 +0000

> On Tue, 2010-12-21 at 19:54 -0800, David Miller wrote:
>> > We are thinking of switching the LEON port to use CASA (compare and
>> swap), just like in the sparc64 port. Most newer leon3/4 processors
>> implement CASA, even if the instruction belongs to sparc V9 and not
>> V8. Would a patch like that be accepted (for the LEON port only)? This
>> will not fix the SMP for general sparc32 (which really is broken), but
>> it would fix it for LEON.
>> 
>> It should be fine as long as the patches are clean enough. 
> 
> Rather than specialising it for LEON, why not just test for CASA
> availability and use it if it available?

Run time detection of this is going to really be terrible.

Lots of cmpxchg() uses are inline, and we'll have to implement
it out-of-line and patch the call instructions dynamically.

LEON is the only chip that can do the instruction and we already
do a special LEON specific build.
