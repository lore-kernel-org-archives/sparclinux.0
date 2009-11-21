From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Sat, 21 Nov 2009 05:54:44 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091121065444.B29210@linux.karinthy.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Nov 20, 2009 at 09:43:46PM -0800, David Miller wrote:
> From: Laszlo Valko <valko@linux.karinthy.hu>
> Date: Sat, 21 Nov 2009 05:47:43 +0100
> 
> > Does it help if I try to narrow this down both the kernel version
> > introducing this, and the minimum set of config options with which I
> > can still reproduce it?
> 
> The most useful thing would be if you could use GIT to
> bisect down to the exact commit which introduced the
> problem.

Okay, I'm almost done with the config options (almost everything is off,
except for a few cpu & memory flags, and I still get the freeze, I
switched everything off, now it ends after
[  103.151812] turn off boot console earlyprom0
probably I managed to get rid of the console device :),
if you give me some advice on how to use git, I can probably manage it.

Regards,
Laszlo

