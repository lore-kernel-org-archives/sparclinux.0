From: Anatoly Pugachev <matorola@gmail.com>
Date: Tue, 15 Aug 2017 20:35:16 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <CADxRZqxdvMy-Wt6MF4k0yVZ9MXWar9Z5rNoqy3x2ezOaBYMn7Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Aug 15, 2017 at 11:08 PM, Sam Ravnborg <sam@ravnborg.org> wrote:
> Hi Anatoly.
>
> On Tue, Aug 15, 2017 at 09:50:45PM +0300, Anatoly Pugachev wrote:
>> Hello.
>>
>> Together with Dmitry (ldv) , we've discovered that running test suite
>> from strace produces kernel OOPS, when kernel is compiled with gcc 7.1
>> or with gcc 7.2 , but not with gcc 6 :
>
> First, could you please verify if you have following fix in your kernel.
> This fixed a similar oops when runnign strace test suite.
> And was only seen on ultrasparc-III
>
>         Sam
>
>
>
> commit 0ede1c401332173ab0693121dc6cde04a4dbf131
> Author: David S. Miller <davem@davemloft.net>
> Date:   Fri Aug 4 09:47:52 2017 -0700
>
>     sparc64: Fix exception handling in UltraSPARC-III memcpy.

Sam,

it is in the git tree I'm using to compile kernel :
$ git show -s --oneline 0ede1c401332173ab0693121dc6cde04a4dbf131
0ede1c401332 sparc64: Fix exception handling in UltraSPARC-III memcpy.
