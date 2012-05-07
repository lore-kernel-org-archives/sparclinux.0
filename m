From: Julian Calaby <julian.calaby@gmail.com>
Date: Mon, 07 May 2012 23:07:34 +0000
Subject: Re: sparc sun4c support - time to drop it?
Message-Id: <CAGRGNgVXtc0C-Y4=Tojoh48Zo8Umb6R1PUm+LGTDqa5SNQbnJA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20120505162104.GA14563@merkur.ravnborg.org>
In-Reply-To: <20120505162104.GA14563@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Sam,

On Tue, May 8, 2012 at 3:46 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Sat, May 05, 2012 at 06:21:04PM +0200, Sam Ravnborg wrote:
> Also considering that sun4c support has been broken for
> some time and there is a few changes pending where sun4c
> does not make things simpler we will drop sun4c support.
>
> I already took a quick look at it and in the process
> I think I uncovered a bug in NMI handling for sun4m
> in UP mode. We would call the sun4c nmi trap despite
> being a sun4m box - this would not go well.
>
> When I have something tested I will forward my
> patches.

Would it be possible to hide sun4c away behind a kconfig variable that
is marked as BROKEN with a entry in the feature-removal file?

Or is that just too much work for code which has been broken for a long time.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
