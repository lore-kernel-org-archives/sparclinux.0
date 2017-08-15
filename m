From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 Aug 2017 20:08:48 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <20170815200848.GA23474@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Anatoly.

On Tue, Aug 15, 2017 at 09:50:45PM +0300, Anatoly Pugachev wrote:
> Hello.
> 
> Together with Dmitry (ldv) , we've discovered that running test suite
> from strace produces kernel OOPS, when kernel is compiled with gcc 7.1
> or with gcc 7.2 , but not with gcc 6 :

First, could you please verify if you have following fix in your kernel.
This fixed a similar oops when runnign strace test suite.
And was only seen on ultrasparc-III

	Sam



commit 0ede1c401332173ab0693121dc6cde04a4dbf131
Author: David S. Miller <davem@davemloft.net>
Date:   Fri Aug 4 09:47:52 2017 -0700

    sparc64: Fix exception handling in UltraSPARC-III memcpy.

    Mikael Pettersson reported that some test programs in the strace-4.18
    testsuite cause an OOPS.

    After some debugging it turns out that garbage values are returned
    when an exception occurs, causing the fixup memset() to be run with
    bogus arguments.

    The problem is that two of the exception handler stubs write the
    successfully copied length into the wrong register.

    Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
    Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
    Tested-by: Mikael Pettersson <mikpelinux@gmail.com>
    Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

