From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 30 Mar 2013 22:01:14 +0000
Subject: Re: [PATCH 5/5] sparc: sort select lines in Kconfig
Message-Id: <20130330220114.GA4507@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1364679866-29982-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1364679866-29982-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Mar 30, 2013 at 05:47:35PM -0400, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sat, 30 Mar 2013 22:44:26 +0100
> 
> > Sorting the lines is better than the random order used today.
> > And it may result in a less merge confilct (in theory).
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I've just been sticking new entries at random locations
> to handle that issue.
> 
> I don't really see any value to this.
The random order irritated my eye. And made it harder to spot eventual duplicates.
I also considered using the inverse christmas tree sorting used for include files.

Anyway - ignored.

	Sam
