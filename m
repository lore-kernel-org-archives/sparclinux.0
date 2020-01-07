From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 07 Jan 2020 08:19:53 +0000
Subject: Re: [PATCH v3 02/22] compat: provide compat_ptr() on all architectures
Message-Id: <202001070820.0078K3ZN3264752@mail.zytor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200102145552.1853992-1-arnd@arndb.de> <20200102145552.1853992-3-arnd@arndb.de> <87woa410nx.fsf@mpe.ellerman.id.au> <CAK8P3a17GshP1KmCpvCkWGDGJLC_JrGUFQZTLbfe5+sSwTjyxw@mail.gmail.com>
In-Reply-To: <CAK8P3a17GshP1KmCpvCkWGDGJLC_JrGUFQZTLbfe5+sSwTjyxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Robert Richter <rric@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev@zytor.com

<linuxppc-dev@lists.ozlabs.org>,oprofile-list@lists.sf.net,linux-s390 <linux-s390@vger.kernel.org>,sparclinux <sparclinux@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <41625F06-D755-4C82-86DF-A9415FEEE13D@zytor.com>

On January 7, 2020 12:08:31 AM PST, Arnd Bergmann <arnd@arndb.de> wrote:
>On Tue, Jan 7, 2020 at 3:05 AM Michael Ellerman <mpe@ellerman.id.au>
>wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > +
>> > +static inline compat_uptr_t ptr_to_compat(void __user *uptr)
>> > +{
>> > +     return (u32)(unsigned long)uptr;
>> > +}
>>
>> Is there a reason we cast to u32 directly instead of using
>compat_uptr_t?
>
>Probably Al found this to be more explicit at the time when he
>introduced
>it on all the architectures in 2005. I just moved it here and kept the
>definition.
>
>       Arnd

Did compat_uptr_t exist back then?
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
