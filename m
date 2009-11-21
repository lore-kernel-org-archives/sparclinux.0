From: Josip Rodin <joy@entuzijast.net>
Date: Sat, 21 Nov 2009 12:09:01 +0000
Subject: Re: 2.6.31.6 freezes on v210
Message-Id: <20091121120901.GA26495@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20091120210249.A20906@linux.karinthy.hu>
In-Reply-To: <20091120210249.A20906@linux.karinthy.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Nov 21, 2009 at 06:54:44AM +0100, Laszlo Valko wrote:
> Okay, I'm almost done with the config options (almost everything is off,
> except for a few cpu & memory flags, and I still get the freeze, I
> switched everything off, now it ends after
> [  103.151812] turn off boot console earlyprom0
> probably I managed to get rid of the console device :),

This sounds like CONFIG_PROM_CONSOLE which you should disable in any
version (it was later removed).

> if you give me some advice on how to use git, I can probably manage it.

Get a tree like this:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6-stable.git

(That is going to take some time.)

Then follow the instructions manual page git-bisect(1)
http://www.kernel.org/pub/software/scm/git/docs/git-bisect.html

If you confirmed that the last good version was 2.6.28, and that the next
stable release and all after that are bad, it looks like you may want to
use a sequence like this:

git checkout v2.6.29
git bisect start
git bisect bad
git bisect good v2.6.28

You will then get the checkout in a state where it's half-way between those
two. Compile that (make) and install it (something like
gzip -c vmlinux > vmlinuz; sudo installkernel 2.6.29-rc3 vmlinuz System.map;
adjust that version as it happens in the current Makefile).

Make sure silo.conf is set up to enable you to go back, and then boot the
newly-compiled version. If it works, come back into the git tree and issue
'git bisect good'; if it doesn't, boot the previous kernel and do
'git bisect bad'. Either action will shift the checkout halfway again,
but in a different direction. Then recompile again, install, test.
Eventually you will get it down to a single commit.

-- 
     2. That which causes joy or happiness.
