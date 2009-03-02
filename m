From: Roland McGrath <roland@redhat.com>
Date: Mon, 02 Mar 2009 01:44:23 +0000
Subject: Re: [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090302014423.22A6FFC3C6@magilla.sf.frob.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com>
	<20090228030413.5B915FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902271932520.3111@localhost.localdomain>
	<alpine.LFD.2.00.0902271948570.3111@localhost.localdomain>
	<20090228072554.CFEA6FC3DA@magilla.sf.frob.com>
	<alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
In-Reply-To: Linus Torvalds's message of  Saturday, 28 February 2009 09:23:36 -0800 <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, linux-mips@linux-mips.org, sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org

> And I guess the seccomp interaction means that this is potentially a 
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
> does seem to be enabled in at least Fedora kernels, but it might not be 
> used anywhere.

I have no idea who uses it.  I just assume that anyone who is using it
might be expecting it to be reliable for security purposes as advertised.


Thanks,
Roland
