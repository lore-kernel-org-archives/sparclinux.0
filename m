From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 03 Jul 2008 21:12:18 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <Pine.LNX.4.64.0807031708280.20244@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
 <20080625.150931.182895076.davem@davemloft.net>
 <Pine.LNX.4.64.0807020032510.19403@engineering.redhat.com>
 <20080701.214507.261426026.davem@davemloft.net>
In-Reply-To: <20080701.214507.261426026.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: helge.hafting@aitel.hist.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

On Tue, 1 Jul 2008, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 2 Jul 2008 00:39:35 -0400 (EDT)
>
>> The ABI is very vague about it. The V9 ABI just displays that 6-word space
>> in a figure bug doesn't say anything about it's usage. The V8 ABI just
>> says that "the function may write incoming arguments there". If it may
>> write anything other, it is unknown --- probably yes, but it is not said
>> in the document.
>>
>> The document nicely specifies who owns which registers, but doesn't say
>> that about the stack space :-(
>
> Actually, I know for a fact that you have to have those slots there.
>
> A long time ago in the sparc64 kernel, in the trap entry code, I tried
> only giving 128 bytes of stack frame as the trap entry called into C
> code.  And it did not work, I had to put the 6 slots there.

The bad thing is that gcc can't use those slots optimally. If you have for 
example:

void f(int *x)
{
}

void g()
{
 	int a;
 	f(&a);
}

void h()
{
 	g();
}

Then the variable "a" can't be placed into one of the 6 implicit slots for 
g->f call (beacuse "f" may overwrite that slot). But "a" could be placed 
into one of those 6 slots that "h" allocates for "g" (because these slots 
are owned by "g"). But it isn't --- additional place is allocated for "a" 
:-/

Mikulas
