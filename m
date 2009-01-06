From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 18:23:33 +0000
Subject: Re: [PATCH] sparc: make proces_ver_nack a bit more readable
Message-Id: <20090106.102333.261099461.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com>
	<alpine.DEB.1.10.0901051437490.27085@gandalf.stny.rr.com>
	<20090105200848.GD6204@uranus.ravnborg.org>
In-Reply-To: <20090105200848.GD6204@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, srostedt@redhat.com, mingo@elte.hu, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 5 Jan 2009 21:08:48 +0100

> On Mon, Jan 05, 2009 at 02:42:59PM -0500, Steven Rostedt wrote:
> > 
> > Impact: clean up
> > 
> > The code in process_ver_nack is a little obfuscated. This change
> > makes it a bit more readable by humans. It removes the complex
> > if statement and replaces it with a cleaner flow of control.
> > 
> > Signed-off-by: Steven Rostedt <srostedt@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> 
> And I can confirm the warning has dismissed with this patch.

Applied, thanks everyone.
