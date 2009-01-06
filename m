From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 20:46:54 +0000
Subject: Re: [PATCH] sparc64: refactor code in viohs.c
Message-Id: <20090106.124654.196952162.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106201742.GA17714@uranus.ravnborg.org>
In-Reply-To: <20090106201742.GA17714@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 6 Jan 2009 21:17:42 +0100

> The sparc64 allmodconfig build broke due to enabling of the
> branch_tracer that does some very clever things with
> all if conditions. This caused my gcc 3.4.5 to be so confused that
> it emitted a warning:
> 
> arch/sparc/kernel/viohs.c: In function `vio_control_pkt_engine':
> arch/sparc/kernel/viohs.c:335: warning: 'nver' might be used uninitialized in this function
> 
> And with -Werror this broke the build.
> 
> Refactor code so it:
> 1) becomes more readable
> 2) no longer emit a warning with the branch_tracer enabled
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
