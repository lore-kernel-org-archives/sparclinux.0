From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 19 Jan 2011 18:13:42 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <1295460822.12215.1389.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1295382144.12215.123.camel@gandalf.stny.rr.com>
	 <20110119050844.GA8776@Krystal>
	 <20110118.223247.241909079.davem@davemloft.net>
	 <20110118.232045.58440904.davem@davemloft.net>
	 <1295451961.12215.1291.camel@gandalf.stny.rr.com>
	 <20110119161534.GB15031@Krystal>
In-Reply-To: <20110119161534.GB15031@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

On Wed, 2011-01-19 at 11:15 -0500, Mathieu Desnoyers wrote:
> * Steven Rostedt (rostedt@goodmis.org) wrote:
> > After applying David's "remove align" patch, I got it to boot on x86_64
> > with the following two patches. I thought just adding the "align" to the
> > structure declaration would work, but it still failed on the syscall for
> > init_module. By removing the double "declaration" of event_exit_##sname,
> > removed this problem.
> > 
> > I'll test this on x86 32bit and PPC 64. If it works there, I'll push all
> > of them out for 38. Should these go to 37 stable too?
> 
> Please hold before adding these patches into git. They don't seem to address the
> underlying problem correctly. See the latest exchanges between David Miller and
> myself for more info.
> 
> We need to come up with something better than "it boots" as an explanation for
> the fix.

Yes, I agree that we should solve this issue correctly. But if there is
a work around to the problem, we could implement that if the real
solution is not in our grasp yet.

-- Steve


