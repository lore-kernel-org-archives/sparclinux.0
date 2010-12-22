From: Jiri Gaisler <jiri@gaisler.com>
Date: Wed, 22 Dec 2010 09:51:05 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <4D11CA09.60106@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



Alex Buell wrote:
> On Tue, 2010-12-21 at 19:54 -0800, David Miller wrote:
>>> We are thinking of switching the LEON port to use CASA (compare and
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

The CASA is only necessary for SMP systems, as the current irq15
solution will NOT work on sparc32-SMP. So falling back on irq15
when CASA is not present is not really an option, as it will lead
to a deadlock sooner or later ...
