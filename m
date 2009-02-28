From: Greg KH <greg@kroah.com>
Date: Sat, 28 Feb 2009 17:46:01 +0000
Subject: Re: [stable] [PATCH 2/2] x86-64: seccomp: fix 32/64 syscall hole
Message-Id: <20090228174601.GB27607@kroah.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090228030226.C0D34FC3DA@magilla.sf.frob.com> <20090228030413.5B915FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902271932520.3111@localhost.localdomain> <alpine.LFD.2.00.0902271948570.3111@localhost.localdomain> <20090228072554.CFEA6FC3DA@magilla.sf.frob.com> <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.0902280916470.3111@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Roland McGrath <roland@redhat.com>, linux-mips@linux-mips.org, x86@kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, stable@kernel.org

On Sat, Feb 28, 2009 at 09:23:36AM -0800, Linus Torvalds wrote:
> On Fri, 27 Feb 2009, Roland McGrath wrote:
> > But here is the patch you asked for.
> 
> Yes, this looks much more straightforward. 
> 
> And I guess the seccomp interaction means that this is potentially a 
> 2.6.29 thing. Not that I know whether anybody actually _uses_ seccomp. It 
> does seem to be enabled in at least Fedora kernels, but it might not be 
> used anywhere.

It's enabled in SuSE kernels.

thanks,

greg k-h
