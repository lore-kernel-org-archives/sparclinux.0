From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 26 Nov 2008 11:05:57 +0000
Subject: Re: CONFIG_SUN_AUXIO no longer needed
Message-Id: <20081126110557.GA27053@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20081117183413.GA29770@uranus.ravnborg.org>
In-Reply-To: <20081117183413.GA29770@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Nov 26, 2008 at 12:52:43AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 17 Nov 2008 19:34:13 +0100
> 
> > While looking at sparc/kernel/MAkefile I noticed
> > that CONFIG_SUN_AUXIO was used to determine if auxio.o was
> > included in the link or not.
> > 
> > But in the Kconfig we have:
> > 
> > config SUN_AUXIO
> > 	bool
> > 	default y
> > 
> > So SUN_AUXIO is always enabled and it can be killed.
> > Following patch does this but serves as example only.
> > If it can be killed I will take care after the merge
> > of sparc and sparc64 has finished.
> > 
> > Did I miss something obvious or is it just something
> > awaiting cleaning up?
> 
> Yes, it can die.

OK. I wil take care.

	Sam
