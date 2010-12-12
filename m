From: Julian Calaby <julian.calaby@gmail.com>
Date: Sun, 12 Dec 2010 23:09:55 +0000
Subject: Re: [RFC 5/8] sparc: prom: Merge console_*.c into printf.c
Message-Id: <AANLkTi=bOdZbvL1ux7g6r2RnMXL7UCAqJVkx1BDVjay5@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4CF9BC3B.10306@gmail.com>
In-Reply-To: <4CF9BC3B.10306@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 13, 2010 at 09:46, David Miller <davem@davemloft.net> wrote:
> From: Julian Calaby <julian.calaby@gmail.com>
> Date: Sat, 04 Dec 2010 14:57:47 +1100
>
>> prom_console_write_buf() is only used in prom/printf.c, so as it's
>> the only remaining function in console_*.c, let's merge console_*.c
>> into printf.c.
>>
>> We'll also rename prom_nbputchar() to __prom_console_write_buf()
>> and merge the definitions of prom_console_write_buf() as they're
>> identical.
>>
>> Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
>
> This doesn't make sense.
>
> The whole idea is that when there is a 32-bit and 64-bit implementation
> of the same interface, we have foo_32.c and foo_64.c to implement
> them which is exactly what is happening here.

Fair enough.

The reason for these changes were that I feel that having two files
for one function is a little excessive - hence this move.

But that said, #ifdefs are also evil.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
