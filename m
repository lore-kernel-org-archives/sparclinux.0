From: "David S. Miller" <davem@redhat.com>
Date: Tue, 03 Feb 2004 23:20:51 +0000
Subject: Re: Was:  Problems with bridging on Sparc64
Message-Id: <20040203152051.2500d47d.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200402031553.44155.crn@netunix.com>
In-Reply-To: <200402031553.44155.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 3 Feb 2004 23:02:40 +0000
"C.Newport" <crn@netunix.com> wrote:

> You mention both sparc v9 and sparc64. 
> AIUI v9 is the Sun Ultrasparc and sparc64 is the slightly different
> Fujitsu processor. We seem to refer to both under the confusing
> sparc64 header, but I do not see much testing happening on Fujitsu
> stuff. Am I misunderstanding the situation or should we consider
> getting the naming sorted out ?.
> Does anyone even have a Sparc64 (Fujitsu) machine working ?.

When we speak of sparc64 we simply mean the 64-bit Sparc userland
ABI.  When we say v9 we mean sparc 32-bit ABI plus availability of
the Sparc v9 instructions.

Someone inside Fujitsu at some point got the most recent Fujitsu
chips working (they are very close, MMU/Cache programming wise,
to UltraSPARC unlike the initial fujistu 64-bit sparcs) but they
never submitted a final patch to me and all that stuff is pretty
dead these days anyways :)
