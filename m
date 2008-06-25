From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 25 Jun 2008 12:53:10 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
 <486216E7.8000002@aitel.hist.no>
In-Reply-To: <486216E7.8000002@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

On Wed, 25 Jun 2008, Helge Hafting wrote:

> Mikulas Patocka wrote:
>> Hi
>> 
>> Here I'm sending 10 patches to inline various functions.
>> 
>> To give you some understanding of sparc64, every function there uses big 
>> stack frame (at least 192 bytes). 128 bytes are required by architecture 
>> (16 64-bit registers), 48 bytes are there due to mistake of Sparc64 ABI 
>> designers (calling function has to allocate 48 bytes for called function) 
>> and 16 bytes are some dubious padding.
> I guess there is no way around those 128 bytes required by hardware - but
> is it necessary to allocate the 48 bytes of "mistake" and the dubious 
> padding?
>
> Linux kernel functions don't call any outside functions, and are not called 
> from
> outside either. So violating the ABI should be ok - there is nothing else to
> be compatible to. Similiar to how x86 experimented with --mregparm to get
> a little more performance from changing the kernel calling convention. 
> Helge Hafting

So, ask gcc developers to do kernel-specific ABI with only 128-byte stack 
frame.

BTW. could some gcc developer explain the reason for additional 16-bytes 
on stack on sparc64? 64-bit ABI mandates 176 bytes, but gcc allocates 192 
bytes.

Even worse, gcc doesn't use these additional bytes. If you try this:

extern void f(int *i);
void g()
{
         int a;
         f(&a);
}

, it allocates additional 16 bytes for the variable "a" (so there's total 
208 bytes), even though it could place the variable into 48-byte 
ABI-mandated area that it inherited from the caller or into it's own 
16-byte padding that it made when calling "f".

Mikulas
