From: Bob Breuer <breuerr@mc.net>
Date: Wed, 12 Jan 2005 03:56:07 +0000
Subject: Re: Current BK kernel error
Message-Id: <41E4A172.6050308@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050111143605.GC4514@artsapartment.org>
In-Reply-To: <20050111143605.GC4514@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
> On Tue, Jan 11, 2005 at 08:36:05AM -0600, Art Haas wrote:
> 
>>A pull of the current BK kernel failed to build, with an error in
>>mm/memory.c about pte_read() not being defined. This function was added
...
>>The pte_read() function is defined at include/asm-sparc64/pgtable.h for
>>64-bit Sparc, but is not defined for 32-bit Sparc. Anyone taken a shot
>>at making a patch for this yet?
> 
> 
> According to Bob Breuer, returning 1 always seems to work for ordinary
> userspace (as opposed to "unusual" programs). I've got documentation,
> so I'll brew up something more accurate for it over the weekend.
> 

Yes, the easy way out is to return 1 from pte_read.  To do it right we will 
need a combined solution for sun4c and sun4m.  I think that sun4 can use the 
sun4c version and sun4d will share with sun4m.

For sun4c, we can use the software managed read bit:
	return pte_val(pte) & _SUN4C_PAGE_READ;
I can't test this myself, but it mirrors the pte_write functionality.

For sun4m, there is no software bit for read, so we peek at the hardware ACC 
field from the pte:
	return !(pte_val(pte) & 0x10);
We need a #define to go with the new usage of this bit, maybe SRMMU_NOREAD?

I have tested the sun4m solution on my SS20 and it works for me.
Now, how can these be combined using the btfixup magic?

Bob
