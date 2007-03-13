From: David Miller <davem@davemloft.net>
Date: Tue, 13 Mar 2007 08:48:39 +0000
Subject: Re: [PATCH] sparc: avoid CHILD_MAX and OPEN_MAX constants
Message-Id: <20070313.014839.130237444.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070313082528.E00F51801C5@magilla.sf.frob.com>
In-Reply-To: <20070313082528.E00F51801C5@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Roland McGrath <roland@redhat.com>
Date: Tue, 13 Mar 2007 01:25:28 -0700 (PDT)

> I don't figure anyone really cares about SunOS syscall emulation, and I
> certainly don't.  But I'm getting rid of uses of the OPEN_MAX and CHILD_MAX
> compile-time constant, and these are almost the only ones.  OPEN_MAX is a
> bogus constant with no meaning about anything.  The RLIMIT_NOFILE resource
> limit is what sysconf (_SC_OPEN_MAX) actually wants to return.
> 
> The CHILD_MAX cases weren't actually using anything I want to get rid of,
> but I noticed that they are there and are wrong too.  The CHILD_MAX value
> is not really unlimited as a -1 return from sysconf indicates.  The
> RLIMIT_NPROC resource limit is what sysconf (_SC_CHILD_MAX) wants to return.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>

Thanks Roland, I'll apply this soon.
