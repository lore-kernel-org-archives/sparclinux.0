From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Dec 2009 20:25:37 +0000
Subject: Re: [PATCH 1/2] sparc: us3_cpufreq.c: fix warnings/errors
Message-Id: <20091221202537.GA21978@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
In-Reply-To: <1261311396-609-1-git-send-email-a.beregalov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 21, 2009 at 12:14:11PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 21 Dec 2009 20:59:21 +0100
> 
> > As the comment says:
> > "Don't use BUG() or BUG_ON() unless there's really no way out;"
> > 
> > I would have expected to see something like this:
> > #define BUG() do {} while(1)
> 
> Maybe we can use "unreachable()" here.
Makes sense.

Alexander - could you please try to add an
unreachable() call in in bug.h and if it
kills the warnings as expected then send
a patch to Arnd including a proper
changelog describing why this was need.

I copied Arnd on this mail albeit he may miss some context...
In short - Alexandar posted a few patches to get rid of
a set of warnings on sparc.
The root cause of the warnings was the definition of
BUG() when CONFIG_BUG is not set.

	Sam
