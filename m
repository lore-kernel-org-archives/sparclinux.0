From: "Bart Van Assche" <bart.vanassche@gmail.com>
Date: Thu, 26 Jun 2008 06:32:35 +0000
Subject: Re: [10 PATCHES] inline functions to avoid stack overflow
Message-Id: <e2e108260806252332k3ffe3c63o29556f5b9d89c4a3@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
	 <486216E7.8000002@aitel.hist.no>
	 <Pine.LNX.4.64.0806250843460.20379@engineering.redhat.com>
	 <20080625.150931.182895076.davem@davemloft.net>
In-Reply-To: <20080625.150931.182895076.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, helge.hafting@aitel.hist.no, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org

On Thu, Jun 26, 2008 at 12:09 AM, David Miller <davem@davemloft.net> wrote:
> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Wed, 25 Jun 2008 08:53:10 -0400 (EDT)
>
>> Even worse, gcc doesn't use these additional bytes. If you try this:
>>
>> extern void f(int *i);
>> void g()
>> {
>>          int a;
>>          f(&a);
>> }
>>
>> , it allocates additional 16 bytes for the variable "a" (so there's total
>> 208 bytes), even though it could place the variable into 48-byte
>> ABI-mandated area that it inherited from the caller or into it's own
>> 16-byte padding that it made when calling "f".
>
> The extra 16 bytes of space allocated is so that GCC can perform a
> secondary reload of a quad floating point value.  It always has to be
> present, because we can't satisfy a secondary reload by emitting yet
> another reload, it's the end of the possible level of recursions
> allowed by the reload pass.

Is there any floating-point code present in the Linux kernel ? Would
it be a good idea to add an option to gcc that tells gcc that the
compiled code does not contain floating-point instructions, such that
gcc knows that no space has to be provided for a quad floating point
value ?

Bart.
