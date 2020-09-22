From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 22 Sep 2020 16:20:07 +0000
Subject: Re: [PATCH 1/9] kernel: add a PF_FORCE_COMPAT flag
Message-Id: <446566DF-ECBC-449C-92A1-A7D5AEBE9935@amacapital.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CAK8P3a39jN+t2hhLg0oKZnbYATQXmYE2-Z1JkmFyc1EPdg1HXw@mail.gmail.com>
In-Reply-To: <CAK8P3a39jN+t2hhLg0oKZnbYATQXmYE2-Z1JkmFyc1EPdg1HXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Begunkov <asml.silence@gmail.com>, Andy Lutomirski <luto@kernel.org>, Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, "open list:MIPS" <linux-mips@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-s390 <linux-s390@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-aio <linux-aio@kvack.org>, io-uring@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Network Development <netdev@vger.kernel.org>, keyrings@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>



> On Sep 22, 2020, at 2:01 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> ﻿On Tue, Sep 22, 2020 at 9:59 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>> On 22/09/2020 10:23, Arnd Bergmann wrote:
>>> On Tue, Sep 22, 2020 at 8:32 AM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>> On 22/09/2020 03:58, Andy Lutomirski wrote:
>>>>> On Mon, Sep 21, 2020 at 5:24 PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>> I may be looking at a different kernel than you, but aren't you
>>>>> preventing creating an io_uring regardless of whether SQPOLL is
>>>>> requested?
>>>> 
>>>> I diffed a not-saved file on a sleepy head, thanks for noticing.
>>>> As you said, there should be an SQPOLL check.
>>>> 
>>>> ...
>>>> if (ctx->compat && (p->flags & IORING_SETUP_SQPOLL))
>>>>        goto err;
>>> 
>>> Wouldn't that mean that now 32-bit containers behave differently
>>> between compat and native execution?
>>> 
>>> I think if you want to prevent 32-bit applications from using SQPOLL,
>>> it needs to be done the same way on both to be consistent:
>> 
>> The intention was to disable only compat not native 32-bit.
> 
> I'm not following why that would be considered a valid option,
> as that clearly breaks existing users that update from a 32-bit
> kernel to a 64-bit one.
> 
> Taking away the features from users that are still on 32-bit kernels
> already seems questionable to me, but being inconsistent
> about it seems much worse, in particular when the regression
> is on the upgrade path.
> 
>>> Can we expect all existing and future user space to have a sane
>>> fallback when IORING_SETUP_SQPOLL fails?
>> 
>> SQPOLL has a few differences with non-SQPOLL modes, but it's easy
>> to convert between them. Anyway, SQPOLL is a privileged special
>> case that's here for performance/latency reasons, I don't think
>> there will be any non-accidental users of it.
> 
> Ok, so the behavior of 32-bit tasks would be the same as running
> the same application as unprivileged 64-bit tasks, with applications
> already having to implement that fallback, right?
> 
> 

I don’t have any real preference wrt SQPOLL, and it may be that we have a problem even without SQPOLL when IO gets punted without one of the fixes discussed.

But banning the mismatched io_uring and io_uring_enter seems like it may be worthwhile regardless.
