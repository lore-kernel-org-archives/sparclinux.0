From: David Miller <davem@davemloft.net>
Date: Wed, 16 Aug 2017 16:27:08 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <20170816.092708.76794023398287315.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 16 Aug 2017 11:42:43 +0300

> On Wed, Aug 16, 2017 at 7:30 AM, David Miller <davem@davemloft.net> wrote:
>> From: Anatoly Pugachev <matorola@gmail.com>
>> Date: Tue, 15 Aug 2017 21:50:45 +0300
>>
>>> Together with Dmitry (ldv) , we've discovered that running test suite
>>> from strace produces kernel OOPS, when kernel is compiled with gcc 7.1
>>> or with gcc 7.2 , but not with gcc 6 :
>>
>> Please try this patch:
> 
> Dave,
> 
> this patch fixes OOPS, thanks. Tested on ldom (gcc 7.2, git kernel +
> patch, git strace).

Thanks for testing.
