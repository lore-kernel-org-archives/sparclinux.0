From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 16 Aug 2017 08:42:43 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <CADxRZqyqP9rxG06+wYo12NxprWT5m8=so-L7uVwSWv1Vuaxuvw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Aug 16, 2017 at 7:30 AM, David Miller <davem@davemloft.net> wrote:
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Tue, 15 Aug 2017 21:50:45 +0300
>
>> Together with Dmitry (ldv) , we've discovered that running test suite
>> from strace produces kernel OOPS, when kernel is compiled with gcc 7.1
>> or with gcc 7.2 , but not with gcc 6 :
>
> Please try this patch:

Dave,

this patch fixes OOPS, thanks. Tested on ldom (gcc 7.2, git kernel +
patch, git strace).
Going to check with sun sparc v215 (sun4u), but it would take some
time to compile patched kernel...
