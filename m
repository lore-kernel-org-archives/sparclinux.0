From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 06 Aug 2007 17:38:51 +0000
Subject: Help understanding SPARC32 Sun4c PTE handling
Message-Id: <Pine.LNX.4.61.0708061749230.29956@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-mm@kvack.org

Hi David,

If you have the time ..., if not, hopfully, some one from linux-mm will 
explain.

I have been investigating the differences between SunOS PTE and Linux PTE 
bits. There are some differences that I would like to understand.

What is the pte_file() function intended for. The bit in the PTE that
is used (0x02000000) is set by hardware (definatly on page write and in 
theory on page read if the SunOS PTE description is to be believed. It 
is described as the 'refferenced' bit).

The linux-mm documentation only states that it is for swappable non-linear 
VMAs (exactly what we have in the sun4c unless you assume VMA is signed 
[like the INMOS Transputer], in which case it is linear from -512MB to 
+512MB :-). The down size of sigend address mappings is that NULL is 
nolonger zero and too many people have got lazy and assumed it is.).

Re-arranging the bits so that _SUN4C_PAGE_ACCESSED and 
_SUN4C_PAGE_MODIFIED bits match the MMU hardware bits seems to make boots 
more stable (I have been gettimg non-repeatable boots where the init 
script goes through the motions but does not actually do what I am 
expecting or just gets skipped. SLAB is worse than SLUB.) but the changes 
I have tried sofar, break swapon.

Linux uses four bits that do not get saved in the MMU PTE 
(_SUN4C_PAGE_READ, _SUN4C_PAGE_WRITE, _SUN4C_PAGE_MODIFIED and 
_SUN4C_PAGE_ACCESSED). I have assumed that these are preserved externally 
in a software copy of the PTE somewhere (I have not found anything that I 
recognise as specific storage for this in the sparc32 code) as reading the 
MMU PTE will return zero for these bits.

Regards
 	Mark Fortescue.

