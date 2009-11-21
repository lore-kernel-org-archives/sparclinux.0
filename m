From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 21 Nov 2009 12:10:06 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091121121006.GB26495@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Nov 20, 2009 at 03:58:16PM -0800, David Miller wrote:
> >> Somone has a remote console setup for me to diagnose this remotely
> >> since none of my own systems trigger this behavior.
> > 
> > Is this the same NMI watchdog issue that I reported with v240?
> 
> No, it's the one where the system hangs in the middle of firing
> a uevent after the first device registers.
> 
> > Is that last sentence incomplete (s/has/has to do/)?
> 
> No it is not, Hermann Lauer is the person who has set this
> up for me.

OK. Just in case, if you're interested, I can give you access to our v240s
regarding that other problem.

-- 
     2. That which causes joy or happiness.
