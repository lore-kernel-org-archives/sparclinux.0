From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 05 Jan 2009 20:07:58 +0000
Subject: Re: [PATCH] sparc: make proces_ver_nack a bit more readable
Message-Id: <20090105200758.GC6204@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com> <alpine.DEB.1.10.0901051437490.27085@gandalf.stny.rr.com> <alpine.DEB.1.10.0901051455510.25066@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901051455510.25066@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>

On Mon, Jan 05, 2009 at 02:56:58PM -0500, Steven Rostedt wrote:
> 
> On Mon, 5 Jan 2009, Steven Rostedt wrote:
> 
> > 
> > Impact: clean up
> > 
> > The code in process_ver_nack is a little obfuscated. This change
> > makes it a bit more readable by humans. It removes the complex
> > if statement and replaces it with a cleaner flow of control.
> > 
> > Signed-off-by: Steven Rostedt <srostedt@redhat.com>
> 
> Sam,
> 
> Can you test to see if this patch makes the issue go away. Obviously, Dave 
> would need to be the one to pull it in, or at least ack it.

As expected the patch silence the warning.
The warning only triggers when we have an assignment
after a boolean || inside an if condition.

	Sam
